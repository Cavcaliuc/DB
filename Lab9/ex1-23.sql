create procedure lab9_ex1_23
				@tip_evaluare varchar(20)='Examen',
				@average_grade int=7
as
select distinct d.Disciplina 
from discipline as d join studenti.studenti_reusita as r
on d.Id_Disciplina=r.Id_Disciplina
join
(select Id_Student, avg(nota) as average_grade from studenti.studenti_reusita where Tip_Evaluare=@tip_evaluare group by id_student) as t
on r.Id_student=t.Id_Student
where t.average_grade>@average_grade
order by d.disciplina desc;