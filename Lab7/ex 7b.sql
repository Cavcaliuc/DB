GO
CREATE SYNONYM sr FOR
studenti.studenti_reusita;

SELECT Cod_Grupa FROM sr
	INNER JOIN grupe g on g.Id_Grupa = sr.Id_Grupa
GROUP BY Cod_Grupa
HAVING count(DISTINCT sr.Id_Student) > 24