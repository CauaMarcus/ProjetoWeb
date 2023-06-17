CREATE TABLE estudante(
	matricula INTEGER primary key,
	nome VARCHAR(100),
	email VARCHAR(100),
	anoEgresso INTEGER
);

SELECT * From estudante;

CREATE TABLE professor(
	matricula INTEGER primary key,
	nome VARCHAR(100),
	email VARCHAR(100),
	anoEgresso INTEGER
);
SELECT * From professor;

CREATE TABLE disciplina(
	codigo INTEGER primary key,
	nomeDaDisciplina VARCHAR(100),
	nomeProfessor VARCHAR(100),
	matriculaProfessor INTEGER REFERENCES professor(matricula),
	horarioInicioAula Time Without Time Zone,
	horarioFimAula Time Without Time Zone,
	DiadeAula VARCHAR(100)
);

SELECT * FROM disciplina;
SELECT codigo, 
nomeDaDisciplina, nomeProfessor, matriculaProfessor, 
horarioInicioAula, horarioFimAula, DiaDeAula FROM disciplina WHERE matriculaProfessor = CAST(? AS int));


INSERT INTO disciplina (codigo, nomeDaDisciplina, nomeProfessor, matriculaProfessor, horarioInicioAula, horarioFimAula, DiaDeAula)
VALUES ('1233', 'Programacao Web', 'Iann', '321', '07:00', '9:40', 'quarta-feita');
DELETE FROM disciplina
WHERE codigo = 1233;

CREATE TABLE matricula (
    codigoDisciplina INTEGER REFERENCES disciplina(codigo),
    matriculaEstudante INTEGER REFERENCES estudante(matricula),
    PRIMARY KEY (codigoDisciplina, matriculaEstudante)
);
SELECT * FROM estudante;
SELECT * FROM matricula;