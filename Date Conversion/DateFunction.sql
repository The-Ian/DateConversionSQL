use AdventureWorks2012
Go
Alter FUNCTION [dbo].[fnDateConvert]
(
@inputDate VARCHAR(255)
) 
RETURNS date
BEGIN
 
 DECLARE @output date;
 DECLARE @result date;
 DECLARE @r_input varchar(255);
 DECLARE @y_length int;
 DECLARE @y_value int;
 
 IF LEN(@inputDate) > 0 

 -- Trim leading spaces
 SET @inputDate = LTRIM(RTRIM(@inputDate));

 -- Trim starting 0 if there is one.
 IF LEFT(@inputDate, 1) = '0'  
 SET @inputDate = RIGHT(@inputDate, LEN(@inputDate) - 1); 

 
 

 -- Replace dashes and periods

 SET @inputDate = REPLACE(@inputDate, '-', '/');
 SET @inputDate = REPLACE(@inputDate, '.', '/');

 -- Isolate and process year value
 -- First, get year string by reversing string and finding first (last) separator.
 SET @r_input = REVERSE(@inputDate);
 SET @y_length = CharIndex('/', @r_input) - 1;

 -- Get the year value from the last two digits ...
 SET @y_value = CONVERT(int, REVERSE(LEFT(@r_input, 2)));

 -- If the year value is greater than or equal to the current year, assume last century, else this century.
 IF @y_length > 0 AND @y_length < 4 
   IF @y_value < 10 
     SET @inputDate = CONCAT(LEFT(@inputDate, LEN(@inputDate) - (@y_length)), '200', @y_value);
   ELSE IF @y_value >= FORMAT(Getdate(), 'd', 'en_US') 
     SET @inputDate = CONCAT(LEFT(@inputDate, LEN(@inputDate) - (@y_length)), '19', @y_value); 
   ELSE
     SET @inputDate = CONCAT(LEFT(@inputDate, LEN(@inputDate) - (@y_length)), '20', @y_value);
   
 
 -- Remove extra zeroes
 
 SET @inputDate = REPLACE(@inputDate, '/0', '/');
 
 Declare @first Varchar(5) = Substring(@inputDate, 1, CharIndex('/', @inputDate, 0) - 1)
 Declare @second Varchar(5) = Substring(@inputDate, CharIndex('/', @inputDate, 0) + 1,
 (CharIndex('/', @inputDate, CharIndex('/', @inputDate, CharIndex('/', @inputDate, 0) + 1 )) - CharIndex ('/', @inputDate, 0)-1 ))

 If IsNumeric(@second) = 1 And IsNumeric(@first) = 1
 If @first > 12 and @second <= 12
 
 Set @inputDate = Stuff(@inputDate, 1, 2, @second)
 Set @inputDate = Stuff(@inputDate, CharIndex('/', @inputDate, 0) + 1, LEN(@second), @first)
 
 
	



 SET @result = Convert(Date, @inputDate, 101);
 
 IF @result IS NOT NULL
   SET @output = @result;
 ELSE
   SET @output = '00/00/0000';
 
 
 RETURN @output;

END

GO

