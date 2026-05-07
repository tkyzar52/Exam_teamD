package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import bean.School;
import bean.Subject;
import bean.TestListSubject;

public class TestListSubjectDao extends Dao {

    private String baseSql =
        "SELECT " +
        "s.ENT_YEAR, " +
        "s.NO AS STUDENT_NO, " +
        "s.NAME AS STUDENT_NAME, " +
        "s.CLASS_NUM, " +
        "t.NO AS TEST_NO, " +
        "t.POINT " +
        "FROM STUDENT s " +
        "LEFT JOIN TEST t " +
        "ON s.NO = t.STUDENT_NO " +
        "AND t.SUBJECT_CD = ? " +
        "WHERE s.ENT_YEAR = ? " +
        "AND s.CLASS_NUM = ? " +
        "AND s.SCHOOL_CD = ? " +
        "ORDER BY s.NO, t.NO";

    public List<TestListSubject> filter(
            int entYear,
            String classNum,
            Subject subject,
            School school
    ) throws Exception {

        List<TestListSubject> list = new ArrayList<>();

        Connection con = getConnection();

        PreparedStatement st = con.prepareStatement(baseSql);

        st.setString(1, subject.getCd());
        st.setInt(2, entYear);
        st.setString(3, classNum);
        st.setString(4, school.getCd());

        ResultSet rs = st.executeQuery();

        Map<String, TestListSubject> studentMap = new HashMap<>();

        while (rs.next()) {

            String studentNo = rs.getString("STUDENT_NO");

            TestListSubject student = studentMap.get(studentNo);

            if (student == null) {

                student = new TestListSubject();

                student.setEntYear(rs.getInt("ENT_YEAR"));
                student.setStudentNo(studentNo);
                student.setStudentName(rs.getString("STUDENT_NAME"));
                student.setClassNum(rs.getString("CLASS_NUM"));

                studentMap.put(studentNo, student);

                list.add(student);
            }

            int testNo = rs.getInt("TEST_NO");
            int point = rs.getInt("POINT");

            if (!rs.wasNull()) {
                student.putPoint(testNo, point);
            }
        }

        rs.close();
        st.close();
        con.close();

        return list;
    }
}