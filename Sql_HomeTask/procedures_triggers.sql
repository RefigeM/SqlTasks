CREATE DATABASE db3
use db3
CREATE TABLE categories
(
id INT IDENTITY PRIMARY KEY,
catgName varchar(32)
)
CREATE TABLE users
(
id int identity primary key,
name varchar(32) NOT NULL,
surname varchar(32) NOT NULL,
username varchar(32) NOT NULL UNIQUE,
password varchar(32) NOT NULL,
gender bit
)
CREATE TABLE music
(
id int identity primary key,
duration time,
catgId int references categories(id),
deletedTime Datetime,
isDeleted bit default 0 NOT NULL
)
ALTER TABLE music
ADD name varchar(32)
DROP COLUMN deletedTime


CREATE PROCEDURE CreateCategory(@CATGNAME varchar(32))
AS
BEGIN 
  insert into categories VALUES 
  (@CATGNAME)
END

CreateCategory 'classical'
select  * from  categories

CREATE PROCEDURE CreateUser(@NAME varchar(32), @SURNAME varchar(32), @USERNAME varchar(32), @PASSWORD varchar(32), @GENDER varchar(32))
AS
BEGIN
  insert into users VALUES
  (@NAME,@SURNAME,@USERNAME,@PASSWORD,@GENDER)
END

CreateUser 'Aysel','Quliyeva','quliavaa','qlyevaaisel','0'
select  * from  USERS

CREATE PROCEDURE MusicCreate(@NAME varchar(32),@DURATION time,@CATGID int,@DELETEDTIME Datetime,@ISDELATED bit = 0)
AS
BEGIN
  insert into music (Name, Duration, CatgID,deletedTime,isDeleted)
  VALUES
  (@NAME,@DURATION,@CATGID,@DELETEDTIME,@ISDELATED)
END

MusicCreate 'Steel Wings', '00:04:05', 2, NULL, 0;


MusicCreate 'After hours', '00:04:18',4,0
select * from music

select * from music
delete  from music
where id in (9,10)

CREATE TRIGGER insteadDelete
ON music
INSTEAD OF Delete
AS
BEGIN
 DECLARE @id INT;
 SELECT @id= id from deleted;
UPDATE music
set deletedTime= GETDATE()
where id =@id
END

delete music
where id=5
DROP TRIGGER UpdateInsteadDelete

CREATE TRIGGER UpdateInsteadDelete
ON music
INSTEAD OF Delete
AS
BEGIN
 DECLARE @id INT;
 SELECT @id= id from deleted;
UPDATE music
set isDeleted = 1,
deletedTime= GETDATE()
where id =@id
END

delete from music
where id=18

delete from music 
--select * from music
where isDeleted = 1

select id, name, duration ,isDeleted, deletedTime from music
