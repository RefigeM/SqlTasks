CREATE DATABASE Academy
use Academy
 CREATE TABLE Students
 (
 id int identity primary key,
 firstName varchar(32),
 surname varchar(32),
 dataOfBirthday date,
 username varchar(32),
 password varchar(32),
 enrollmentDate date
 )

 CREATE TABLE Departments
 (
id int identity primary key,
departmentName varchar(32)
 )
 insert into Departments values
 ('department3')


 CREATE TABLE Instructors
 (
  id int identity primary key,
 firstName varchar(32),
 lastName varchar(32),
 hireDate DATE,
 departmentId int references Departments(id),
 username varchar(32),
 password varchar(32),
 pin varchar(32) CHECK(pin=7)
 )
 SELECT * FROM Instructors
 ALTER TABLE Instructors
 --DROP CONSTRAINT CK__Instructors__pin__3B75D760
 --DROP COLUMN pin
 ADD pin varchar(32) CHECK(LEN(pin)=7)
 insert into Instructors values
 ('Vilayet','Aliyev','2023-10-03','3','vilayetaliyev','123vilayet','UFY64GH')

 CREATE TABLE Groups
 (
 id int identity primary key,
 groupName varchar(32),
 departmentId int references Departments(id),
 startDate date,
 endDate date
 )
 insert into Groups VALUES
 ('AB201',3,'2024-09-10','2024-11-06')


 CREATE TABLE Enrollments
 (
  id int identity primary key,
  studentId int references Students(id),
  groupId int references Groups(id)
 )
 INSERT INTO Enrollments VALUES
 (2,1),(3,3),(1,2)
  CREATE TABLE Classes
  (
    id int identity primary key,
   groupId int references Groups(id),
   instructorId int references Instructors(id),
   schedule varchar(32),
   roomName varchar(32)
  )
  INSERT INTO Classes VALUES
  (1,4,'schedule1','YUPITER'),
  (2,5,'schedule','SATURN'),
  (3,4,'schedule3','MARS')

  create procedure insertStudents(@name varchar(32),@surname varchar(32),@dataOfBirthday date,@username varchar(32),@password varchar(32 ),
  @enrollmentDate date)
  AS 
  BEGIN
  INSERT INTO Students VALUES
  (@name,@surname,@dataOfBirthday,@username,@password,@enrollmentDate)
  END


  insertStudents 'Nihat','Aliyev','2004-01-11','nihadali','123nihad','2024-09-02'
  select * from Students

  CREATE VIEW VIEW1
  AS
  Select s.id,s.firstName, s.surname,g.groupName,c.schedule, c.roomName
  from Students as s
LEFT  join Enrollments as e
  on e.studentId=s.id
LEFT  join Groups as g
  on e.groupId=g.id
LEFT  join Departments as d
  on g.departmentId= d.id
 LEFT join Instructors as i
  on i.departmentId= d.id
 LEFT join Classes as c
  on c.groupId= g.id


  DELETE FROM  Students
  where id>3
  SELECT * FROM VIEW1