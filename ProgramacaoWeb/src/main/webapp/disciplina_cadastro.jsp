<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Cadastro de Disciplina</title>
</head>
<body>
    <h1>Cadastro de Disciplina</h1>
    <form action="DisciplinaCadastroServlet" method="post">
        <label for="codigo">Código da disciplina:</label>
        <input type="text" id="codigo" name="codigo" required><br>
        <label for="nomeDisciplina">Nome da disciplina:</label>
        <input type="text" id="nomeDisciplina" name="nomeDisciplina" required><br>
        <label for="nomeProfessor">Nome do professor:</label>
        <input type="text" id="nomeProfessor" name="nomeProfessor" required><br>
        <label for="matriculaProfessor">Matrícula do professor:</label>
        <input type="text" id="matriculaProfessor" name="matriculaProfessor" required><br>
        <label for="horarioInicioAula">Horário de início da aula:</label>
        <input type="text" id="horarioInicioAula" name="horarioInicioAula" required><br>
        <label for="horarioFimAula">Horário de fim da aula:</label>
        <input type="text" id="horarioFimAula" name="horarioFimAula" required><br>
        <label for="diaDaAula">Dia da aula:</label>
        <input type="text" id="diaDaAula" name="diaDaAula" required><br>
        <input type="submit" value="Cadastrar">
    </form>
    <form action="diarioDaDisciplina.jsp" method="POST">
    <label>
        Matrícula:
        <input type="text" name="matricula" required>
    </label>
	<br>
    <input type="submit" value="Cadastrar">
</form>
</body>
</html>
