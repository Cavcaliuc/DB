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





