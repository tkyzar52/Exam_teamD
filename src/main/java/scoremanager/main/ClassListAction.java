package scoremanager.main;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import bean.Student;
import bean.Teacher;
import dao.ClassNumDao;
import dao.StudentDao;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;

public class ClassListAction extends Action {

    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        HttpSession session = request.getSession();
        Teacher teacher = (Teacher) session.getAttribute("user");

        String entYearStr = request.getParameter("f1");
        String classNum = request.getParameter("f2");
        String isAttendStr = request.getParameter("f3");
        String search = request.getParameter("search");

        int entYear = 0;

        // 入学年度
        if (entYearStr != null && !entYearStr.isEmpty()) {
            entYear = Integer.parseInt(entYearStr);
        }

        // クラス null対策
        if (classNum == null) {
            classNum = "0";
        }

        // 🔥 isAttendを先に決定
        boolean isAttend = false;
        if (isAttendStr != null) {
            isAttend = true;
        }

        List<Student> students = null;

        LocalDate today = LocalDate.now();
        int year = today.getYear();

        StudentDao sDao = new StudentDao();
        ClassNumDao cNumDao = new ClassNumDao();

        Map<String, String> errors = new HashMap<>();

        List<Integer> entYearSet = new ArrayList<>();
        for (int i = year - 10; i < year + 11; i++) {
            entYearSet.add(i);
        }

        List<String> list = cNumDao.filter(teacher.getSchool());
     // 検索ボタン押した時だけ
        if (search != null) {

            if (entYear == 0) {
                errors.put("f1", "入学年度を選択してください");
            }

            if (classNum.equals("0")) {
                errors.put("f2", "クラスを選択してください");
            }

            // エラーなし
            if (errors.isEmpty()) {

                students = sDao.filter(
                        teacher.getSchool(),
                        entYear,
                        classNum,
                        isAttend
                );
            }

            request.setAttribute("errors", errors);
        }
        

        // JSPへ
        request.setAttribute("f1", entYear);
        request.setAttribute("f2", classNum);
        request.setAttribute("f3", isAttend);

        request.setAttribute("students", students);
        request.setAttribute("class_num_set", list);
        request.setAttribute("ent_year_set", entYearSet);

        request.getRequestDispatcher("class_student_list.jsp").forward(request, response);
    }
}