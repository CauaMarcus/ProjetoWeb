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
    <title>Quadro de Horário do Professor</title>
</head>
<body>
    <h1>Quadro de Horário do Professor</h1>

    <%
    Connection conexao = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;
    try {
        Class.forName("org.postgresql.Driver");
        conexao = DriverManager.getConnection("jdbc:postgresql://localhost:5432/ProgramaçãoWeb", "postgres", "123");

        String sql = "SELECT codigo, nomeDaDisciplina, nomeProfessor, matriculaProfessor, horarioInicioAula, horarioFimAula, DiaDeAula FROM disciplina WHERE matriculaProfessor = CAST(? AS int)";
        String matricula = request.getParameter("matricula");
        stmt = conexao.prepareStatement(sql);
        stmt.setString(1, matricula);
        rs = stmt.executeQuery();

        %><table>
            <tr>
              <th>codigo</th>
              <th>nomeDaDisciplina</th>
              <th>nomeProfessor</th>
              <th>matriculaProfessor</th>
              <th>horarioInicioAula</th>
              <th>horarioFimAula</th>
              <th>DiaDeAula</th>
            </tr><%

        while (rs.next()) {
            String codigo = rs.getString("codigo");
            String nomeDaDisciplina = rs.getString("nomeDaDisciplina");
            String nomeProfessor = rs.getString("nomeProfessor");
            String matriculaProfessor = rs.getString("matriculaProfessor");
            String horarioInicioAula = rs.getString("horarioInicioAula");
            String horarioFimAula = rs.getString("horarioFimAula");
            String DiaDeAula = rs.getString("DiaDeAula");

            %><tr>
              <td><%= codigo %></td>
              <td><%= nomeDaDisciplina %></td>
              <td><%= nomeProfessor %></td>
              <td><%= matriculaProfessor %></td>
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