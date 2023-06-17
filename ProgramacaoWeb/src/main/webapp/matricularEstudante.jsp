<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Matricular Estudante</title>
</head>
<body>
    <h1>Matricular Estudante</h1>
    <form action="MatriculaEstudanteServlet" method="post">
        <label for="codigoDisciplina">Código da Disciplina:</label>
        <input type="text" id="codigoDisciplina" name="codigoDisciplina" required><br><br>
        
        <label for="matriculaEstudante">Matrícula do Estudante:</label>
        <input type="text" id="matriculaEstudante" name="matriculaEstudante" required><br><br>
        
        <input type="submit" value="Matricular Estudante">
    </form>
</body>
</html>
