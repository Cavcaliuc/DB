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