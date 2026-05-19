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

public class StudentCreateExecuteAction extends Action {

    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        HttpSession session = request.getSession();

        Teacher teacher = (Teacher) session.getAttribute("user");

        StudentDao sDao = new StudentDao();
        ClassNumDao cNumDao = new ClassNumDao();

        Map<String, String> errors = new HashMap<>();

        int year = LocalDate.now().getYear();

        String no = request.getParameter("no");
        String name = request.getParameter("name");
        String entYearStr = request.getParameter("ent_year");
        String classNum = request.getParameter("class_num");
        String isAttendStr = request.getParameter("is_attend");

        List<String> classNumSet = cNumDao.filter(teacher.getSchool());

        List<Integer> entYearSet = new ArrayList<>();

        for (int i = year - 10; i < year + 11; i++) {
            entYearSet.add(i);
        }

     // 学生番号重複チェック
        if (no != null && !no.trim().isEmpty()) {

            Student existing = sDao.get(no.trim());

            if (existing != null) {
                errors.put("no", "学生番号が重複しています");
            }
        }

     // 入学年度チェック
        if (entYearStr == null || entYearStr.isEmpty()) {

            errors.put("ent_year", "入学年度を選択してください");

        }

        // エラーがある場合
        if (!errors.isEmpty()) {

            request.setAttribute("errors", errors);

            request.setAttribute("no", no);
            request.setAttribute("name", name);
            request.setAttribute("ent_year", entYearStr);
            request.setAttribute("class_num", classNum);
            request.setAttribute("is_attend", isAttendStr);

            request.setAttribute("class_num_set", classNumSet);
            request.setAttribute("ent_year_set", entYearSet);

            request.getRequestDispatcher("student_create.jsp")
                   .forward(request, response);

            return;
        }
        
        // 保存処理
        Student student = new Student();

        student.setNo(no.trim());
        student.setName(name.trim());
        student.setEntYear(Integer.parseInt(entYearStr));
        student.setClassNum(classNum);
        student.setAttend(isAttendStr != null && isAttendStr.equals("1"));
        student.setSchool(teacher.getSchool());

        sDao.save(student);
        
        request.getRequestDispatcher("student_create_done.jsp")
        .forward(request, response);


       
    }
}