
--EX1
--Completati urmatorul cod pentru a afisa cel mai mare numar dintre cele trei numere prezentate:

declare @N1 int , @N2 int, @N3 int;
declare @MAI_MARE int;
set @N1 = 60 * rand();
set @N2 = 60 * rand();
set @N3 = 60 * rand();
set @MAI_MARE = @N1;
if @MAI_MARE < @N2
   set @MAI_MARE = @N2;
if @MAI_MARE < @N3
   set @MAI_MARE = @N3;

print @N1;
print @N2;
print @N3;
print 'Mai mare = ' + cast(@MAI_MARE as varchar(2));

