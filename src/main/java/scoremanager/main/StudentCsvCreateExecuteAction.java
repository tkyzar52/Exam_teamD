package scoremanager.main;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import bean.Student;
import bean.Teacher;
import dao.StudentDao;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import tool.Action;

@WebServlet("/StudentCsvCreateExecute.action")
@MultipartConfig(maxFileSize = 1024 * 1024)
public class StudentCsvCreateExecuteAction extends Action {



    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        HttpSession session = request.getSession();
        Teacher teacher = (Teacher) session.getAttribute("user");
        StudentDao sDao = new StudentDao();

        // アップロードされたCSVファイルを取得
        Part filePart = request.getPart("csv_file");

        // エラー・成功リスト
        List<String> successList = new ArrayList<>();
        // key: 行番号, value: エラーメッセージ
        Map<Integer, String> errorMap = new LinkedHashMap<>();

        if (filePart == null || filePart.getSize() == 0) {
            request.setAttribute("csv_error", "CSVファイルを選択してください。");
            request.getRequestDispatcher("student_csv_create.jsp").forward(request, response);
            return;
        }

        BufferedReader reader = new BufferedReader(
            new InputStreamReader(filePart.getInputStream(), StandardCharsets.UTF_8)
        );

        String line;
        int rowNum = 0;

        while ((line = reader.readLine()) != null) {
            rowNum++;

            // ヘッダー行はスキップ
            if (rowNum == 1 && line.toLowerCase().startsWith("no")) {
                continue;
            }

            // 空行はスキップ
            if (line.trim().isEmpty()) {
                continue;
            }

            String[] cols = line.split(",", -1);

            // 列数チェック（no, name, ent_year, class_num, is_attend = 5列）
            if (cols.length < 5) {
                errorMap.put(rowNum, rowNum + "行目: 列数が不足しています（5列必要）");
                continue;
            }

            String no        = cols[0].trim();
            String name      = cols[1].trim();
            String entYearStr = cols[2].trim();
            String classNum  = cols[3].trim();
            String isAttendStr = cols[4].trim();

            // --- バリデーション ---
            StringBuilder rowError = new StringBuilder();

            // 学生番号
            if (no.isEmpty()) {
                rowError.append("学生番号が空です。 ");
            } else if (no.length() > 10) {
                rowError.append("学生番号は10文字以内にしてください。 ");
            } else {
                Student existing = sDao.get(no);
                if (existing != null) {
                    rowError.append("学生番号「").append(no).append("」は既に登録されています。 ");
                }
            }

            // 氏名
            if (name.isEmpty()) {
                rowError.append("氏名が空です。 ");
            } else if (name.length() > 30) {
                rowError.append("氏名は30文字以内にしてください。 ");
            }

            // 入学年度
            int entYear = 0;
            if (entYearStr.isEmpty()) {
                rowError.append("入学年度が空です。 ");
            } else {
                try {
                    entYear = Integer.parseInt(entYearStr);
                } catch (NumberFormatException e) {
                    rowError.append("入学年度が数値ではありません。 ");
                }
            }

            // クラス番号
            if (classNum.isEmpty()) {
                rowError.append("クラスが空です。 ");
            }

            // エラーがあればスキップ
            if (rowError.length() > 0) {
                errorMap.put(rowNum, rowNum + "行目 [" + no + "]: " + rowError.toString().trim());
                continue;
            }

            // --- 保存処理 ---
            Student student = new Student();
            student.setNo(no);
            student.setName(name);
            student.setEntYear(entYear);
            student.setClassNum(classNum);
            student.setAttend("1".equals(isAttendStr));
            student.setSchool(teacher.getSchool());

            sDao.save(student);
            successList.add(no + " " + name);
        }

        reader.close();

        // 結果を渡してページ遷移
        request.setAttribute("csv_success_list", successList);
        request.setAttribute("csv_error_map", errorMap);

        request.getRequestDispatcher("student_csv_done.jsp").forward(request, response);
    }
}