package scoremanager.main;

import java.util.ArrayList;
import java.util.List;

import bean.Student;
import bean.Subject;
import bean.Teacher;
import bean.Test;
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

        if (studentNoSet != null) {
            for (String no : studentNoSet) {
                String pointStr = req.getParameter("point_" + no);
                
                if (pointStr != null && !pointStr.isEmpty()) {
                    int point = Integer.parseInt(pointStr);
                    
                    if (point >= 0 && point <= 100) {
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
        }

        TestDao tDao = new TestDao();
        tDao.save(testList);
        

        req.getRequestDispatcher("test_regist_done.jsp").forward(req, res);
    }
}