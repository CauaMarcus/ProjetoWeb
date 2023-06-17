package web;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Time;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/DisciplinaCadastroServlet")
public class DisciplinaCadastroServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String codigo = request.getParameter("codigo");
        String nomeDisciplina = request.getParameter("nomeDisciplina");
        String nomeProfessor = request.getParameter("nomeProfessor");
        String matriculaProfessor = request.getParameter("matriculaProfessor");
        String horarioInicioAula = request.getParameter("horarioInicioAula");
        String horarioFimAula = request.getParameter("horarioFimAula");
        String diaDaAula = request.getParameter("diaDaAula");

        try {
            cadastrarDisciplina(codigo, nomeDisciplina, nomeProfessor, matriculaProfessor, horarioInicioAula,
                    horarioFimAula, diaDaAula);
            request.setAttribute("mensagem", "Disciplina cadastrada com sucesso");
            request.getRequestDispatcher("sucesso.jsp").forward(request, response);
        } catch (ClassNotFoundException e) {
            request.setAttribute("mensagem", "Erro ao carregar o driver JDBC");
            request.getRequestDispatcher("erro.jsp").forward(request, response);
        } catch (SQLException e) {
            request.setAttribute("mensagem", "Erro ao inserir os dados");
            request.getRequestDispatcher("erro.jsp").forward(request, response);
        } catch (ParseException e) {
            request.setAttribute("mensagem", "Erro ao converter horário");
            request.getRequestDispatcher("erro.jsp").forward(request, response);
        }
    }

    private void cadastrarDisciplina(String codigo, String nomeDisciplina, String nomeProfessor,
            String matriculaProfessor, String horarioInicioAula, String horarioFimAula, String diaDaAula)
            throws ClassNotFoundException, SQLException, ParseException {
        Connection conexao = null;
        PreparedStatement stmt = null;
        try {
            Class.forName("org.postgresql.Driver");
            conexao = DriverManager.getConnection("jdbc:postgresql://localhost:5432/ProgramaçãoWeb", "postgres", "123");

            String sql = "INSERT INTO disciplina (codigo, nomedadisciplina, nomeprofessor, matriculaprofessor, horarioinicioaula, horariofimaula, diadeaula) VALUES (?, ?, ?, ?, ?, ?, ?)";
            stmt = conexao.prepareStatement(sql);
            stmt.setInt(1, Integer.parseInt(codigo));
            stmt.setString(2, nomeDisciplina);
            stmt.setString(3, nomeProfessor);
            stmt.setInt(4, Integer.parseInt(matriculaProfessor));
            stmt.setTime(5, getTimeFromString(horarioInicioAula));
            stmt.setTime(6, getTimeFromString(horarioFimAula));
            stmt.setString(7, diaDaAula);

            stmt.executeUpdate();
        } finally {
            try {
                if (stmt != null) {
                    stmt.close();
                }
                if (conexao != null) {
                    conexao.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    private Time getTimeFromString(String timeString) throws ParseException {
        SimpleDateFormat format = new SimpleDateFormat("HH:mm");
        Date parsedDate = format.parse(timeString);
        return new Time(parsedDate.getTime());
    }
}