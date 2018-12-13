--ex.13 Aflati cursurile urmate de catre studentul Florea loan.
CREATE SYNONYM studentiA FOR studenti.studenti
CREATE SYNONYM reusitaA FOR studenti.studenti_reusita
CREATE SYNONYM disciplineA FOR plan_studii.discipline

SELECT DISTINCT disciplineA.Disciplina 
FROM disciplineA, reusitaA, studentiA
WHERE disciplineA.Id_Disciplina = reusitaA.Id_Disciplina
AND reusitaA.Id_Student = studentiA.Id_Student
AND  studentiA.Nume_Student = 'Florea' 
AND   studentiA.Prenume_Student = 'Ioan'