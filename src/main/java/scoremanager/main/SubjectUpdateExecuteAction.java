package scoremanager.main;

import bean.Subject;
import bean.Teacher;
import dao.SubjectDao;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;

public class SubjectUpdateExecuteAction extends Action {
    @Override
    public void execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
        HttpSession session = req.getSession();
        Teacher teacher = (Teacher) session.getAttribute("user");

        String cd = req.getParameter("cd");
        String name = req.getParameter("name");

        SubjectDao sDao = new SubjectDao();

        // 科目コードが空の場合のチェック
        if (cd == null || cd.trim().isEmpty()) {
            req.setAttribute("errorMessage", "科目が存在しません");
            req.getRequestDispatcher("SubjectUpdate.jsp").forward(req, res);
            return;
        }

        // DBから科目の存在確認
        Subject subject = sDao.get(cd.trim(), teacher.getSchool());

        if (subject == null) {
            req.setAttribute("errorMessage", "科目が存在しません");
            req.getRequestDispatcher("SubjectUpdate.jsp").forward(req, res);
            return;
        }

        // 更新処理
        subject.setName(name);
        subject.setSchool(teacher.getSchool());
        sDao.update(subject);

        req.getRequestDispatcher("subject_update_done.jsp").forward(req, res);
    }
}