package scoremanager.main;

import java.util.List;

import bean.Subject;
import bean.Teacher;
import dao.SubjectDao;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;

public class SubjectCreateAction extends Action {

    @Override
    public void execute( HttpServletRequest req,HttpServletResponse res
    ) throws Exception {

        HttpSession session = req.getSession();

        Teacher teacher =
                (Teacher) session.getAttribute("user");

        SubjectDao dao = new SubjectDao();

        // 科目一覧取得
        List<Subject> list =
                dao.filter(teacher.getSchool());

        req.setAttribute("subject_list", list);

        // 登録画面へ
        req.getRequestDispatcher("subject_create.jsp").forward(req, res);
    }
}