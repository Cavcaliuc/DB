--3. Aflati cursurile (Disciplina) predate de fiecare profesor (Nume_Profesor, Prenume_Profesor) sortate descrescator dupa nume si apoi prenume. 

select distinct d.Disciplina, p.Nume_Profesor, p.Prenume_Profesor
from plan_studii.discipline as d join studenti.studenti_reusita as r
on d.Id_Disciplina=r.Id_Disciplina
join cadre_didactice.profesori as p
on r.Id_Profesor=p.Id_Profesor
order by p.Nume_Profesor desc, p.Prenume_Profesor desc;