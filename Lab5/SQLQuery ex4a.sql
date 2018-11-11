
--ex4
--Modificati exercitiile din sarcinile 1 si 2 pentru a include procesarea erorilor cu TRY, CATCH, si RAISERRROR.
--for ex1

declare @N1 int , @N2 int, @N3 int;
declare @MAI_MARE int;
set @N1 = 60 * rand();
set @N2 = 60 * rand();
set @N3 = 60 * rand() ;
set @MAI_MARE = @N1;

begin try
if @N1 = @N2 or @N1 = @N3 or @N2 = @N3 
    raiserror ('Some numbers have the same value', 1,1)
else
begin
if @MAI_MARE < @N2
   set @MAI_MARE = @N2;
if @MAI_MARE < @N3
   set @MAI_MARE = @N3;
print @N1;
print @N2;
print @N3;
print 'Mai mare = ' + cast(@MAI_MARE as varchar(2));
end
end try

begin catch
print ' An error occured!' 
print 'The details of the error'
print ' The number of error:' + cast(ERROR_NUMBER() as varchar(20))
print ' Level of Severity:' + cast(ERROR_SEVERITY() as varchar(20))
print ' The error status:' + cast(ERROR_STATE() as varchar(20))
print ' The error line:' + cast(ERROR_LINE() as varchar(20))
end catch