package scoremanager.main;

import java.util.ArrayList;
import java.util.List;

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

public class TestUpdateExecuteAction extends Action {

    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        HttpSession session = request.getSession();
        
        Teacher teacher = (Teacher) session.getAttribute("user");
        School school = teacher.getSchool();

        String studentNo = request.getParameter("student_no");
        String subjectCd = request.getParameter("subject_cd");
        int no = Integer.parseInt(request.getParameter("no"));
        int point = Integer.parseInt(request.getParameter("point"));

        Student student = new Student();
        student.setNo(studentNo);
        student.setSchool(school);

        Subject subject = new Subject();
        subject.setCd(subjectCd);

        List<String> errors = new ArrayList<>();

        if (point < 0 || point > 100) {
            errors.add("得点は0～100の範囲で入力してください。");
        }

        TestDao dao = new TestDao();

        if (!errors.isEmpty()) {
            request.setAttribute("errors", errors);
            request.setAttribute("test", dao.get(student, subject, no));
            request.getRequestDispatcher("test_update.jsp").forward(request, response);
            return;
        }

        Test test = new Test();
        test.setStudent(student);
        test.setSubject(subject);
        test.setSchool(school);
        test.setNo(no);
        test.setPoint(point);

        boolean isSuccess = dao.save(test); 

        if (isSuccess) {
            request.getRequestDispatcher("test_update_done.jsp").forward(request, response);
        } else {
            errors.add("成績の更新に失敗しました。");
            request.setAttribute("errors", errors);
            request.setAttribute("test", dao.get(student, subject, no));
            request.getRequestDispatcher("test_update.jsp").forward(request, response);
        }
    }
}