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
```SQL
--- pentru executie 
exec Lab9_ex3  'Gomeniuc', 'Alina', '1999-04-24',' mun.Chisinau', 'TI171'

select * from studenti
```
![image](https://user-images.githubusercontent.com/34598802/49920997-c9529100-feb4-11e8-8d1c-ded27bf7df5d.png)
## TASK 4

### Fie ca un profesor se elibereaza din functie la mijlocul semestrului. Sa se creeze o procedura stocata care ar reatribui inregistrarile din tabelul studenti_reusita unui alt profesor. Parametri de intrare: numele si prenumele profesorului vechi, numele si prenumele profesorului nou, disciplina. in cazul in care datele inserate sunt incorecte sau incomplete, sa se afi~eze un mesaj de avertizare.
```SQL
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
```
![image](https://user-images.githubusercontent.com/34598802/49921349-f3588300-feb5-11e8-9782-5d8daaf38cb2.png)
![image](https://user-images.githubusercontent.com/34598802/49921443-34509780-feb6-11e8-9f6e-4db817d3bb99.png)
![image](https://user-images.githubusercontent.com/34598802/49922229-b3df6600-feb8-11e8-8ba3-cd5dd1f500e7.png)
## TASK 5

### Sa se creeze o procedura stocata care ar forma o lista cu primii 3 cei mai buni studenti la o disciplina, si acestor studenti sa le fie marita nota la examenul final cu un punct (nota maximala posibila este 10). In calitate de parametru de intrare, va servi denumirea disciplinei. Procedura sa returneze urmatoarele campuri: Cod_Grupa, Nume_Prenume_Student, Disciplina, Nota_ Veche, Nota_Noua.
```SQL
CREATE PROCEDURE lab9_ex5
@discipline VARCHAR(50)
AS
DECLARE @best TABLE (Id_Student int, Media float)
INSERT INTO @best
	SELECT TOP (3) studenti.studenti_reusita.Id_Student, AVG(cast (Nota as float)) as Media
	FROM studenti.studenti_reusita, discipline
	WHERE discipline.Id_Disciplina = studenti.studenti_reusita.Id_Disciplina
	AND discipline.Disciplina = @discipline
	GROUP BY studenti.studenti_reusita.Id_Student
	ORDER BY Media desc		

SELECT cod_grupa, nume_student+' '+Prenume_Student as Nume, disciplina, nota AS Nota_Veche, iif(nota > 9, 10, nota + 1) AS Nota_Noua 
    FROM studenti.studenti_reusita, discipline, grupe, studenti
	WHERE discipline.id_disciplina = studenti.studenti_reusita.id_disciplina
	AND grupe.Id_Grupa = studenti.studenti_reusita.Id_Grupa
	AND  studenti.Id_Student = studenti.studenti_reusita.Id_Student
	AND studenti.Id_Student in (select Id_Student from @best)
	AND Disciplina = @discipline
	AND Tip_Evaluare = 'Examen'

UPDATE studenti.studenti_reusita
SET studenti.studenti_reusita.Nota = (CASE WHEN nota >= 9 THEN 10 ELSE nota + 1 END)
WHERE Tip_Evaluare = 'Examen'
AND Id_Disciplina = (Select Id_Disciplina from discipline where disciplina=@discipline)
AND Id_Student in (select Id_Student from @best)

exec lab9_ex5 @discipline = 'Baze de date'
```
![image](https://user-images.githubusercontent.com/34598802/49922498-8b0ba080-feb9-11e8-8bed-d85c840c1bd9.png)
## TASK 6
### Sa se creeze functii definite de utilizator in baza exercitiilor (2 exercitii) din capitolul 4. Parametrii de intrare trebuie sa corespunda criteriilor din clauzele WHERE ale exercitiilor respective.
```SQL
DROP FUNCTION IF EXISTS Lab9_ex6_1 
GO
CREATE FUNCTION Lab9_ex6_1 (@evaluare VARCHAR(10), @an SMALLINT, @disciplina VARCHAR(20),
							@nota1 SMALLINT, @nota2 SMALLINT)
RETURNS TABLE
AS
RETURN
(SELECT distinct studentiS.Nume_Student ,studentiS.Prenume_Student 
FROM studentiS, reusitaS, disciplineS
WHERE studentiS.Id_Student = reusitaS.Id_Student
and disciplineS.Id_Disciplina = reusitaS.Id_Disciplina
and Tip_Evaluare = @evaluare
and year(Data_Evaluare) = @an 
and Disciplina = @disciplina
and Nota between  @nota1 and @nota2)
```
![image](https://user-images.githubusercontent.com/34598802/49923284-aaa3c880-febb-11e8-9ccb-4536361f60d8.png)
```SQL
DROP FUNCTION IF EXISTS Lab9_ex6_2
GO
CREATE FUNCTION Lab9_ex6_2 (@nume VARCHAR(20), @prenume VARCHAR(20))
RETURNS TABLE
AS
RETURN
(SELECT DISTINCT disciplineS.Disciplina
FROM disciplineS JOIN reusitaS ON disciplineS.Id_Disciplina = reusitaS.Id_Disciplina
				 JOIN studentiS ON reusitaS.Id_Student = studentiS.Id_Student
WHERE Nume_Student = @nume	
AND   Prenume_Student = @prenume
)
```
![image](https://user-images.githubusercontent.com/34598802/49923347-dde65780-febb-11e8-8045-c3ee6b48bcfa.png)
## TASK 7
### Sa se scrie functia care ar calcula varsta studentului. Sa se defineasca urmatorul format al functiei: <nume_functie>(<Data_Nastere_Student>).
```SQL
DROP FUNCTION IF EXISTS Lab9_ex7
GO

CREATE FUNCTION Lab9_ex7 (@data_nasterii DATE )
RETURNS INT
 BEGIN
 DECLARE @varsta INT
 SELECT @varsta = (SELECT (YEAR(GETDATE()) - YEAR(@data_nasterii) - CASE 
 						WHEN (MONTH(@data_nasterii) > MONTH(GETDATE())) OR (MONTH(@data_nasterii) = MONTH(GETDATE()) AND  DAY(@data_nasterii)> DAY(GETDATE()))
						THEN  1
						ELSE  0
						END))
 RETURN @varsta
 END
```
![image](https://user-images.githubusercontent.com/34598802/49923448-37e71d00-febc-11e8-849a-b38f441ae107.png)
## TASK 8

### Sa se creeze o functie definita de utilizator, care ar returna datele referitoare la reusita unui student. Se defineste urmatorul format al functiei : < nume_functie > (<Nume_Prenume_Student>). Sa fie afisat tabelul cu urmatoarele campuri: Nume_Prenume_Student, Disticplina, Nota, Data_Evaluare.
```SQL
DROP FUNCTION IF EXISTS Lab9_ex8
GO

CREATE FUNCTION Lab9_ex8 (@nume_prenume_s VARCHAR(50))
RETURNS TABLE 
AS
RETURN
(SELECT Nume_Student + ' ' + Prenume_Student as Student, Disciplina, Nota, Data_Evaluare
 FROM studentiS, disciplineS, reusitaS
 WHERE studentiS.Id_Student = reusitaS.Id_Student
 AND disciplineS.Id_Disciplina = reusitaS.Id_Disciplina 
 AND Nume_Student + ' ' + Prenume_Student = @nume_prenume_s )
```
![image](https://user-images.githubusercontent.com/34598802/49923550-87c5e400-febc-11e8-858c-057335b34582.png)
## TASK 9
### Se cere realizarea unei functii definite de utilizator, care ar gasi cel mai sarguincios sau cel mai slab student dintr-o grupa. Se defineste urmatorul format al functiei: <nume_functie> (<Cod_Grupa>, <is_good>). Parametrul <is_good> poate accepta valorile "sarguincios" sau "slab", respectiv. Functia sa returneze un tabel cu urmatoarele campuri Grupa, Nume_Prenume_Student, Nota Medie , is_good. Nota Medie sa fie cu precizie de 2 zecimale.
```SQL
DROP FUNCTION IF EXISTS Lab9_ex9
GO

CREATE FUNCTION Lab9_ex9 (@cod_grupa VARCHAR(10), @is_good VARCHAR(20))
RETURNS @Test Table (Cod_Grupa varchar(10), Student varchar (100), Media decimal(4,2), Reusita varchar(20))
AS
begin

if @is_good = 'sarguincios'
begin
insert into @Test

SELECT top (1) Cod_Grupa, Nume_Student + ' ' + Prenume_Student as Student,
		 CAST(AVG( Nota * 1.0) as decimal (4,2)) as Media, @is_good
 FROM grupe,studentiS, reusitaS
 WHERE grupe.Id_Grupa = reusitaS.Id_Grupa
 AND studentiS.Id_Student = reusitaS.Id_Student
 AND Cod_Grupa = @cod_grupa
 GROUP BY Cod_Grupa, Nume_Student, Prenume_Student
 Order by Media desc
 end
 else

 begin 
 insert into @Test
SELECT top (1) Cod_Grupa, Nume_Student + ' ' + Prenume_Student as Student,
		 CAST(AVG( Nota * 1.0) as decimal (4,2)) as Media, @is_good
 FROM grupe,studentiS, reusitaS
 WHERE grupe.Id_Grupa = reusitaS.Id_Grupa
 AND studentiS.Id_Student = reusitaS.Id_Student
 AND Cod_Grupa = @cod_grupa
 GROUP BY Cod_Grupa, Nume_Student, Prenume_Student
 Order by Media 
 
end


 RETURN 
 end
```
![image](https://user-images.githubusercontent.com/34598802/49923690-f73bd380-febc-11e8-8a6b-7a38b3df752b.png)
![image](https://user-images.githubusercontent.com/34598802/49923748-1b97b000-febd-11e8-8b0a-ee70a4e823f5.png)





