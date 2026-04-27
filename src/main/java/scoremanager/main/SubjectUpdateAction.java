package scoremanager.main;

import bean.Subject;
import bean.Teacher;
import dao.SubjectDao;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;

public class SubjectUpdateAction extends Action {
    @Override
    public void execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
        HttpSession session = req.getSession();
        Teacher teacher = (Teacher) session.getAttribute("user");

        String cd = req.getParameter("cd");

        // 科目コードが空の場合のチェック
        if (cd == null || cd.trim().isEmpty()) {
            req.setAttribute("errorMessage", "科目が存在しません");
            req.getRequestDispatcher("subject_update.jsp").forward(req, res);
            return;
        }

        SubjectDao sDao = new SubjectDao();
        Subject subject = sDao.get(cd, teacher.getSchool());

        // DBに科目が存在しない場合のチェック
        if (subject == null) {
            req.setAttribute("errorMessage", "科目が存在しません");
            req.getRequestDispatcher("subject_update.jsp").forward(req, res);
            return;
        }

        req.setAttribute("subject", subject);
        req.getRequestDispatcher("subject_update.jsp").forward(req, res);
    }
}