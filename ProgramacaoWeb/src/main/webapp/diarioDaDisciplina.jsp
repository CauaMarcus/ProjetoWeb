<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.Statement"%>
<%@ page import="java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quadro de Horário do Disciplina</title>
</head>
<body>
    <h1>Quadro de Horário do Disciplina</h1>

    <%
    Connection conexao = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;
    try {
        Class.forName("org.postgresql.Driver");
        conexao = DriverManager.getConnection("jdbc:postgresql://localhost:5432/ProgramaçãoWeb", "postgres", "123");

        String sql = "SELECT * FROM disciplina";
        stmt = conexao.prepareStatement(sql);
        rs = stmt.executeQuery();

        %><table>
            <tr>
              <th>Codigo da disciplina</th>
              <th>Nome da disciplina</th>
              <th>Nome do professor</th>
              <th>Horario de inicio da aula</th>
              <th>Horario de fim da aula</th>
              <th>Dia da aula</th>

            </tr><%

        while (rs.next()) {
            String codigo = rs.getString(1);
            String nomeDaDisciplina= rs.getString(2);
            String nomeProfessor = rs.getString(3);
            String horarioInicioAula= rs.getString(5);
            String horarioFimAula= rs.getString(6);
            String DiaDeAula= rs.getString(7);

            %><tr>
              <td><%= codigo %></td>
              <td><%= nomeDaDisciplina %></td>
              <td><%= nomeProfessor %></td>
              <td><%= horarioInicioAula %></td>
			  <td><%= horarioFimAula %></td>
              <td><%= DiaDeAula %></td>
            </tr><%
        }

        %></table><%

    } catch (SQLException e) {
        e.printStackTrace();
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
    %>
</body>
</html>