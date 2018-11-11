
--2metoda

DECLARE @Tip_Evaluare VARCHAR(20) = 'Testul 1' ;
DECLARE @Nume_Disciplina VARCHAR(20)= 'Baze de date';

begin try

if @Tip_Evaluare = null 
  raiserror ('Tip_Evaluare is not known',3,3)
else if @Nume_Disciplina = null
  raiserror ('Nume_Disciplina is not known',3,3)

else
SELECT TOP 10 Nume_Student, Prenume_Student 
FROM studenti
WHERE Id_Student IN (	
	SELECT IIF(Nota <> 6 AND Nota <> 8, Id_Student, null)
	 FROM studenti_reusita, discipline
	WHERE studenti_reusita.Id_Disciplina = discipline.Id_Disciplina
	AND Tip_Evaluare = @Tip_Evaluare and Disciplina = @Nume_Disciplina
)
end try
begin catch
print ' An error occured!' 
print 'The details of the error'
print ' The number of error:' + cast(ERROR_NUMBER() as varchar(20))
print ' Level of Severity:' + cast(ERROR_SEVERITY() as varchar(20))
print ' The error status:' + cast(ERROR_STATE() as varchar(20))
print ' The error line:' + cast(ERROR_LINE() as varchar(20))
end catch