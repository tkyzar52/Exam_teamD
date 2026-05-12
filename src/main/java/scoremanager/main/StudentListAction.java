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

public class StudentListAction extends Action{
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response)
		throws Exception {
		
		HttpSession session = request.getSession();
		Teacher teacher = (Teacher)session.getAttribute("user");
		
		String entYearStr="";
		String classNum ="";
		String isAttendStr="";
		int entYear= 0;
		boolean isAttend = false;
		List<Student> students = null;
		LocalDate todaysDate = LocalDate.now();
		int year = todaysDate.getYear();
		StudentDao sDao= new StudentDao();
		ClassNumDao cNumDao = new ClassNumDao();
		Map<String, String> errors = new HashMap<>();
		
		
		entYearStr= request.getParameter("f1");
		classNum=request.getParameter("f2");
		isAttendStr=request.getParameter("f3");
		
		
		// ✅ Null guards
        if (classNum == null) {
            classNum = "0";
        }
        if (entYearStr == null || entYearStr.isEmpty()) {
            entYearStr = "0";
        }
        entYear = Integer.parseInt(entYearStr);

        // ✅ isAttend must be set BEFORE filtering
        if (isAttendStr != null) {
            isAttend = true;
            request.setAttribute("f3", isAttendStr);
        }

		
		  // ✅ Null guard for classNum (null on first page load)
        if (entYear != 0 && !classNum.equals("0")) {
            students = sDao.filter(teacher.getSchool(), entYear, classNum, isAttend);

        } else if (entYear != 0 && classNum.equals("0")) {
            errors.put("f2", "入学年度を指定する場合はクラスを指定してください");
            students = sDao.filter(teacher.getSchool(), entYear, isAttend);

        } else if (entYear == 0 && classNum.equals("0")) {
            students = sDao.filter(teacher.getSchool(), isAttend);

        } else {
            errors.put("f1", "クラスを指定する場合は入学年度を指定してください");
            students = sDao.filter(teacher.getSchool(), isAttend);
        }
        
		
		
		List<Integer> entYearSet = new ArrayList<>();
		
		for (int i = year - 10; i < year + 11;i++) {
			entYearSet.add(i);
		}
		
		
		List<String> list = cNumDao.filter(teacher.getSchool());
		if (entYear != 0 && !classNum.equals("0")) {
		    // Both year and class selected
		    students = sDao.filter(teacher.getSchool(), entYear, classNum, isAttend);

		} else if (entYear != 0 && classNum.equals("0")) {
		    // Only year selected
		    students = sDao.filter(teacher.getSchool(), entYear, isAttend);

		} else if (entYear == 0 && classNum.equals("0")) {
		    // Neither selected
		    students = sDao.filter(teacher.getSchool(), isAttend);

		} else {
		    // Class selected without year → error
		    errors.put("f1", "クラスを指定する場合は入学年度を指定してください");
		    request.setAttribute("errors", errors);
		    students = sDao.filter(teacher.getSchool(), isAttend);
		}
		
		request.setAttribute("errors", errors);
		request.setAttribute("f1",entYear );
		request.setAttribute("f2", classNum);
		
		
		

		if (entYearStr != null) {
		    entYear = Integer.parseInt(entYearStr);
		}
		request.setAttribute("students", students);
		
		request.setAttribute("class_num_set", list);
		
		request.setAttribute("ent_year_set", entYearSet);
		
		
		request.getRequestDispatcher("student_list.jsp").forward(request, response);
		
		
		
		
		
	}

}
