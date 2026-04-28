package scoremanager.main;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import bean.Subject;
import bean.Teacher;
import bean.Test;
import dao.ClassNumDao;
import dao.SubjectDao;
import dao.TestDao;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;

public class TestRegistAction extends Action {

    @Override
    public void execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
        HttpSession session = req.getSession();
        Teacher teacher = (Teacher) session.getAttribute("user");

        String entYearStr = req.getParameter("f1");
        String classNum = req.getParameter("f2");
        String subjectCd = req.getParameter("f3");
        String testNoStr = req.getParameter("f4");

        LocalDate todaysDate = LocalDate.now();
        int year = todaysDate.getYear();
        List<Integer> entYearSet = new ArrayList<>();
        for (int i = year - 10; i <= year + 10; i++) {
            entYearSet.add(i);
        }

        ClassNumDao cNumDao = new ClassNumDao();
        List<String> classNumSet = cNumDao.filter(teacher.getSchool());

        SubjectDao sDao = new SubjectDao();
        List<Subject> subjectSet = sDao.filter(teacher.getSchool());

        List<Integer> testNoSet = new ArrayList<>();
        testNoSet.add(1);
        testNoSet.add(2);

        if (entYearStr != null && classNum != null && subjectCd != null && testNoStr != null &&
            !entYearStr.equals("0") && !classNum.equals("0") && !subjectCd.equals("0") && !testNoStr.equals("0")) {
            
            int entYear = Integer.parseInt(entYearStr);
            int testNo = Integer.parseInt(testNoStr);
            Subject subject = sDao.get(subjectCd, teacher.getSchool());

            TestDao tDao = new TestDao();
            List<Test> tests = tDao.filter(entYear, classNum, subject, testNo, teacher.getSchool());
            
            req.setAttribute("tests", tests);
        }

        req.setAttribute("ent_year_set", entYearSet);
        req.setAttribute("class_num_set", classNumSet);
        req.setAttribute("subject_set", subjectSet);
        req.setAttribute("test_no_set", testNoSet);
        
        req.setAttribute("f1", entYearStr);
        req.setAttribute("f2", classNum);
        req.setAttribute("f3", subjectCd);
        req.setAttribute("f4", testNoStr);

        req.getRequestDispatcher("test_regist.jsp").forward(req, res);
    }
}