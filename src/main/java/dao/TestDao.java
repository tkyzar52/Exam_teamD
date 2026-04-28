package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import bean.School;
import bean.Student;
import bean.Subject;
import bean.Test;

public class TestDao extends Dao {

    private List<Test> postFilter(ResultSet rSet, School school) throws Exception {
        List<Test> list = new ArrayList<>();
        StudentDao stuDao = new StudentDao();
        SubjectDao subDao = new SubjectDao();
        while (rSet.next()) {
            Test test = new Test();
            test.setStudent(stuDao.get(rSet.getString("student_no")));
            test.setSubject(subDao.get(rSet.getString("subject_cd"), school));
            test.setSchool(school);
            test.setNo(rSet.getInt("no"));
            test.setPoint(rSet.getInt("point"));
            test.setClassNum(rSet.getString("class_num"));
            list.add(test);
        }
        return list;
    }

    public List<Test> filter(int entYear, String classNum, Subject subject, int num, School school) throws Exception {
        List<Test> list = new ArrayList<>();
        Connection connection = getConnection();
        PreparedStatement statement = null;

        String sql = "SELECT s.no as student_no, s.name as student_name, s.ent_year, s.class_num, t.point, t.no as test_no " +
                     "FROM student s " +
                     "LEFT JOIN test t ON s.no = t.student_no AND t.subject_cd = ? ";
        
        if (num > 0) {
            sql += "AND t.no = ? ";
        }

        sql += "WHERE s.ent_year = ? AND s.class_num = ? AND s.school_cd = ? AND s.is_attend = true " +
               "ORDER BY s.no ASC, t.no ASC";

        try {
            statement = connection.prepareStatement(sql);
            statement.setString(1, subject.getCd());
            
            if (num > 0) {
                statement.setInt(2, num);
                statement.setInt(3, entYear);
                statement.setString(4, classNum);
                statement.setString(5, school.getCd());
            } else {
                statement.setInt(2, entYear);
                statement.setString(3, classNum);
                statement.setString(4, school.getCd());
            }

            ResultSet rSet = statement.executeQuery();

            while (rSet.next()) {
                Test test = new Test();
                Student student = new Student();
                student.setNo(rSet.getString("student_no"));
                student.setName(rSet.getString("student_name"));
                student.setEntYear(rSet.getInt("ent_year"));
                student.setClassNum(rSet.getString("class_num"));
                test.setStudent(student);
                test.setSubject(subject);
                test.setSchool(school);
                
                int tNo = rSet.getInt("test_no");
                test.setNo(rSet.wasNull() ? num : tNo);

                int p = rSet.getInt("point");
                test.setPoint(rSet.wasNull() ? -1 : p);
                
                test.setClassNum(rSet.getString("class_num"));
                list.add(test);
            }
        } finally {
            if (statement != null) statement.close();
            if (connection != null) connection.close();
        }
        return list;
    }

    public List<Test> filter(Student student) throws Exception {
        Connection connection = getConnection();
        PreparedStatement statement = null;
        try {
            statement = connection.prepareStatement("select * from test where student_no=? order by subject_cd asc, no asc");
            statement.setString(1, student.getNo());
            ResultSet rSet = statement.executeQuery();
            return postFilter(rSet, student.getSchool());
        } finally {
            if (statement != null) statement.close();
            if (connection != null) connection.close();
        }
    }
    
    public Test get(Student student, Subject subject, int no) throws Exception {
        Test test = null;
        Connection connection = getConnection();
        PreparedStatement statement = null;
        try {
            statement = connection.prepareStatement("select * from test where student_no=? and subject_cd=? and no=? and school_cd=?");
            statement.setString(1, student.getNo());
            statement.setString(2, subject.getCd());
            statement.setInt(3, no);
            statement.setString(4, student.getSchool().getCd());
            ResultSet rSet = statement.executeQuery();
            if (rSet.next()) {
                test = new Test();
                test.setStudent(student);
                test.setSubject(subject);
                test.setNo(rSet.getInt("no"));
                test.setPoint(rSet.getInt("point"));
            }
        } finally {
            if (statement != null) statement.close();
            if (connection != null) connection.close();
        }
        return test;
    }

    public void save(List<Test> list) throws Exception {
        for (Test test : list) save(test);
    }

    public boolean save(Test test) throws Exception {
        Connection connection = getConnection();
        PreparedStatement statement = null;
        try {
            Test old = get(test.getStudent(), test.getSubject(), test.getNo());
            if (old == null) {
                statement = connection.prepareStatement("insert into test (student_no, subject_cd, school_cd, no, point, class_num) values (?, ?, ?, ?, ?, ?)");
                statement.setString(1, test.getStudent().getNo());
                statement.setString(2, test.getSubject().getCd());
                statement.setString(3, test.getSchool().getCd());
                statement.setInt(4, test.getNo());
                statement.setInt(5, test.getPoint());
                statement.setString(6, test.getClassNum());
            } else {
                statement = connection.prepareStatement("update test set point=? where student_no=? and subject_cd=? and no=? and school_cd=?");
                statement.setInt(1, test.getPoint());
                statement.setString(2, test.getStudent().getNo());
                statement.setString(3, test.getSubject().getCd());
                statement.setInt(4, test.getNo());
                statement.setString(5, test.getSchool().getCd());
            }
            return statement.executeUpdate() > 0;
        } finally {
            if (statement != null) statement.close();
            if (connection != null) connection.close();
        }
    }
    public boolean delete(Test test) throws Exception {
        Connection connection = getConnection();
        PreparedStatement statement = null;
        try {
            statement = connection.prepareStatement("delete from test where student_no=? and subject_cd=? and no=? and school_cd=?");
            statement.setString(1, test.getStudent().getNo());
            statement.setString(2, test.getSubject().getCd());
            statement.setInt(3, test.getNo());
            statement.setString(4, test.getSchool().getCd());
            
            return statement.executeUpdate() > 0;
        } finally {
            if (statement != null) statement.close();
            if (connection != null) connection.close();
        }
    }
    
    //fix
    
    public boolean delete(Subject subject) throws Exception {
        Connection connection = getConnection();
        PreparedStatement statement = null;
        try {
            statement = connection.prepareStatement(
                "delete from subject where cd = ? and school_cd = ?");
            statement.setString(1, subject.getCd());
            statement.setString(2, subject.getSchool().getCd());
            return statement.executeUpdate() > 0;
        } finally {
            if (statement != null) statement.close();
            if (connection != null) connection.close();
        }
    }
}