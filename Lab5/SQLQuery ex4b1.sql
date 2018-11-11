
--for ex2
--1metoda

declare @Nume_Disciplina varchar(20) = 'Baze de date';
declare @Tipul_Testului varchar(20) = 'Testul 1';
declare @Nota1 int = 6;
declare @Nota2 int = 8;

if @Nota1 = @Nota2 
   raiserror('Notele ce urmeaza a fi cautate au valori egale',2,2)
else
if @Nota1 !=any (select  top (10) Nota
from studenti, studenti_reusita, discipline
where studenti.Id_Student = studenti_reusita.Id_Student
and discipline.Id_Disciplina = studenti_reusita.Id_Disciplina
and Disciplina = @Nume_Disciplina
and Tip_Evaluare = @Tipul_Testului)

and @Nota2 != any (select  top (10) Nota
from studenti, studenti_reusita, discipline
where studenti.Id_Student = studenti_reusita.Id_Student
and discipline.Id_Disciplina = studenti_reusita.Id_Disciplina
and discipline.Id_Disciplina = studenti_reusita.Id_Disciplina
and Disciplina = @Nume_Disciplina
and Tip_Evaluare = @Tipul_Testului)

begin try
begin

select top (10) Nume_Student, Prenume_Student, Nota
from studenti, studenti_reusita, discipline
where studenti.Id_Student = studenti_reusita.Id_Student
and discipline.Id_Disciplina = studenti_reusita.Id_Disciplina
and Disciplina = @Nume_Disciplina
and Tip_Evaluare = @Tipul_Testului
and Nota not in (@Nota1, @Nota2)

end
end try
begin catch
print ' An error occured!' 
print 'The details of the error'
print ' The number of error:' + cast(ERROR_NUMBER() as varchar(20))
print ' Level of Severity:' + cast(ERROR_SEVERITY() as varchar(20))
print ' The error status:' + cast(ERROR_STATE() as varchar(20))
print ' The error line:' + cast(ERROR_LINE() as varchar(20))
end catch