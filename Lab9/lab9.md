# 9. Proceduri stocate și funcții definite de utilizator
## TASK 1

### Sa se creeze proceduri stocate in baza exercitiilor (2 exercitii) din capitolul 4. Parametrii de intrare trebuie sa corespunda criteriilor din clauzele WHERE ale exercitiilor respective .
```SQL
create procedure lab9_ex1_13
					@nume varchar(20)='Florea',
					@prenume varchar (20)='Ioan'

as 
select distinct d.Disciplina
from discipline d join studenti.studenti_reusita r
on d.Id_Disciplina=r.Id_Disciplina
join studenti s
on r.Id_Student=s.Id_Student
where s.Nume_Student=@nume and s.Prenume_Student=@prenume;
```
![image](https://user-images.githubusercontent.com/34598802/49919602-cbfeb780-feaf-11e8-9289-823dc0142c75.png)
```SQL
create procedure lab9_ex1_23
				@tip_evaluare varchar(20)='Examen',
				@average_grade int=7
as
select distinct d.Disciplina 
from discipline as d join studenti.studenti_reusita as r
on d.Id_Disciplina=r.Id_Disciplina
join
(select Id_Student, avg(nota) as average_grade from studenti.studenti_reusita where Tip_Evaluare=@tip_evaluare group by id_student) as t
on r.Id_student=t.Id_Student
where t.average_grade>@average_grade
order by d.disciplina desc;
```
![image](https://user-images.githubusercontent.com/34598802/49919696-2a2b9a80-feb0-11e8-9ec3-0f058496ba83.png)
## TASK 2

### Sa se creeze o procedura stocata, care nu are niciun parametru de intrare si poseda un parametru de iesire. Parametrul de ie~ire trebuie sa returneze numarul de studenti, care nu au sustinut eel putin o forma de evaluare (nota mai mica de 5 sau valoare NULL).
```SQL
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
```
![image](https://user-images.githubusercontent.com/34598802/49919936-09177980-feb1-11e8-8265-254c3f111ddc.png)
## TASK 3
### Sa se creeze o procedura stocata, care ar insera in baza de date informatii despre un student nou. In calitate de parametri de intrare sa serveasca datele personale ale studentului nou si Cod_Grupa. Sa se genereze toate intrarile-cheie necesare in tabelul studenti_reusita. Notele de evaluare sa fie inserate ca NULL.
```SQL
DROP PROCEDURE IF EXISTS Lab9_ex3
GO

CREATE PROCEDURE Lab9_ex3 
@numeA VARCHAR(50),
@prenumeA VARCHAR(50),
@data DATE,
@adresa VARCHAR(500),
@cod_grupa CHAR(6)

AS
INSERT INTO studentiA 
VALUES (99, @numeA, @prenumeA, @data, @adresa)
INSERT INTO reusitaA
VALUES (99, 100, 100 , 
         (SELECT Id_Grupa FROM grupe WHERE Cod_Grupa = @cod_grupa), 'examen', NULL, '2018-11-25')
```
![image](https://user-images.githubusercontent.com/34598802/49920196-08331780-feb2-11e8-9568-9cfd5f5c87e3.png)

