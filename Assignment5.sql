create database Assessment05Db
use Assessment05Db
create schema bank
CREATE TABLE bank.Customer (
    CId INT PRIMARY KEY identity (1000,1) NOT NULL,
    CName NVARCHAR(100) NOT NULL,
    CEmail NVARCHAR(100) UNIQUE  NOT NULL,
	Contact varchar (10) not null unique check (Contact like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
	CPwd as	 CONCAT(SUBSTRING(CName, LEN(CName) - 1, 2), 
   SUBSTRING(CAST(CId AS VARCHAR),
   LEN(CAST(CId AS VARCHAR)) - 1, 2), 
   SUBSTRING(Contact, 1, 2))  Persisted   
)

select * from bank.Customer

create table bank.MailInfo
(MailTo nvarchar(100) not null,
MailDate datetime default getdate(),
MailMessage nvarchar(100) )

select * from bank.MailInfo

CREATE TRIGGER bank.trgMailToCust
ON bank.Customer
AFTER INSERT
AS
BEGIN
    INSERT INTO bank.Mailinfo (MailTo, MailDate, MailMessage)
    SELECT CEmail, GETDATE(), 'Your net banking password is: ' + CPwd + '. It is valid up to 2 days only. Update It'
    FROM inserted;
END;
INSERT INTO bank.Customer (CName, CEmail, Contact) VALUES
('John Doe', 'john@example.com', '1234567890'),
('Alice Smith', 'alice@example.com', '9876543210'),
('Bob Johnson', 'bob@example.com', '5555555555')
select * from bank.MailInfo
select * from bank.Customer