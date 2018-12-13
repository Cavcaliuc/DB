SELECT distinct studenti.studenti.Nume_Student , studenti.studenti.Prenume_Student 
FROM studenti.studenti, plan_studii.discipline , studenti.studenti_reusita
Where studenti.studenti.Id_Student = studenti.studenti_reusita.Id_Student
and plan_studii.discipline.Id_Disciplina = studenti.studenti_reusita.Id_Disciplina
and studenti.studenti_reusita.Tip_Evaluare = 'examen' 
and year(studenti.studenti_reusita.Data_Evaluare) = 2018 
and plan_studii.discipline.Disciplina = 'Baze de date'
and studenti.studenti_reusita.Nota between  4 and 8