package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import bean.Student;
import bean.TestListStudent;

public class TestListStudentDao extends Dao {

    public List<TestListStudent> filter(Student student) throws Exception {
        List<TestListStudent> list = new ArrayList<>();
        Connection connection = getConnection();
        PreparedStatement statement = null;

        try {
            statement = connection.prepareStatement(
                "select t.subject_cd, s.name as subject_name, t.no, t.point " +
                "from test t " +
                "join subject s on t.subject_cd = s.cd and t.school_cd = s.school_cd " +
                "where t.student_no = ? " +
                "order by t.subject_cd asc, t.no asc");
            statement.setString(1, student.getNo());

            ResultSet rSet = statement.executeQuery();

            while (rSet.next()) {
                TestListStudent tls = new TestListStudent();
                tls.setSubjectCd(rSet.getString("subject_cd"));
                tls.setSubjectName(rSet.getString("subject_name"));
                tls.setNum(rSet.getInt("no"));
                tls.setPoint(rSet.getInt("point"));
                list.add(tls);
            }
        } catch (Exception e) {
            throw e;
        } finally {
            if (statement != null) {
                try {
                    statement.close();
                } catch (SQLException sqle) {
                    throw sqle;
                }
            }
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException sqle) {
                    throw sqle;
                }
            }
        }

        return list;
    }
}