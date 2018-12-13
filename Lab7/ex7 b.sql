SELECT DISTINCT plan_studii.discipline.Disciplina 
FROM plan_studii.discipline, studenti.studenti_reusita, studenti.studenti
WHERE plan_studii.discipline.Id_Disciplina = studenti.studenti_reusita.Id_Disciplina
AND studenti.studenti_reusita.Id_Student = studenti.studenti.Id_Student
AND  studenti.studenti.Nume_Student = 'Florea' 
AND   studenti.studenti.Prenume_Student = 'Ioan'