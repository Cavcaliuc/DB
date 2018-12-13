DROP FUNCTION IF EXISTS Lab9_ex8
GO

CREATE FUNCTION Lab9_ex8 (@nume_prenume_s VARCHAR(50))
RETURNS TABLE 
AS
RETURN
(SELECT Nume_Student + ' ' + Prenume_Student as Student, Disciplina, Nota, Data_Evaluare
 FROM studentiS, disciplineS, reusitaS
 WHERE studentiS.Id_Student = reusitaS.Id_Student
 AND disciplineS.Id_Disciplina = reusitaS.Id_Disciplina 
 AND Nume_Student + ' ' + Prenume_Student = @nume_prenume_s )