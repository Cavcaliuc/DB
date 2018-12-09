
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

## Task 4
### Să se scrie o instrucțiune T-SQL, care ar mări toate notele de evaluare șefilor de grupe cu un punct. Nota maximală (10) nu poate fi mărită.

```SQL
UPDATE studenti_reusita
 SET Nota=Nota+1
 WHERE Nota<>10 and Nota in
 (SELECT Nota FROM studenti_reusita WHERE Id_Student IN(SELECT Sef_Grupa FROM grupe)) ;

SELECT * FROM studenti_reusita


```
![image](https://user-images.githubusercontent.com/34598802/49703404-5d9aca80-fc0d-11e8-853e-70fdbac86cda.png)

## Task 5
### Sa se creeze un tabel profesori_new, care include urmatoarele coloane: Id_Profesor,Nume _ Profesor, Prenume _ Profesor, Localitate, Adresa _ 1, Adresa _ 2.
a) Coloana Id_Profesor trebuie sa fie definita drept cheie primara și, în baza ei, sa fie construit un index CLUSTERED.

b) Cîmpul Localitate trebuie sa posede proprietatea DEFAULT= 'mun. Chisinau'.

c) Să se insereze toate datele din tabelul profesori în tabelul profesori_new. Să se scrie, cu acest scop, un număr potrivit de instrucțiuni T-SQL. Datele trebuie să fie transferate în felul următor:

![image](https://user-images.githubusercontent.com/34598802/49703454-e7e32e80-fc0d-11e8-8ba8-be1e539d2ed2.png)

În coloana Localitate să fie inserata doar informatia despre denumirea localității din coloana-sursă Adresa_Postala_Profesor. În coloana Adresa_l, doar denumirea străzii. În coloana Adresa_2, să se păstreze numărul casei și (posibil) a apartamentului.

```SQL
CREATE TABLE profesori_new
(Id_Profesor int NOT NULL
 ,Nume_Profesor char(255)
 ,Prenume_Profesor char(255)
 ,Localitate char (60) DEFAULT ('mun. Chisinau')
 ,Adresa_1 char (60)
 ,Adresa_2 char (60),
  CONSTRAINT [PK_profesori_new] PRIMARY KEY CLUSTERED 
(	Id_Profesor )) ON [PRIMARY]

INSERT INTO profesori_new (Id_Profesor,Nume_Profesor, Prenume_Profesor, Localitate,Adresa_1, Adresa_2)
(SELECT Id_Profesor, Nume_Profesor, Prenume_Profesor, Adresa_Postala_Profesor, Adresa_Postala_Profesor, Adresa_Postala_Profesor
from profesori)

UPDATE profesori_new
SET Localitate = case when CHARINDEX(', s.',Localitate) >0
				 then case when CHARINDEX (', str.',Localitate) > 0
							then SUBSTRING (Localitate,1, CHARINDEX (', str.',Localitate)-1)
					        when CHARINDEX (', bd.',Localitate) > 0
							then SUBSTRING (Localitate,1, CHARINDEX (', bd.',Localitate)-1)
				      end
				  when  CHARINDEX(', or.',Localitate) >0
				 then case when CHARINDEX (', str.',Localitate) > 0
							then SUBSTRING (Localitate,1, CHARINDEX ('str.',Localitate)-3)
					        when CHARINDEX (', bd.',Localitate) > 0
							then SUBSTRING (Localitate,1, CHARINDEX ('bd.',Localitate)-3)
					  end
				when CHARINDEX('nau',Localitate) >0
				then SUBSTRING(Localitate, 1, CHARINDEX('nau',Localitate)+2)
				end
UPDATE profesori_new
SET Adresa_1 = case when CHARINDEX('str.', Adresa_1)>0
					then SUBSTRING(Adresa_1,CHARINDEX('str',Adresa_1), PATINDEX('%, [0-9]%',Adresa_1)- CHARINDEX('str.',Adresa_1))
			        when CHARINDEX('bd.',Adresa_1)>0
					then SUBSTRING(Adresa_1,CHARINDEX('bd',Adresa_1), PATINDEX('%, [0-9]%',Adresa_1) -  CHARINDEX('bd.',Adresa_1))
			   end

UPDATE profesori_new
SET Adresa_2 = case when PATINDEX('%, [0-9]%',Adresa_2)>0
					then SUBSTRING(Adresa_2, PATINDEX('%, [0-9]%',Adresa_2)+1,len(Adresa_2) - PATINDEX('%, [0-9]%',Adresa_2)+1)
				end
				
select * from profesori_new
```
![image](https://user-images.githubusercontent.com/34598802/49703520-aef78980-fc0e-11e8-92ce-14d23e80ce53.png)

## Task 5
### Să se insereze datele in tabelul orarul pentru Grupa= 'CIBJ 71' (Id_ Grupa= 1) pentru ziua de luni. Toate lectiile vor avea loc în blocul de studii 'B'. Mai jos, sunt prezentate detaliile de inserare:

(ld_Disciplina = 107, Id_Profesor= 101, Ora ='08:00', Auditoriu = 202);

(Id_Disciplina = 108, Id_Profesor= 101, Ora ='11:30', Auditoriu = 501);

(ld_Disciplina = 119, Id_Profesor= 117, Ora ='13:00', Auditoriu = 501);

```SQL
CREATE TABLE orarul( Id_Disciplina int NOT NULL,
                       Id_Profesor int NOT NULL, 
					   Id_Grupa smallint NOT NULL,
					   Zi       char(2) NOT NULL,
					   Ora       Time NOT NULL,
					   Auditoriu  int ,
					   Bloc       char(1) NOT NULL DEFAULT ('B'),
CONSTRAINT [PK_orarul] PRIMARY KEY CLUSTERED 
(
	Id_Disciplina ASC,
	Id_Profesor,
	Id_Grupa ,
	ZI )) ON [PRIMARY]

INSERT orarul VALUES(107, 101, (SELECT Id_Grupa FROM grupe WHERE Cod_Grupa='CIB171'), 'Lu', '08:00', 202,DEFAULT)
INSERT orarul VALUES(108, 101, (SELECT Id_Grupa FROM grupe WHERE Cod_Grupa='CIB171'), 'Lu', '11:30', 501,DEFAULT)
INSERT orarul VALUES(109, 117, (SELECT Id_Grupa FROM grupe WHERE Cod_Grupa='CIB171'), 'Lu', '13:00', 501,DEFAULT)           

SELECT *  FROM orarul
```
![image](https://user-images.githubusercontent.com/34598802/49703749-bd937000-fc11-11e8-91d7-99eeb669eab1.png)
