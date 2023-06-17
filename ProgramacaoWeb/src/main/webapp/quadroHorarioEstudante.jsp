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
    <title>Quadro de Horário do Estudante</title>
</head>
<body>
    <h1>Quadro de Horário do Estudante</h1>

    <%
    Connection conexao = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;
    try {
        Class.forName("org.postgresql.Driver");
        conexao = DriverManager.getConnection("jdbc:postgresql://localhost:5432/ProgramaçãoWeb", "postgres", "123");

        String sql = "SELECT * FROM estudante";
        stmt = conexao.prepareStatement(sql);
        rs = stmt.executeQuery();

        %><table>
            <tr>
              <th>matricula estudante</th>
              <th>nome estudante</th>
              <th>email estudante</th>
              <th>ano Egresso estudante</th>

            </tr><%

        while (rs.next()) {
            String matriculaEstudante = rs.getString(1);
            String nomeEstudante= rs.getString(2);
            String emailEstudante = rs.getString(3);
            String anoegressoEstudante = rs.getString(4);

            %><tr>
              <td><%= matriculaEstudante %></td>
              <td><%= nomeEstudante %></td>
              <td><%= emailEstudante %></td>
              <td><%= anoegressoEstudante %></td>
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