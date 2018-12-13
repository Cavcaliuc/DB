--ex.24 Sa se afiseze lista disciplinelor(Disciplina) predate de cel putin doi profesori.

select disciplineA.Disciplina, COUNT(distinct reusitaA.Id_Profesor) as Nr_profesori
from disciplineA, reusitaA
where disciplineA.Id_Disciplina = reusitaA.Id_Disciplina
group by disciplineA.Disciplina
having count(distinct reusitaA.Id_Profesor) > 1