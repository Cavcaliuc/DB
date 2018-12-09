
# 6. CREAREA TABELELOR SI INDECSILOR 

## Task 1
### Sa se scrie o instructiune T-SQL, care ar popula coloana Adresa _ Postala _ Profesor din tabelul profesori cu valoarea 'mun. Chisinau',unde adresa este necunoscută.

```SQL
UPDATE profesori set Adresa_Postala_Profesor = 'mun.Chisinau'
				 where Adresa_Postala_Profesor IS NULL;

SELECT Nume_Profesor, Prenume_Profesor, Adresa_Postala_Profesor
FROM profesori
```
![image](https://user-images.githubusercontent.com/34598802/48318052-8d04ea00-e603-11e8-9cc0-3e6904d75822.png)

## Task 2
### Sa se modifice schema tabelului grupe, ca sa corespunda urmatoarelor cerinte:<br/>
  a) Campul Cod_ Grupa sa accepte numai valorile unice și să nu accepte valori necunoscute. <br/>
  b) Să se țină cont că cheie primară, deja, este definită asupra coloanei Id_ Grupa. <br/>

  ```SQL
--   a) Campul Cod_ Grupa sa accepte numai valorile unice și să nu accepte valori necunoscute.
        ALTER TABLE grupe 
        ADD UNIQUE (Cod_Grupa);

--   b) Să se țină cont că cheie primară, deja, este definită asupra coloanei Id_ Grupa.       
      ALTER TABLE grupe
      ALTER COLUMN Cod_Grupa char(6) NOT NULL;

select Cod_Grupa
from grupe
```
![image](https://user-images.githubusercontent.com/34598802/48318171-fcc7a480-e604-11e8-8983-353ac6982fc4.png)

## Task 3
### La tabelul grupe, să se adauge 2 coloane noi Sef_grupa și Prof_Indrumator, ambele de tip INT. Să se populeze câmpurile nou-create cu cele mai potrivite candidaturi în baza criteriilor de mai jos:

a) Șeful grupei trebuie să aibă cea mai bună reușită (medie) din grupă la toate formele de evaluare și la toate disciplinele. Un student nu poate fi șef de grupa la mai multe grupe.

b) Profesorul îndrumător trebuie să predea un număr maximal posibil de discipline la grupa data. Daca nu există o singură candidatură, care corespunde primei cerințe, atunci este ales din grupul de candidați acel cu identificatorul (Id_Profesor) minimal. Un profesor nu poate fi indrumător la mai multe grupe.

c) Să se scrie instructiunile ALTER, SELECT, UPDATE necesare pentru crearea coloanelor în tabelul grupe, pentru selectarea candidaților și înserarea datelor.

```SQL
ALTER TABLE grupe
ADD Sef_Grupa int,Prof_Indrumator int;

DECLARE c1 CURSOR FOR 
SELECT id_grupa FROM grupe 

DECLARE @gid int
  ,@sid int
  ,@pid int

OPEN c1
FETCH NEXT FROM c1 into @gid 
WHILE @@FETCH_STATUS = 0
BEGIN
SELECT TOP 1 @sid=id_student
 FROM studenti_reusita
 WHERE id_grupa = @gid and Id_Student NOT IN (SELECT isnull(sef_grupa,'') FROM grupe)
 GROUP BY id_student
 ORDER BY cast(avg (NOTA*1.0)as decimal(5,2)) DESC

SELECT TOP 1 @pid=id_profesor
    FROM studenti_reusita
    WHERE id_grupa = @gid AND Id_profesor NOT IN (SELECT isnull (prof_indrumator, '') FROM grupe)
    GROUP BY id_profesor
    ORDER BY count (DISTINCT id_disciplina) DESC, id_profesor

UPDATE grupe
  SET   sef_grupa = @sid
    ,prof_indrumator = @pid
WHERE Id_Grupa=@gid
FETCH NEXT FROM c1 into @gid 
END
CLOSE c1
DEALLOCATE c1

Select *
from grupe

```

![image](https://user-images.githubusercontent.com/34598802/49703301-00eae000-fc0c-11e8-89df-3b6b3eaa0352.png)

## Task 3
### Să se scrie o instrucțiune T-SQL, care ar mări toate notele de evaluare șefilor de grupe cu un punct. Nota maximală (10) nu poate fi mărită.

```SQL
UPDATE studenti_reusita
 SET Nota=Nota+1
 WHERE Nota<>10 and Nota in
 (SELECT Nota FROM studenti_reusita WHERE Id_Student IN(SELECT Sef_Grupa FROM grupe)) ;

SELECT * FROM studenti_reusita


```

