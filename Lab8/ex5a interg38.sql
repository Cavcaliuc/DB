With ex38_cte (Nota) AS
    (Select AVG(cast(reusitaS.Nota as float)) as Medie
     FROM reusitaS, disciplineS
     WHERE Disciplina = 'Baze de date')

SELECT Disciplina, AVG(cast(reusitaS.Nota as float)) as Media
FROM disciplineS, reusitaS , ex38_cte
WHERE disciplineS.Id_Disciplina = reusitaS.Id_Disciplina
GROUP BY Disciplina
HAVING AVG(cast(reusitaS.Nota as float))< AVG(cast(ex38_cte.Nota as float))