DROP PROCEDURE IF EXISTS Lab9_ex4
GO
CREATE PROCEDURE Lab9_ex4
@nume_prof_vechi VARCHAR(60),
@prenume_prof_vechi VARCHAR(60),
@nume_prof_nou VARCHAR(60),
@prenume_prof_nou VARCHAR(60),
@disciplina VARCHAR(20)

AS

IF(( SELECT disciplineS.Id_Disciplina FROM disciplineS WHERE Disciplina = @disciplina)
     IN (SELECT DISTINCT reusitaS.Id_Disciplina FROM reusitaS WHERE Id_Profesor =
	   (SELECT cadre_didactice.profesori.Id_Profesor FROM cadre_didactice.profesori WHERE Nume_Profesor = @nume_prof_vechi 
							                        AND Prenume_Profesor = @prenume_prof_vechi)))
BEGIN
UPDATE reusitaS
SET Id_Profesor =  (SELECT Id_Profesor
		    FROM cadre_didactice.profesori
		    WHERE Nume_Profesor = @nume_prof_nou
	            AND   Prenume_Profesor = @prenume_prof_nou)

WHERE Id_Profesor = (SELECT Id_profesor
		     FROM cadre_didactice.profesori
     		     WHERE Nume_Profesor = @nume_prof_vechi
	             AND Prenume_Profesor = @prenume_prof_vechi)
END
ELSE
BEGIN
  PRINT 'Something went wrong, check the input parameters'
END

EXECUTE lab9_exe4 'Micu','Elena','Structuri de date si algoritmi'
SELECT * FROM cadre_didactice.profesori, reusitaA
WHERE cadre_didactice.profesori.Id_Profersor=studenti_reusitaA.Id_Profesor
AND Nume_Profesor = 'Micu' AND Prenume_Profesor = 'Elena'



EXECUTE replaceProfesor
@Nume_Profesor_old='Micu',
@Prenume_Profesor_old='Elena',
@Nume_Profesor_new ='Verebceanu',
@Prenume_Profesor_new='Mirela',
@Disciplina='Structuri de date si algoritmi'

select * from profesori


