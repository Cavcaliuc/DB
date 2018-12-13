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

--- pentru executie 
exec Lab9_ex3  'Gomeniuc', 'Alina', '1999-04-24',' mun.Chisinau', 'TI171'

select * from studenti