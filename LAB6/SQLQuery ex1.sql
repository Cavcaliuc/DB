--ex1
--Sa se scrie o instructiune T-SQL, care ar popula coloana Adresa _ Postala _ Profesor
--din tabelul profesori cu valoarea 'mun. Chisinau',unde adresa este necunoscută.

UPDATE profesori set Adresa_Postala_Profesor = 'mun.Chisinau'
				 where Adresa_Postala_Profesor IS NULL;

SELECT Nume_Profesor, Prenume_Profesor, Adresa_Postala_Profesor
FROM profesori