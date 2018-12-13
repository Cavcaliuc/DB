# 5.Transact-SQL: instrucțiuni procedurale  

![image](https://user-images.githubusercontent.com/34598802/47282917-a361ec00-d5e9-11e8-9382-4240c2c32ad3.png)

# TASK 1
## Completati urmatorul cod pentru a afisa cel mai mare numar dintre cele trei numere prezentate:

```SQL
declare @N1 int , @N2 int, @N3 int;
declare @MAI_MARE int;
set @N1 = 60 * rand();
set @N2 = 60 * rand();
set @N3 = 60 * rand();
set @MAI_MARE = @N1;
if @MAI_MARE < @N2
   set @MAI_MARE = @N2;
if @MAI_MARE < @N3
   set @MAI_MARE = @N3;

print @N1;
print @N2;
print @N3;
print 'Mai mare = ' + cast(@MAI_MARE as varchar(2));
```

![image](https://user-images.githubusercontent.com/34598802/48316882-eebc5880-e5f1-11e8-899c-4109849c2e03.png)


# TASK 2
## Afisati primele zece date(numele, prenumele studentului) in functie de valoarea notei (cu exceptia notelor 6 si 8) a studentului la primul test al disciplinei Baze de date, folosind structura de altemativa IF. .. ELSE. Sa se foloseasca variabilele

## Method 1
```SQL
declare @Nume_Disciplina varchar(20) = 'Baze de date';
declare @Tipul_Testului varchar(20) = 'Testul 1';
declare @Nota1 int = 6;
declare @Nota2 int = 8;

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
and Disciplina = @Nume_Disciplina
and Tip_Evaluare = @Tipul_Testului)

begin

select  top (10) Nume_Student, Prenume_Student, Nota
from studenti, studenti_reusita, discipline
where discipline.Id_Disciplina = studenti_reusita.Id_Disciplina
and studenti.Id_Student = studenti_reusita.Id_Student
and Disciplina = @Nume_Disciplina
and Tip_Evaluare = @Tipul_Testului
and Nota not in (@Nota1, @Nota2)

end
```
![image](https://user-images.githubusercontent.com/34598802/48317290-6097a080-e5f8-11e8-913e-22706e8d2055.png)

## Method 2:

``` SQL
DECLARE @Tip_Evaluare VARCHAR(20) = 'Testul 1';
DECLARE @Nume_Disciplina VARCHAR(20) = 'Baze de date';


SELECT TOP 10 Nume_Student, Prenume_Student
FROM studenti
WHERE Id_Student IN (	
	SELECT IIF(Nota <> 6 AND Nota <> 8, Id_Student, null)
	 FROM studenti_reusita, discipline  
	 WHERE studenti_reusita.Id_Disciplina = discipline.Id_Disciplina
	 AND Tip_Evaluare = @TIP_EVALUARE and Disciplina = @Nume_Disciplina
)
```
![image](https://user-images.githubusercontent.com/34598802/48317358-68a41000-e5f9-11e8-935f-4653665a59f3.png)


# Task 3:
## Rezolvati aceesi sarcina, 1, apeland la structura selectiva CASE.

```SQL
declare @N1 int , @N2 int, @N3 int;
declare @MAI_MARE int;
set @N1 = 60 * rand();
set @N2 = 60 * rand();
set @N3 = 60 * rand();
set @MAI_MARE = @N1;
set @MAI_MARE = case 
    when  @MAI_MARE < @N2 and @N3 < @N2
    then  @N2
    when @MAI_MARE < @N3 and @N2<@N3
    then  @N3
    else @MAI_MARE
    end   
print @N1;
print @N2;
print @N3;
print 'Mai mare = ' + cast( @MAI_MARE   as varchar(2));
```
![image](https://user-images.githubusercontent.com/34598802/48317390-24fdd600-e5fa-11e8-919e-7124875081ce.png)


# Task 4:
## Modificati exercitiile din sarcinile 1 si 2 pentru a include procesarea erorilor cu TRY, CATCH, si RAISERRROR.

## For Ex1:
```SQL
declare @N1 int , @N2 int, @N3 int;
declare @MAI_MARE int;
set @N1 = 60 * rand();
set @N2 = 60 * rand();
set @N3 = 60 * rand() ;
set @MAI_MARE = @N1;

begin try
if @N1 = @N2 or @N1 = @N3 or @N2 = @N3 
    raiserror ('Some numbers have the same value', 1,1)
else
begin
if @MAI_MARE < @N2
   set @MAI_MARE = @N2;
if @MAI_MARE < @N3
   set @MAI_MARE = @N3;
print @N1;
print @N2;
print @N3;
print 'Mai mare = ' + cast(@MAI_MARE as varchar(2));
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
```   
![image](https://user-images.githubusercontent.com/34598802/48317440-08ae6900-e5fb-11e8-8a50-e3b817959486.png)


## For Ex2:

## Method 1:
```SQL
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
```

![image](https://user-images.githubusercontent.com/34598802/48317467-75c1fe80-e5fb-11e8-9ae3-ac21ecc2d494.png)


## Method 2:
```SQL
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
```
![image](https://user-images.githubusercontent.com/34598802/48317490-ce919700-e5fb-11e8-87b2-693b619e2ebd.png)
