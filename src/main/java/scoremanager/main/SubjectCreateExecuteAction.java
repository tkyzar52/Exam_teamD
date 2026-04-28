package scoremanager.main;

import bean.Subject;
import bean.Teacher;
import dao.SubjectDao;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;

public class SubjectCreateExecuteAction extends Action {
    @Override
    public void execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
        HttpSession session = req.getSession();
        Teacher teacher = (Teacher) session.getAttribute("user");

        String cd = req.getParameter("cd");
        String name = req.getParameter("name");

        // ①科目コード文字数チェック
        if (cd == null || cd.length() != 3) {
            req.setAttribute("errorMessage", "科目コードは3文字で入力してください");
            req.setAttribute("cd", cd);
            req.setAttribute("name", name);
            req.getRequestDispatcher("subject_create.jsp").forward(req, res);
            return;
        }

        SubjectDao sDao = new SubjectDao();

        // ②科目コード重複チェック
        Subject existing = sDao.get(cd, teacher.getSchool());
        if (existing != null) {
            req.setAttribute("errorMessage", "科目コードが重複しています");
            req.setAttribute("cd", cd);
            req.setAttribute("name", name);
            req.getRequestDispatcher("subject_create.jsp").forward(req, res);
            return;
        }

        Subject subject = new Subject();
        subject.setCd(cd);
        subject.setName(name);
        subject.setSchool(teacher.getSchool());

        sDao.save(subject);

        req.getRequestDispatcher("subject_create_done.jsp").forward(req, res);
    }
}