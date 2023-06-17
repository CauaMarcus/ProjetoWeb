<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Document</title>
</head>
<body>
  <form action="ProfessorCadastroServlet" method="POST">
    <label>
        Matrícula:
        <input type="text" name="matricula" required>
    </label>
    <br>
    <label>
        Nome completo:
        <input type="text" name="nome" required>
    </label>
    <br>
    <label>
        Email:
        <input type="email" name="email" required>
    </label>
    <br>
    <label>
        Ano de egresso:
        <input type="number" name="anoEgresso" required>
    </label>
    <br>
    
    <br>
    <input type="submit" value="Cadastrar">
</form>
<form action="quadroHorarioProfessor.jsp" method="POST">
    <label>
        Matrícula:
        <input type="text" name="matricula" required>
    </label>
	<br>
    <input type="submit" value="Cadastrar">
</form>
</body>
</html>