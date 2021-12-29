CREATE DATABASE Libraries

USE Libraries

CREATE TABLE Authors(
	Id int primary key identity,
	Name nvarchar(50) not null,
	Surname nvarchar(50) not null
)

CREATE TABLE Books(
	Id int primary key identity,
	Name nvarchar(100) check(len(Name)>2) not null,
	AuthorId int constraint FK_Books_AuthorId foreign key (AuthorId) references Authors(Id),
	PageCount int check(PageCount>=10) 
)

INSERT INTO Authors
VALUES(N'Vüsal', N'Bağırov'),
(N'Əhəd', N'Tağıyev'),
(N'Həsən', N'Nuruzadə'),
(N'Lalə', N'Quliyeva'),
(N'Nurlan', N'Məmmədli')

INSERT INTO Books
VALUES('book1', 1, 200),
('book2', 1, 300),
('book3', 2, 100),
('book4', 4, 500),
('book5', 3, 900)

CREATE VIEW VW_ShowLibraries
as
SELECT b.Id, b.Name, b.PageCount, (a.Name + ' ' + a.Surname) as AuthorFullName FROM Books b
join Authors a
ON b.AuthorId = a.Id

CREATE PROCEDURE USP_ShowLibraries
@Id int,
@Name nvarchar(100),
@Search nvarchar(100),
@PageCount int
as
SELECT * FROM VW_ShowLibraries v WHERE v.Id = @Id and v.Name = '%' + @Search + '%' and v.PageCount=@PageCount and v.AuthorFullName='%' + @Search + '%'

EXEC USP_ShowLibraries

CREATE PROCEDURE USP_InsertIntoAuthors
	@Name nvarchar(50),
	@Surname nvarchar(50)
as
INSERT INTO Authors(
	Name,
	Surname
)
VALUES(
	@Name,
	@Surname
)

EXEC USP_InsertIntoAuthors 'Vüsal', 'Bağırov'
SELECT * FROM Authors

CREATE PROCEDURE USP_UpdateAuthors
	@Id int,
	@Name nvarchar(50),
	@Surname nvarchar(50)
as
UPDATE Authors
SET Name = @Name, Surname = @Surname WHERE Id = @Id

EXEC USP_UpdateAuthors 7, 'Ahad', 'Tagiyev'
SELECT * FROM Authors

CREATE PROCEDURE USP_DeleteAuthors
	@Id int,
	@Name nvarchar(50),
	@Surname nvarchar(50)
as
DELETE FROM Authors WHERE Id = @Id

CREATE VIEW VW_ShowAuthors
as
SELECT * FROM Authors a
