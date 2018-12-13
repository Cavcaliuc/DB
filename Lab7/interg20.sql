---20. Afisati numarul de studenti care au sustinut testul (Testul 2) la disciplina Baze de date in 2018.

select count(distinct r.id_student) as nr_students
from studenti.studenti_reusita as r join plan_studii.discipline as d
on r.Id_Disciplina=d.Id_Disciplina
where r.Tip_Evaluare='Testul 2'and d.Disciplina='Baze de date' and r.Data_Evaluare like '2017S%';