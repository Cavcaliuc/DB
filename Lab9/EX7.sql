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