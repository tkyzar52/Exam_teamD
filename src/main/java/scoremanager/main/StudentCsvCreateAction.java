package scoremanager.main;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import tool.Action;

public class StudentCsvCreateAction extends Action {

    @Override
    public void execute(HttpServletRequest request,
                        HttpServletResponse response)
            throws Exception {

        request.getRequestDispatcher("student_csv_create.jsp")
               .forward(request, response);
    }
}