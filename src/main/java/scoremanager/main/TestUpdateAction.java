package scoremanager.main;

import bean.School;
import bean.Student;
import bean.Subject;
import bean.Teacher;
import bean.Test;
import dao.TestDao;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;

public class TestUpdateAction extends Action {

    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        HttpSession session = request.getSession();

        Teacher teacher = (Teacher) session.getAttribute("user");
        School school = teacher.getSchool();

        String studentNo = request.getParameter("student_no");
        String subjectCd = request.getParameter("subject_cd");
        int no = Integer.parseInt(request.getParameter("no"));
        
        Student student = new Student();
        student.setNo(studentNo);
        student.setSchool(school);

        Subject subject = new Subject();
        subject.setCd(subjectCd);

        TestDao testDao = new TestDao();
        Test test = testDao.get(student, subject, no); 

        request.setAttribute("test", test);
        request.getRequestDispatcher("test_update.jsp").forward(request, response);
    }
}