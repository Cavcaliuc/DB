# 10. CREAREA ȘI UTILIZAREA DECLANȘATOARELOR
## TASK 1

### Sa se modifice declansatorul inregistrare_noua,in asa fel,incat in cazul actualizarii auditoriului sa apara mesajul de informare, care, in afara de disciplina si ora, va afisa codul grupei afectate, ziua, blocul, auditoriul vechi si auditoriul nou.

```SQL
DROP TRIGGER IF EXISTS inregistrare_noua 
GO
CREATE TRIGGER inregistrare_noua ON plan_studii.orarul
AFTER UPDATE
AS SET NOCOUNT ON
IF UPDATE(Auditoriu)
SELECT 'Lectia la disciplina ' + UPPER(disciplineS.Disciplina)+ ', a grupei ' + grupe.Cod_Grupa +
		', ziua de ' + CAST(inserted.Zi as VARCHAR(5)) + ', de la ora ' + CAST(inserted.Ora as VARCHAR(5))
		+ ', a fost transferata in aula ' + CAST(inserted.Auditoriu as VARCHAR(5)) + ', Blocul '+
		CAST(inserted.Bloc as VARCHAR(5)) + '. Auditoriul vechi: ' + CAST(deleted.Auditoriu as VARCHAR(5))+
		', Auditoriul nou: ' + CAST(inserted.Auditoriu as VARCHAR(5))
FROM inserted,deleted, disciplineS, grupe
WHERE deleted.Id_Disciplina = disciplineS.Id_Disciplina
AND inserted.Id_Grupa = grupe.Id_Grupa
GO
```
Pina la modificari

![image](https://user-images.githubusercontent.com/34598802/49924551-5864a680-febf-11e8-9688-c1dd1752d195.png)
![image](https://user-images.githubusercontent.com/34598802/49924619-85b15480-febf-11e8-919f-8661ca36fde4.png)
DUPA

![image](https://user-images.githubusercontent.com/34598802/49924698-98c42480-febf-11e8-8b36-c7c1bb8343cd.png)
## TASK 2

### Sa se creeze declansatorul, care ar asigura popularea corecta (consecutiva) a tabelelor studenti si studenti_reusita,si ar permite evitarea erorilor la nivelul cheilor externe.
```SQL
CREATE TRIGGER Lab10_ex2 ON studenti.studenti_reusita
INSTEAD OF INSERT
AS SET NOCOUNT ON
   
  INSERT INTO studenti.studenti_reusita 
  SELECT * FROM inserted
  WHERE Id_Student in (SELECT Id_Student FROM studenti.studenti)
  GO

  INSERT INTO studentiS values (200,'AAA', 'BBB', '1999-11-18', null)
  INSERT INTO reusitaS values (200, 101, 101, 1, 'Examen', null, null)

 
  select * from studentiS where Id_Student= 200
  select * from reusitaS where Id_Student = 200
```
![image](https://user-images.githubusercontent.com/34598802/49924860-f9ebf800-febf-11e8-92f4-631adeda4c2a.png)
## TASK 3

### Sa se creeze un declansator, care ar interzice micsorarea notelor in tabelul studenti_reusita si modificarea valorilor campului Data_Evaluare, unde valorile acestui camp sunt nenule. Declansatorul trebuie sa se lanseze, numai daca sunt afectate datele studentilor din grupa ,,CIB 171 ". Se va afisa un mesaj de avertizare in cazul tentativei de a incalca constrangerea.
```SQL
IF OBJECT_ID('Lab10_ex3', 'TR') is not null
   DROP TRIGGER Lab10_ex3
   GO
CREATE TRIGGER Lab10_ex3 ON studenti.studenti_reusita
AFTER UPDATE
AS
SET NOCOUNT ON
IF UPDATE (Nota)
DECLARE @ID_GRUPA INT = (SELECT Id_Grupa  FROM grupe WHERE Cod_Grupa = 'CIB171')
DECLARE @count int = (SELECT count(*) FROM deleted , inserted 
			where deleted.Id_Disciplina = inserted.Id_Disciplina and deleted.Id_Grupa = inserted.Id_Grupa 
			and deleted.Id_Profesor = inserted.Id_Profesor and deleted.Tip_Evaluare = inserted.Tip_Evaluare 
			and deleted.Id_Student = inserted.Id_Student
			and inserted.Nota < deleted.Nota 
			and inserted.Id_Grupa = @ID_GRUPA)
	
BEGIN
IF (@count > 0 )
PRINT ('Nu se perminte micsorarea notelor pentru grupa CIB 171')
ROLLBACK TRANSACTION
end

IF UPDATE(Data_evaluare)
		SET @count = (SELECT count(*) FROM deleted WHERE Data_Evaluare is not null and Id_Grupa = @ID_GRUPA)
		IF @count > 0
		BEGIN
			PRINT ('Nu se permite modificarea campului Tip_Evaluare')
			ROLLBACK TRANSACTION
		END
GO
```
![image](https://user-images.githubusercontent.com/34598802/49924975-4e8f7300-fec0-11e8-87fd-8ec3416a2b91.png)
## TASK 4

### Sa se creeze un declansator DDL care ar interzice modificarea coloanei ld_Disciplina in tabelele bazei de date universitatea cu afisarea mesajului respectiv.
```SQL
DROP TRIGGER IF EXISTS ex4 ON DATABASE;  
GO
CREATE TRIGGER ex4
on database
for ALTER_TABLE
AS
SET NOCOUNT ON
DECLARE @Disciplina varchar(50)
SET @Disciplina =EVENTDATA(). value('(/EVENT_INSTANCE/AlterTableActionList/*/Columns/Name)[1]','nvarchar(max)')
IF @Disciplina='Disciplina'
BEGIN
PRINT ('Coloana Disciplina nu poate fi modificată');
ROLLBACK;
END
GO
```
![image](https://user-images.githubusercontent.com/34598802/49925219-f147f180-fec0-11e8-961d-b61a2a394322.png)
VERIFICARE

![image](https://user-images.githubusercontent.com/34598802/49925412-82b76380-fec1-11e8-8704-ad8649ff10a6.png)
## TASK 5

### Sa se creeze un declansator DDL care ar interzice modificarea schemei bazei de date in afara orelor de lucru.
```SQL
DROP TRIGGER IF EXISTS Lab10_ex5
GO
CREATE TRIGGER Lab10_ex5 
ON DATABASE
FOR ALTER_TABLE
AS
SET NOCOUNT ON
DECLARE @TimpulCurent TIME
DECLARE @Inceput TIME
DECLARE @Sfarsit TIME
SELECT @TimpulCurent = CONVERT(Time, GETDATE())
SELECT @Inceput = '8:00:00'
SELECT @Sfarsit = '17:00:00'

IF (@TimpulCurent < @Inceput) OR (@TimpulCurent > @Sfarsit)
BEGIN	
PRINT 'Baza de date nu poate fi modificata inafara orelor de lucru. Ora curenta: ' + cast(@TimpulCurent as VARCHAR(20))
ROLLBACK
END

GO

alter table studenti.studenti alter column Nume_Student varchar(49);
```
![image](https://user-images.githubusercontent.com/34598802/49925854-c78fca00-fec2-11e8-8185-52ec5436c844.png)
VERIFICARE

![image](https://user-images.githubusercontent.com/34598802/49925834-afb84600-fec2-11e8-8db9-dea06cd42765.png)
## TASK 6

### Sa se creeze un declansator DDL care, la modificarea proprietatilor coloanei ld_Profesor dintr-un tabel, ar face schimbari asemanatoare in mod automat in restul tabelelor.
```SQL
CREATE TRIGGER ex6 ON DATABASE
FOR ALTER_TABLE
AS
SET NOCOUNT ON
 DECLARE @D varchar(30)  
 DECLARE @event1 varchar(500)  
 DECLARE @event2 varchar(500)  
 DECLARE @event3 varchar(50) 
 SELECT @D=EVENTDATA(). value('(/EVENT_INSTANCE/AlterTableActionList/*/Columns/Name)[1]','nvarchar(max)')
 IF @D = 'Prenume_Profesor'    
 BEGIN  
 SELECT @event1 = EVENTDATA().value('(/EVENT_INSTANCE/TSQLCommand/CommandText)[1]','nvarchar(max)') 
 SELECT @event3 = EVENTDATA().value('(/EVENT_INSTANCE/ObjectName)[1]','nvarchar(max)') 
 SELECT @event2 = REPLACE(@event1, @event3, 'profesori'); EXECUTE (@event2) 
 SELECT @event2 = REPLACE(@event1, @event3, 'profesori_new');EXECUTE (@event2) 
PRINT 'Datele au fost modificate in toate tabelele'
END
go
```
![image](https://user-images.githubusercontent.com/34598802/49926027-4b49b680-fec3-11e8-914e-591784e2c47b.png)
```SQL
alter table profesori alter column Prenume_profesor varchar(60)
```
![image](https://user-images.githubusercontent.com/34598802/49926128-877d1700-fec3-11e8-9b1d-32f8f73cb355.png)
Inainte

![image](https://user-images.githubusercontent.com/34598802/49926183-ada2b700-fec3-11e8-9fc2-2e78576a44b3.png)
DUPA

![image](https://user-images.githubusercontent.com/34598802/49926219-ca3eef00-fec3-11e8-9f39-efdad6fc65d2.png)



