--38. Furnizați denumirile disciplinelor cu o medie mai mică decît media notelor de la disciplina Baze de date.
ALTER table studenti.studenti_reusita
ALTER Column Nota decimal(4,2);

SELECT  plan_studii.discipline.Disciplina,
       AVG(Nota) as Nota_Medie
FROM  plan_studii.discipline 
INNER JOIN studenti.studenti_reusita 
ON       plan_studii.discipline.Id_Disciplina=studenti.studenti_reusita.Id_Disciplina
GROUP BY Disciplina
HAVING AVG(studenti.studenti_reusita.Nota)>(SELECT AVG(studenti.studenti_reusita.Nota) AS Nota_Medie
FROM plan_studii.discipline 
INNER JOIN studenti.studenti_reusita 
ON plan_studii.discipline.Id_Disciplina=studenti.studenti_reusita .Id_Disciplina
where Disciplina='Baze de date')