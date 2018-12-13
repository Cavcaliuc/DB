WITH ex13_CTE (Id_Student) AS
    (SELECT studentiS.Id_Student
     FROM studentiS
     WHERE Nume_Student = 'Florea'
     AND Prenume_Student = 'Ioan' )

SELECT distinct disciplineS.Disciplina
FROM disciplineS, ex13_CTE, reusitaS
WHERE reusitaS.Id_Student = ex13_CTE.Id_Student
AND disciplineS.Id_Disciplina = reusitaS.Id_Disciplina