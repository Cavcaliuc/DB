CREATE PROCEDURE lab9_ex2
   @count_students INT = NULL OUTPUT
AS
SELECT @count_students =  COUNT(DISTINCT id_student) 
FROM studenti.studenti_reusita
WHERE Nota < 5 or Nota is NULL

--afisarea rezultatului

DECLARE @count_students INT
EXEC lab9_ex2 @count_students OUTPUT
PRINT 'Nr de studenti ce nu au sustinut cel putin o forma de evaluare = ' + cast(@count_students as VARCHAR(3))