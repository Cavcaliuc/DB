GO
CREATE SYNONYM discipline1 FOR
plan_studii.discipline;

ALTER table studenti.studenti_reusita
ALTER Column Nota decimal(4,2);

SELECT  Disciplina,
        AVG(Nota) as Nota_Medie
FROM  discipline1 
INNER JOIN sr
ON       discipline1.Id_Disciplina=sr.Id_Disciplina
GROUP BY Disciplina
HAVING AVG(sr.Nota)>(SELECT AVG(sr.Nota) AS Nota_Medie
FROM discipline1 
INNER JOIN sr
ON discipline1.Id_Disciplina=sr.Id_Disciplina
where Disciplina='Baze de date')