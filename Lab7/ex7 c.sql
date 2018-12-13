select plan_studii.discipline.Disciplina, COUNT(distinct studenti.studenti_reusita.Id_Profesor) as Nr_profesori
from plan_studii.discipline, studenti.studenti_reusita
where plan_studii.discipline.Id_Disciplina = studenti.studenti_reusita.Id_Disciplina
group by plan_studii.discipline.Disciplina
having count(distinct studenti.studenti_reusita.Id_Profesor) > 1