# 8.Administrarea viziunilor si a expresiilor-tabel
![image](https://user-images.githubusercontent.com/34598802/49867207-67414f80-fe12-11e8-90f8-7def37748ea4.png)
## TASK 1

### Să se creeze două viziuni in baza interogărilor formulate în două exerciții indicate din capitolul 4. Prima viziune sa fie construită în Editorul de interogări, iar a doua, utilizand View Designer.

a) Folosind Editorul de interogari

![image](https://user-images.githubusercontent.com/34598802/49869961-b1c6ca00-fe1a-11e8-99b0-08230a9cccfb.png)

b) Folosind View Designer

![image](https://user-images.githubusercontent.com/34598802/49870043-d753d380-fe1a-11e8-8e6f-d99e933c5ee6.png)
![image](https://user-images.githubusercontent.com/34598802/49870120-226de680-fe1b-11e8-8e8f-acc48d8f2edf.png)

## TASK 2

### Sa se scrie cate un exemplu de instructiuni INSERT, UPDATE, DELETE asupra viziunilor create. Sa se adauge comentariile respective referitoare la rezultatele executarii acestor instructiuni.

a) Pentru prima viziune
```SQL
-- Inserarea unui nou student in viziune (Nume, Prenume)

INSERT INTO View_ex1a_lab8 
values (99,'STUDENT', 'NOU')
GO

CREATW VIEW ex AS 
SELECT Id_Student, Nume_student , Prenume_Student FROM studentiA
go

-- Modificarea unui student in viziune
UPDATE dbo.View_ex1a_lab8 
SET Prenume_Student = 'TEODORA'
WHERE Prenume_Student = 'Teodora'
SELECT * FROM dbo.View_ex1a_lab8

-- Stergerea unui student din viziune
DELETE FROM ex WHERE Nume_Student = 'STUDENT'
```
#### Comentariu: Inserarea in viziune nu a fost posibila, deoarece noul tuplu nu satisface conditia viziunii. Din aceasta cauza, tuplul a fost inserat doar in tabelul general. 
![image](https://user-images.githubusercontent.com/34598802/49871018-c22c7400-fe1d-11e8-9fbe-9379f9777d1c.png)

b)Pentru a doua viziune
```SQL
-- Inserarea unui nou student in viziune (Nume, Prenume)

CREATE VIEW exercitiul1_1 AS 
SELECT  disciplineA.Id_Disciplina, disciplineA.Disciplina 
	FROM disciplineA
GO

INSERT INTO exercitiul1 
values (1,'FIZICA')
GO

-- Modificarea unui student in viziune
UPDATE exercitiul1 
SET Disciplina = 'Noua Disciplina'
WHERE id_disciplina = 100

-- Stergerea unui student din viziune
DELETE FROM exercitiul1_1 WHERE Disciplina = 'Fizica'
```
![image](https://user-images.githubusercontent.com/34598802/49871185-3404bd80-fe1e-11e8-9da3-f94523cbdf9d.png)
## TASK 3

### Sa se scrie instructiunile SQL care ar modifica viziunile create (in exercitiul 1) in asa fel, incat sa nu fie posibila modificarea sau stergerea tabelelor pe care acestea sunt definite si viziunile sa nu accepte operatiuni DML, daca conditiile clauzei WHERE nu sunt satisfacute.
A)
```SQL
ALTER VIEW View_ex1a_lab8 WITH SCHEMABINDING AS
SELECT studenti.studenti.Id_Student, studenti.studenti.Nume_Student , studenti.studenti.Prenume_Student 
FROM studenti.studenti, plan_studii.discipline , studenti.studenti_reusita
Where studenti.studenti.Id_Student = studenti.studenti_reusita.Id_Student
and plan_studii.discipline.Id_Disciplina = studenti.studenti_reusita.Id_Disciplina
and studenti.studenti_reusita.Tip_Evaluare = 'examen' 
and year(studenti.studenti_reusita.Data_Evaluare) = 2018 
and plan_studii.discipline.Disciplina = 'Baze de date'
and studenti.studenti_reusita.Nota between  4 and 8
WITH CHECK OPTION;
```
B)
```SQL
ALTER VIEW exercitiul1 WITH SCHEMABINDING AS
SELECT  plan_studii.discipline.Id_Disciplina, plan_studii.discipline.Disciplina 
FROM plan_studii.discipline, studenti.studenti_reusita, studenti.studenti
WHERE plan_studii.discipline.Id_Disciplina = studenti.studenti_reusita.Id_Disciplina
AND studenti.studenti_reusita.Id_Student = studenti.studenti.Id_Student
AND  studenti.studenti.Nume_Student = 'Florea' 
AND   studenti.studenti.Prenume_Student = 'Ioan'
WITH CHECK OPTION;
```
## TASK 4
### Sa se scrie instructiunile de testare a proprietatilor noi definite.


```SQL
INSERT INTO ex1a 
values (1, 1, 9.00, 2018-01-01, 'Testul 1','Lungu', 'Maria')

INSERT INTO ex1_b 
values (1, 'Lungu','Maria')
```
```SQL
UPDATE ex1a SET Nume_Student='Lungu'
WHERE Nume_Student = 'Brasoveanu';

UPDATE ex1_b SET Prenume_Student='Maria'
WHERE Prenume_Student = 'Teodora';
```
```SQL
DELETE FROM ex1a WHERE Prenume_Student='Maria';

DELETE FROM ex1_b WHERE Id_student=100;
```

## TASK 5
### Sa se rescrie 2 interogari formulate in exercitiile din capitolul 4, in asa fel incat interogarile imbricate sa fie redate sub forma expresiilor CTE.

a) ex.38 Furnizati denumirile disciplinelor cu o medie mai mica decat media notelor de la disciplina Baze de date.
```SQL
With ex38_cte (Nota) AS
    (Select AVG(cast(reusitaS.Nota as float)) as Medie
     FROM reusitaS, disciplineS
     WHERE Disciplina = 'Baze de date')

SELECT Disciplina, AVG(cast(reusitaS.Nota as float)) as Media
FROM disciplineS, reusitaS , ex38_cte
WHERE disciplineS.Id_Disciplina = reusitaS.Id_Disciplina
GROUP BY Disciplina
HAVING AVG(cast(reusitaS.Nota as float))< AVG(cast(ex38_cte.Nota as float))
```
![image](https://user-images.githubusercontent.com/34598802/49874269-c1e4a680-fe26-11e8-9515-595c0fd9d7b4.png)

b) ex.13
```SQL
WITH ex13_CTE (Id_Student) AS
    (SELECT studentiS.Id_Student
     FROM studentiS
     WHERE Nume_Student = 'Florea'
     AND Prenume_Student = 'Ioan' )

SELECT distinct disciplineS.Disciplina
FROM disciplineS, ex13_CTE, reusitaS
WHERE reusitaS.Id_Student = ex13_CTE.Id_Student
AND disciplineS.Id_Disciplina = reusitaS.Id_Disciplina
```
![image](https://user-images.githubusercontent.com/34598802/49874415-1720b800-fe27-11e8-8c5f-c3c00eee5f31.png)

## TASK 6
### Se considera un graf orientat, si fie se doreste parcursa calea de la nodul id = 3 la nodul unde id = 0. Sa se faca reprezentarea grafului orientat in forma de expresie-tabel recursiv.
```SQL
                     (4)
                      |
  (5)-> (0)<- (1)<-  (2)
                      ^
                      |
                     (3)
```
###  Sa se observe instructiunea de dupa UNION ALL a membrului recursiv, precum si partea de pana la UNION ALL reprezentata de membrul-ancora.
```SQL
CREATE TABLE graph (
		Id_nr int PRIMARY KEY,
		dependent_nr int
		);

INSERT INTO graph VALUES
(5,0), (4,2), (3,2), (1,0), (2,1), (0, null);

select * from graph

;WITH graph_cte AS (
		SELECT Id_nr , dependent_nr FROM graph
		WHERE Id_nr = 3 and dependent_nr = 2
		
		UNION ALL
		
		SELECT graph.Id_nr, graph.dependent_nr FROM graph
		INNER JOIN graph_cte
		ON graph.ID_nr = graph_cte.dependent_nr
		
		
	
		
)
SELECT * from graph_cte
```
![image](https://user-images.githubusercontent.com/34598802/49875205-1a1ca800-fe29-11e8-889f-4e2724e029f8.png)


