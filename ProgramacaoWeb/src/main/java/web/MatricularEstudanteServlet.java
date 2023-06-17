package web;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/MatriculaEstudanteServlet")
public class MatricularEstudanteServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String codigoDisciplina = request.getParameter("codigoDisciplina");
        String matriculaEstudante = request.getParameter("matriculaEstudante");

        try {
            if (EstudanteMatriculado(codigoDisciplina, matriculaEstudante)) {   
                request.setAttribute("mensagem", "Estudante já matriculado nesta disciplina");            
                request.getRequestDispatcher("sucesso.jsp").forward(request, response);
            } else {
                matricularEstudante(codigoDisciplina, matriculaEstudante);
                request.setAttribute("mensagem", "Estudante matriculado com sucesso");
                request.getRequestDispatcher("sucesso.jsp").forward(request, response);
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            request.setAttribute("mensagem", "Erro ao carregar o driver JDBC");
            request.getRequestDispatcher("sucesso.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("mensagem", "Erro ao inserir os dados");
            request.getRequestDispatcher("sucesso.jsp").forward(request, response);
        }
    }

    private boolean EstudanteMatriculado(String codigoDisciplina, String matriculaEstudante)
            throws ClassNotFoundException, SQLException {
        Connection conexao = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            Class.forName("org.postgresql.Driver");
            conexao = DriverManager.getConnection("jdbc:postgresql://localhost:5432/ProgramaçãoWeb", "postgres", "123");

            String check = "SELECT COUNT(*) FROM matricula WHERE codigoDisciplina = CAST(? AS int) AND matriculaEstudante = CAST(? AS int)";
            stmt = conexao.prepareStatement(check);
            stmt.setString(1, codigoDisciplina);
            stmt.setString(2, matriculaEstudante);
            rs = stmt.executeQuery();

            if (rs.next()) {
                int busca = rs.getInt(1);
                return busca > 0;
            }
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
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
        return false;
    }

    private void matricularEstudante(String codigoDisciplina, String matriculaEstudante)
            throws ClassNotFoundException, SQLException {
        Connection conexao = null;
        PreparedStatement stmt = null;
        try {
            Class.forName("org.postgresql.Driver");
            conexao = DriverManager.getConnection("jdbc:postgresql://localhost:5432/ProgramaçãoWeb", "postgres", "123");

            String sql = "INSERT INTO matricula (codigoDisciplina, matriculaEstudante) VALUES (CAST(? AS int), CAST(? AS int))";
            stmt = conexao.prepareStatement(sql);
            stmt.setString(1, codigoDisciplina);
            stmt.setString(2, matriculaEstudante);

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
}
