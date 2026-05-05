package scoremanager.main;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import bean.Student;
import bean.Subject;
import bean.Teacher;
import bean.Test;
import dao.ClassNumDao;
import dao.StudentDao;
import dao.SubjectDao;
import dao.TestDao;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;

public class TestRegistExecuteAction extends Action {
    @Override
    public void execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
        HttpSession session = req.getSession();
        Teacher teacher = (Teacher) session.getAttribute("user");
        String subjectCd = req.getParameter("f3");
        int testNo = Integer.parseInt(req.getParameter("f4"));

        String[] studentNoSet = req.getParameterValues("student_no_set");
        SubjectDao subDao = new SubjectDao();
        Subject subject = subDao.get(subjectCd, teacher.getSchool());

        StudentDao stuDao = new StudentDao();
        List<Test> testList = new ArrayList<>();
        Map<String, String> errorMap = new HashMap<>();

        if (studentNoSet != null) {
            for (String no : studentNoSet) {
                String pointStr = req.getParameter("point_" + no);

                if (pointStr != null && !pointStr.isEmpty()) {
                    int point;
                    try {
                        point = Integer.parseInt(pointStr);
                    } catch (NumberFormatException e) {
                        continue;
                    }

                    if (point < 0 || point > 100) {
                        errorMap.put(no, "0～100の範囲で入力してください");
                        continue;
                    }

                    Student student = stuDao.get(no);
                    if (student != null) {
                        student.setSchool(teacher.getSchool());
                        Test test = new Test();
                        test.setStudent(student);
                        test.setSubject(subject);
                        test.setSchool(teacher.getSchool());
                        test.setNo(testNo);
                        test.setPoint(point);
                        test.setClassNum(student.getClassNum());
                        testList.add(test);
                    }
                }
            }
        }

        if (!errorMap.isEmpty()) {
            // ↓ re-fetch all data needed by test_regist.jsp
            String entYearStr = req.getParameter("f1");
            String classNum = req.getParameter("f2");

            LocalDate todaysDate = LocalDate.now();
            int year = todaysDate.getYear();
            List<Integer> entYearSet = new ArrayList<>();
            for (int i = year - 10; i <= year + 10; i++) {
                entYearSet.add(i);
            }

            ClassNumDao cNumDao = new ClassNumDao();
            List<String> classNumSet = cNumDao.filter(teacher.getSchool());

            List<Subject> subjectSet = subDao.filter(teacher.getSchool());

            List<Integer> testNoSet = new ArrayList<>();
            testNoSet.add(1);
            testNoSet.add(2);

            int entYear = Integer.parseInt(entYearStr);
            TestDao tDao = new TestDao();
            List<Test> tests = tDao.filter(entYear, classNum, subject, testNo, teacher.getSchool());

            req.setAttribute("tests", tests);
            req.setAttribute("subject", subject);
            req.setAttribute("ent_year_set", entYearSet);
            req.setAttribute("class_num_set", classNumSet);
            req.setAttribute("subject_set", subjectSet);
            req.setAttribute("test_no_set", testNoSet);
            req.setAttribute("f1", entYearStr);
            req.setAttribute("f2", classNum);
            req.setAttribute("f3", subjectCd);
            req.setAttribute("f4", String.valueOf(testNo));
            req.setAttribute("errorMap", errorMap);

            req.getRequestDispatcher("test_regist.jsp").forward(req, res);
            return;
        }

        TestDao tDao = new TestDao();
        tDao.save(testList);

        req.getRequestDispatcher("test_regist_done.jsp").forward(req, res);
    }
}