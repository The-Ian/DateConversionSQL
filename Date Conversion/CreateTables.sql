

Create Table MemberInsert
(
FirstName Varchar(50),
LastName Varchar(100),
Birthdate Varchar(50),
City varchar(50),
[State] Varchar(50),
JoinDate Varchar(50)
)

Go

Create Table MemberConversion
(
FirstName Varchar(50),
LastName Varchar(100),
Birthdate Date,
City varchar(50),
[State] Varchar(50),
JoinDate Date
)

BULK INSERT MemberInsert
FROM 'C:\Users\MTCStudent\Desktop\Date Conversion\MemberSort.csv'
WITH
(
FIRSTROW = 1, -- second row if header row in file
FIELDTERMINATOR = ',',  --CSV field delimiter
ROWTERMINATOR = '\n',   --Use to shift the control to next row
ERRORFILE = 'C:\Users\MTCStudent\Desktop\memberserr.csv',
TABLOCK
)