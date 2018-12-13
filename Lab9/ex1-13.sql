create procedure lab9_ex1_13
					@nume varchar(20)='Florea',
					@prenume varchar (20)='Ioan'

as 
select distinct d.Disciplina
from discipline d join studenti.studenti_reusita r
on d.Id_Disciplina=r.Id_Disciplina
join studenti s
on r.Id_Student=s.Id_Student
where s.Nume_Student=@nume and s.Prenume_Student=@prenume;