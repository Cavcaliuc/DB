--a) Folosind Editorul de interogari
CREATE VIEW exercitiul1b AS
	SELECT DISTINCT disciplineA.Disciplina 
	FROM disciplineA, reusitaA, studentiA
	WHERE disciplineA.Id_Disciplina = reusitaA.Id_Disciplina
	AND reusitaA.Id_Student = studentiA.Id_Student
	AND  studentiA.Nume_Student = 'Florea' 
	AND   studentiA.Prenume_Student = 'Ioan'
GO
	SELECT * FROM exercitiul1b