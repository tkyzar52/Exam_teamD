package scoremanager.main;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
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

public class TestListAction extends Action {

    @Override
    public void execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
        HttpSession session = req.getSession();
        Teacher teacher = (Teacher) session.getAttribute("user");

        String f = req.getParameter("f"); 
        
        LocalDate todaysDate = LocalDate.now();
        int year = todaysDate.getYear();
        List<Integer> entYearSet = new ArrayList<>();
        for (int i = year - 10; i <= year + 10; i++) entYearSet.add(i);

        ClassNumDao cNumDao = new ClassNumDao();
        List<String> classNumSet = cNumDao.filter(teacher.getSchool());
        SubjectDao sDao = new SubjectDao();
        List<Subject> subjectSet = sDao.filter(teacher.getSchool());

        req.setAttribute("ent_year_set", entYearSet);
        req.setAttribute("class_num_set", classNumSet);
        req.setAttribute("subject_set", subjectSet);

        if (f != null) {
            TestDao tDao = new TestDao();
            if (f.equals("sj")) {
                String entYearStr =req.getParameter("f1");
                String classNum = req.getParameter("f2");
                String subjectCd = req.getParameter("f3");
                
                
                req.setAttribute("f1", entYearStr);
                req.setAttribute("f2", classNum);
                req.setAttribute("f3", subjectCd);
                
                if (entYearStr == null || entYearStr.equals("0") ||
                	    classNum == null || classNum.equals("0") ||
                	    subjectCd == null || subjectCd.equals("0")) {

                	    req.setAttribute("errorMessage", "入学年度とクラスと科目を選択してください");

                	    req.setAttribute("f1", entYearStr);
                	    req.setAttribute("f2", classNum);
                	    req.setAttribute("f3", subjectCd);

                	    req.getRequestDispatcher("test_list.jsp").forward(req, res);
                	    return;
                	}
                
                int entYear = Integer.parseInt(entYearStr);
                
                Subject subject = sDao.get(subjectCd, teacher.getSchool());
                
                List<Test> tests = tDao.filter(entYear, classNum, subject, 0, teacher.getSchool());
                
                Map<String, Student> studentMap = new LinkedHashMap<>();
                Map<String, Map<String, Integer>> scoreMap = new HashMap<>();

                for (Test t : tests) {
                    String sNo = t.getStudent().getNo();
                    studentMap.put(sNo, t.getStudent());
                    
                    scoreMap.putIfAbsent(sNo, new HashMap<>());
                    
                    if (t.getPoint() != -1) {
                        String testNumStr = String.valueOf(t.getNo());
                        scoreMap.get(sNo).put(testNumStr, t.getPoint());
                    }
                }
                
                req.setAttribute("student_map", studentMap);
                req.setAttribute("score_map", scoreMap);
                req.setAttribute("subject", subject);
                req.getRequestDispatcher("test_list_subject.jsp").forward(req, res);
                return;

            } else if (f.equals("st")) {
                String studentNo = req.getParameter("f4");
                
                req.setAttribute("f4", studentNo);
                
                StudentDao stuDao = new StudentDao();
                Student student = stuDao.get(studentNo);
                
                
                if (student != null) {
                    List<Test> tests = tDao.filter(student);
                    req.setAttribute("tests", tests);
                    req.setAttribute("student", student);
                }
                req.getRequestDispatcher("test_list_student.jsp").forward(req, res);
                return;
            }
        }
        req.getRequestDispatcher("test_list.jsp").forward(req, res);
    }
}