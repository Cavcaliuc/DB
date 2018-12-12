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
ALTER VIEW View_ex1_Lab8 WITH SCHEMABINDING AS
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

a) 1)
```SQL
ALTER TABLE studenti.studenti DROP COLUMN Nume_Student
```




