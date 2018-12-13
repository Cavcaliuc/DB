DROP FUNCTION IF EXISTS Lab9_ex6_11 
GO
CREATE FUNCTION Lab9_ex6_11 (@evaluare VARCHAR(10), @an SMALLINT, @disciplina VARCHAR(20),
							@nota1 SMALLINT, @nota2 SMALLINT)
RETURNS TABLE
AS
RETURN
(SELECT distinct studentiS.Nume_Student ,studentiS.Prenume_Student 
FROM studentiS, reusitaS, disciplineS
WHERE studentiS.Id_Student = reusitaS.Id_Student
and disciplineS.Id_Disciplina = reusitaS.Id_Disciplina
and Tip_Evaluare = @evaluare
and year(Data_Evaluare) = @an 
and Disciplina = @disciplina
and Nota between  @nota1 and @nota2)