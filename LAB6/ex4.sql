UPDATE studenti_reusita
 SET Nota=Nota+1
 WHERE Nota<>10 and Nota in
 (SELECT Nota FROM studenti_reusita WHERE Id_Student IN(SELECT Sef_Grupa FROM grupe)) ;

SELECT * FROM studenti_reusita