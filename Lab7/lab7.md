# 7. DIAGRAME, SCHEME SI SINONIME

![image](https://user-images.githubusercontent.com/34598802/49800779-187fb100-fd51-11e8-864f-aaffd40ebe7e.png)

## Task 1

### Creați o diagramă a bazei de date, folosind forma de vizualizare standard, structura căreia este descrisă la începutul sarcinilor practice din capitolul 4. 
![image](https://user-images.githubusercontent.com/34598802/49801060-cdb26900-fd51-11e8-88d4-24ab8f134143.png)

## Task 2

### Să se adauge constrîngeri referențiale (legate cu tabelele studenti și profesori) necesare coloanelor Sef_grupa și Prof_Indrumator (sarcina3, capitolul 6) din tabelul grupe.
![image](https://user-images.githubusercontent.com/34598802/49801368-a7d99400-fd52-11e8-9ef0-9e49c3a97386.png)
![image](https://user-images.githubusercontent.com/34598802/49801405-c049ae80-fd52-11e8-968d-ff01d858cc2d.png)
### The new database diagram 
![image](https://user-images.githubusercontent.com/34598802/49801483-fa1ab500-fd52-11e8-917f-513c9c001642.png)
## Task 3

### La diagrama construită, să se adauge și tabelul orarul definit în capitolul 6 al acestei lucrari:tabelul orarul conține identificatorul disciplinei (ld_Disciplina), identificatorul profesorului(Id_Profesor) și blocul de studii (Bloc). Cheia tabelului este constituită din trei cîmpuri:identificatorul grupei (Id_ Grupa), ziua lectiei (Z1), ora de inceput a lectiei (Ora), sala unde are loc lectia (Auditoriu)
```SQL
drop table orarul
CREATE TABLE orarul ( Id_Disciplina int NOT NULL,
                       Id_Profesor int NOT NULL, 
					   Id_Grupa smallint NOT NULL,
					   Zi       char(2) NOT NULL,
					   Ora       Time NOT NULL,
					   Auditoriu  int NOT NULL,
					   Bloc       char(1) NOT NULL DEFAULT ('B'),
CONSTRAINT [PK_orarul] PRIMARY KEY CLUSTERED 
(
	Id_Grupa ASC,
	Zi ASC,
	Ora ASC,
	Auditoriu )) ON [PRIMARY]

INSERT orarul VALUES(107, 101, (SELECT Id_Grupa FROM grupe WHERE Cod_Grupa='CIB171'), 'Lu', '08:00', 202,DEFAULT)
INSERT orarul VALUES(108, 101, (SELECT Id_Grupa FROM grupe WHERE Cod_Grupa='CIB171'), 'Lu', '11:30', 501,DEFAULT)
INSERT orarul VALUES(109, 117, (SELECT Id_Grupa FROM grupe WHERE Cod_Grupa='CIB171'), 'Lu', '13:00', 501,DEFAULT)   

INSERT INTO orarul (Id_Disciplina,Id_Profesor,Id_Grupa,Zi,Ora,Auditoriu,Bloc) 
VALUES ((SELECT Id_Disciplina FROM discipline WHERE Disciplina='Structuri de date si algoritmi'),
        (SELECT Id_Profesor FROM profesori WHERE Nume_Profesor='Bivol' and Prenume_Profesor='Ion' ),
        (SELECT Id_Grupa FROM grupe WHERE Cod_Grupa='INF171'),'Lu','08:00',115,DEFAULT)
    
INSERT INTO orarul (Id_Disciplina,Id_Profesor,Id_Grupa,Zi,Ora,Auditoriu,Bloc) 
VALUES ((SELECT Id_Disciplina FROM discipline WHERE Disciplina='Programe aplicative'),
        (SELECT Id_Profesor FROM profesori WHERE Nume_Profesor='Mircea' and Prenume_Profesor='Sorin' ),
        (SELECT Id_Grupa FROM grupe WHERE Cod_Grupa='INF171'),'Lu','11:30',113,DEFAULT)

INSERT INTO orarul (Id_Disciplina,Id_Profesor,Id_Grupa,Zi,Ora,Auditoriu,Bloc) 
VALUES ((SELECT Id_Disciplina FROM discipline WHERE Disciplina='Baze de date'),
        (SELECT Id_Profesor FROM profesori WHERE Nume_Profesor='Micu' and Prenume_Profesor='Elena' ),
        (SELECT Id_Grupa FROM grupe WHERE Cod_Grupa='INF171'),'Lu','13:00',118,DEFAULT)
```
![image](https://user-images.githubusercontent.com/34598802/49802089-9c876800-fd54-11e8-93d3-957aa4e38a0e.png)
![image](https://user-images.githubusercontent.com/34598802/49802324-436c0400-fd55-11e8-8443-836d7fec5f2a.png)
![image](https://user-images.githubusercontent.com/34598802/49802366-5e3e7880-fd55-11e8-9184-2f23fdefee65.png)
## Task 4

### Tabelul orarul trebuie să conțină și 2 chei secundare: (Zi, Ora, Id_ Grupa, Id_ Profesor) și (Zi, Ora, ld_Grupa, ld_Disciplina).
![image](https://user-images.githubusercontent.com/34598802/49852298-6695c280-fdec-11e8-98ad-decff60e0582.png)
![image](https://user-images.githubusercontent.com/34598802/49852326-7c0aec80-fdec-11e8-9bb8-7f1e58b5109c.png)
## Task 5

### În diagrama, de asemenea, trebuie sa se defineasca constrangerile referentiale (FK-PK) ale atributelor ld_Disciplina, ld_Profesor, Id_ Grupa din tabelului orarul cu atributele tabelelor respective.
![image](https://user-images.githubusercontent.com/34598802/49852407-a8bf0400-fdec-11e8-9838-6b88c7effb2f.png)
![image](https://user-images.githubusercontent.com/34598802/49852450-cb511d00-fdec-11e8-854d-73045a4d1b6d.png)
## Task 6

### Creați, în baza de date universitatea, trei scheme noi: cadre_didactice, plan_studii și studenti. Transferați tabelul profesori din schema dbo in schema cadre didactice, ținînd cont de dependentele definite asupra tabelului menționat. În același mod să se trateze tabelele orarul,discipline care aparțin schemei plan_studii și tabelele studenți, studenti_reusita, care apartin schemei studenti. Se scrie instructiunile SQL respective.
```SQL
CREATE SCHEMA cadre_didactice
GO
ALTER SCHEMA cadre_didactice TRANSFER dbo.profesori

GO
CREATE SCHEMA plan_studii
GO
ALTER SCHEMA plan_studii TRANSFER dbo.orarul
ALTER SCHEMA plan_studii TRANSFER dbo.discipline

GO
CREATE SCHEMA studenti
GO
ALTER SCHEMA studenti TRANSFER dbo.studenti
ALTER SCHEMA studenti TRANSFER dbo.studenti_reusita
```
![image](https://user-images.githubusercontent.com/34598802/49852555-25ea7900-fded-11e8-9679-a9b201e42e26.png)
## Task 7

### Modificati 2-3 interogari asupra bazei de date universitatea prezentate in capitolul 4 astfel ca numele tabelelor accesate sa fie descrise in mod explicit, ținînd cont de faptul ca tabelele au fost mutate in scheme noi.

#### ex.5 Sa se afiseze lista studentilor al caror nume se termina in ,,u" 
```SQL
select nume_student, prenume_student
from studenti.studenti
where Nume_Student like '%u';
```
![image](https://user-images.githubusercontent.com/34598802/49854138-f4c07780-fdf1-11e8-9f50-636518a42b02.png)
#### ex.10 Gasiti studentii (numele, prenumele), care au obtinut la disciplina Baze de date (examen), în anul 2018, vreo nota mai mica de 8 si mai mare ca 4.
```SQL
SELECT distinct studenti.studenti.Nume_Student , studenti.studenti.Prenume_Student 
FROM studenti.studenti, plan_studii.discipline , studenti.studenti_reusita
Where studenti.studenti.Id_Student = studenti.studenti_reusita.Id_Student
and plan_studii.discipline.Id_Disciplina = studenti.studenti_reusita.Id_Disciplina
and studenti.studenti_reusita.Tip_Evaluare = 'examen' 
and year(studenti.studenti_reusita.Data_Evaluare) = 2018 
and plan_studii.discipline.Disciplina = 'Baze de date'
and studenti.studenti_reusita.Nota between  4 and 8
```
![image](https://user-images.githubusercontent.com/34598802/49852901-1caddc00-fdee-11e8-8878-308563a76730.png)

#### ex.13 Aflati cursurile urmate de catre studentul Florea loan.
```SQL
SELECT DISTINCT plan_studii.discipline.Disciplina 
FROM plan_studii.discipline, studenti.studenti_reusita, studenti.studenti
WHERE plan_studii.discipline.Id_Disciplina = studenti.studenti_reusita.Id_Disciplina
AND studenti.studenti_reusita.Id_Student = studenti.studenti.Id_Student
AND  studenti.studenti.Nume_Student = 'Florea' 
AND   studenti.studenti.Prenume_Student = 'Ioan'
```
![image](https://user-images.githubusercontent.com/34598802/49854457-deff8200-fdf2-11e8-889d-d83319e886f5.png)
## Task 8

### Creați sinonimele respective pentru a simplifica interogările construite în exercițiul precedent și reformulați interogările, folosind sinonimele create.







