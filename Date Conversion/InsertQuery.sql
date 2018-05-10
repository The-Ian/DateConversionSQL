insert into MemberConversion  (FirstName, LastName, BirthDate, City, [State], Joindate)
Select FirstName, LastName, dbo.fnDateConvert(Birthdate), City, [State], dbo.fnDateConvert(JoinDate)
From MemberInsert

Select * From MemberConversion