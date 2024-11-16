CREATE	DATABASE spotifyTask
USE spotifyTask

CREATE TABLE roles
(
id int identity primary key,
type varchar(64)
)

insert into roles
VALUES
('Moderator'),
('User'),
('Admin')



CREATE TABLE users
(
id int identity primary key,
name varchar(64) NOT NULL,
surname varchar(64) NOT NULL,
username varchar(100) UNIQUE,
password varchar(100) CHECK(LEN(password)>7),
gender varchar (32) NOT NULL,
roleId int references roles(id)
)
insert into users
VALUES
--('Refige','Mirzezade','rmirzzde','refiqemirz','q',2),
--('Sevil','Qasimova','sqsimov','qsmovsll','q',1),
--('Emin','Seyyafli','esayyli','syyfliemin','k',3),
--('Kerim','Aliyev','aliyevvv','alyevkrm','k',1),
--('Ali','Qocayev','aliqcayv','qocayevv','k',2),
--('Aysel','Quliyeva','quliavaa','qlyevaaisel','q',3)



CREATE TABLE categories
(
id int identity primary key,
name varchar(64) NOT NULL
)
insert into categories
VALUES
('rock'),
('jazz'),
('pop'),
('Classical')


CREATE TABLE Artists
(
id int identity primary key,
name varchar(64),
surname varchar(64),
birthday Date,
gender varchar (32) NOT NULL,
)
insert into artists(name,surname,birthday,gender)
VALUES
--('Emel', 'Sayýn', '1945-11-20', 'q'),
--('Tarkan', 'Tevetoglu', '1972-10-17', 'k'),
--('Ajda', 'Pekkan', '1946-02-12', 'q'),
--('Cem', 'Karaca', '1945-04-05', 'k'),
--('Barýþ', 'Manço', '1943-01-02', 'k'),
--('Sertab', 'Erener', '1964-12-04', 'q'),
--('Kenan', 'Doðulu', '1974-05-31', 'k'),
--('Zeki', 'Müren', '1931-12-06', 'k'),
--('Semicenk', NULL, '1998-10-07', 'k'),
--('Lvbel', 'C5', '1990-10-23', 'k'),
--('Miro', NULL, '1986-08-23', 'k'),
('Orkhan ', 'Zeynalli', '1986-03-20', 'k'),
('Kubilay ', 'Karca', '1980-05-20', 'k')
 

 CREATE TABLE musics
 (
id int identity primary key,
name varchar(100),
duration TIME,
categoryID int references categories(id),
artistID int references Artists(id)
 )
 
insert into musics (name,artistId,duration,categoryId)
VALUES
('Þýmarýk', 2, '00:03:57',3),
('Geri Dön', 2, '00:04:33',3), 
('Resimdeki Gözyaþlarý', 4, '00:05:13',1),
('Every Way That I Can', 6, '00:02:52',2),
('Mavi Boncuk', 8, '00:04:18',3),
('Þimdi Uzaklardasýn', 10, '00:03:35',4),
('Bilmem Mi?', 9, '00:02:55', 3),      
('Paranoya', 10, '00:03:40', 1),      
('Üzgünüm', 11, '00:04:05', 3),
('Iller sonra', 12, '00:04:00', 2), 
('Kara Gözlüm', 13, '00:03:50', 2),
('Batik gemi', 9, '00:03:55', 2),      
('Tek basima', 9, '00:03:43', 2)  

select m.name as musics, c.name as category, a.name as astists_name, a.surname as artists_surname
from musics as m
join artists as a
on m.artistId=a.id
join  categories as c
on  m.categoryId=c.id





 CREATE TABLE playlistMusics
 (
 id int identity primary key,
 userId int references  users(id),
 musicId int references  musics(id)
 )

 insert into playlistMusics(userId,musicId)
 VALUES
 (3,2),(3,5),(3,9),(6,2),(6,2),(7,3),
 (6,4),(7,7), (8,4),(8,11),(9,12),(6,7),
 (9,8),(9,8), (6,12),(10,11),(10,12),(9,12)

 

 select * from users 
 select * from musics 
 select * from playlistMusics

 select u.id, u.name,u.surname, u.username, m.name as musicName
 from playlistMusics as plm
 join musics as m
 on plm.musicId=m.id
 join users as u
 on plm.userId=u.id

 ---sorgu 1
 CREATE VIEW uptadeable
as
select m.name as musicName,m.duration, c.name as category ,a.name +' '+ a.surname as artist
from musics as m
join  categories as c
on m.categoryId= c.id
join artists as a
on m.artistId= a.id
select * from uptadeable

---sorgu 2
 select u.id, u.name,u.surname, u.username, m.name as musicName
 from playlistMusics as plm
 join musics as m
 on plm.musicId=m.id
 join users as u
 on plm.userId=u.id

 ---sorgu 3
 select  m.name 
 from musics as m
 order by m.duration


 ---sorgu 4
 select TOP 3 a.name as artist_name, count(m.name) as music_count
from musics as m
join artists as a
on m.artistId= a.id
group by a.name
order by  count(m.name) desc