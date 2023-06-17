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

@WebServlet("/ProfessorCadastroServlet")
public class ProfessorCadastroServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String matricula = request.getParameter("matricula");
        String nome = request.getParameter("nome");
        String email = request.getParameter("email");
        String anoEgresso = (request.getParameter("anoEgresso"));
        
        Connection conexao = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {

            Class.forName("org.postgresql.Driver");
            conexao = DriverManager.getConnection("jdbc:postgresql://localhost:5432/ProgramaçãoWeb", "postgres",
                    "123");

            String check = "SELECT COUNT(*) FROM professor WHERE matricula = CAST(? AS int)";
            stmt = conexao.prepareStatement(check);
            stmt.setString(1, matricula);
            rs = stmt.executeQuery();

            if (rs.next()) {
                int count = rs.getInt(1);
                request.setAttribute("mensagem", "Professor cadastrado Com Sucesso");            
            }
            String sql = "INSERT INTO professor (matricula, nome, email, anoEgresso) VALUES (CAST(? AS int), ?, ?, CAST(? AS int))";
            stmt = conexao.prepareStatement(sql);
            stmt.setString(1, matricula);
            stmt.setString(2, nome);
            stmt.setString(3, email);
            stmt.setString(4, anoEgresso);

            int linhasAfetadas = stmt.executeUpdate();
            request.setAttribute("mensagem", "Professor cadastrado Com Sucesso");

        } catch (ClassNotFoundException e) {
            request.setAttribute("mensagem", "Erro ao carregar o driver JDBC");
        } catch (SQLException e) {
            request.setAttribute("mensagem", "Erro ao inserir os dados");
        } finally {

            try {
                if (stmt != null) {
                    stmt.close();
                }
                if (conexao != null) {
                    conexao.close();
                }
            } catch (SQLException e) {

            }
        }
    }
}

