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

public class StudentListAction extends Action {

    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response)
        throws Exception {

        HttpSession session = request.getSession();

        Teacher teacher = (Teacher) session.getAttribute("user");

        String entYearStr = "";

        String classNum = "";

        String isAttendStr = "";

        int entYear = 0;

        boolean isAttend = false;

        List<Student> students = null;

        LocalDate todaysDate = LocalDate.now();

        int year = todaysDate.getYear();

        StudentDao sDao = new StudentDao();

        ClassNumDao cNumDao = new ClassNumDao();

        Map<String, String> errors = new HashMap<>();

        // パラメータ取得
        entYearStr = request.getParameter("f1");

        classNum = request.getParameter("f2");

        isAttendStr = request.getParameter("f3");

        // 入学年度
        if (entYearStr != null) {

            entYear = Integer.parseInt(entYearStr);

        }

        // 在学中チェック
        if (isAttendStr != null) {

            isAttend = true;

            request.setAttribute("f3", isAttendStr);

        }

        // 入学年度リスト
        List<Integer> entYearSet = new ArrayList<>();

        for (int i = year - 10; i < year + 11; i++) {

            entYearSet.add(i);

        }

        // クラス一覧
        List<String> list = cNumDao.filter(teacher.getSchool());

        // 検索処理
        if (entYear != 0 && !classNum.equals("0")) {

            students = sDao.filter(
                teacher.getSchool(),
                entYear,
                classNum,
                isAttend
            );

        } else if (entYear != 0 && classNum.equals("0")) {

            students = sDao.filter(
                teacher.getSchool(),
                entYear,
                isAttend
            );

        } else if (
            (entYear == 0 && classNum == null) ||
            (entYear == 0 && classNum.equals("0"))
        ) {

            students = sDao.filter(
                teacher.getSchool(),
                isAttend
            );

        } else {

            errors.put(
                "f1",
                "クラスを指定する場合は入学年度を指定してください"
            );

            request.setAttribute("errors", errors);

            students = sDao.filter(
                teacher.getSchool(),
                isAttend
            );

        }

        // 値保持
        request.setAttribute("f1", entYear);

        request.setAttribute("f2", classNum);

        request.setAttribute("students", students);

        request.setAttribute("class_num_set", list);

        request.setAttribute("ent_year_set", entYearSet);

        // JSPへ
        request.getRequestDispatcher("student_list.jsp")
               .forward(request, response);

    }

}