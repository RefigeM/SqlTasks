
CREATE DATABASE HOMEWORK1
USE HOMEWORK1
CREATE TABLE vezifeler
(
id int identity primary key,
name varchar(64)
)
CREATE TABLE isciler
(
id int identity primary key,
saa nvarchar(124) NOT NULL,
vezifeid int references vezifeler(id),
maaş decimal(18,2)  NOT NULL
)
CREATE TABLE filiallar
(
id int identity primary key,
name nvarchar(64)

CREATE TABLE mehsullar
(
id int identity primary key,
name varchar(64),
alisQiy decimal(18,2),
satisQiy decimal(18,2)
)
----------------------------------
insert into vezifeler
VALUES
('satici'),
('kassir');

insert into isciler
values
(N'Əliyeva Nərgiz Rasim',1,400),
(N'Məmmədov Elvin Tofiq',2,350),
(N'Hüseynova Aysel Sabir',1,400),
(N'Rzayeva Nərmin Kamran',2,350),
(N'Rzayev İlqar Tofiq',2,350)
(N'Məhərrəmova Ləman Tofiq',2,350),
(N'Sultanova Nuray Rauf',2,350)


insert into mehsullar
values
('cay',1.2,3),
('sud',0.7,1.65),
('corek',0.4,0.55),
('un',1.2,1.8),
('yag',2.2,3),
('duz',1,1.8),
('makoron',2.2,2.8)

insert into filiallar
values 
(N'Koroglu'),
(N'Sabunçu'),
(N'28may')

CREATE TABLE satis
(
id int identity primary key,
mehsulId int references mehsullar(id),
İşçiId int references isciler(id),
filialId int references filiallar(id),
satisTarixi  DATETIME
)
insert into satis
values 
--(1,2,1,'2024-11-12 10:15:00'),
--(2,2,3,'2024-3-12 10:15:00'),
--(5,2,3,'2024-11-12 10:15:00'),
--(6,4,3,'2024-1-12 10:15:00'),
--(7,7,1,'2024-11-12 10:15:00'),
--(7,3,1,'2024-15-12 10:15:00'),
--(6,2,2,'2024-11-12 10:15:00'),
--(6,4,2,'2024-1-12 10:15:00'),
--(6,7,1,'2024-11-12 10:15:00'),
--(2,3,3,'2024-3-11 10:17:00'),
--(1,5,3,'2024-03-11 10:15:00'),
----(7,4,1,'2024-11-12 10:15:00'),
--(6,5,2,'2024-11-12 10:15:00'),
--(6,4,2,'2024-01-15 10:15:00'),
--(5,7,3,'2024-11-12 10:15:00'),
--(2,4,3,'2024-9-11 10:17:00'),
--(5,5,3,'2024-10-10 10:15:00'),
--(5,5,3,'2024-11-11 10:15:00')




--sorgu 1

select i.saa as isciler, m.name as mehsullar,f.name as filiallar, m.alisQiy as alisQiymeti,m.satisQiy as satisQiymeti
from satis as s
join mehsullar as m
on s.mehsulId=m.id
join isciler as i
on s.İşçiId= i.id
join filiallar as f 
on s.filialId=f.id


--sorgu 2

select  sum(satisQiy) as umumiqiymet
from satis as s
join mehsullar as m
on s.mehsulId=m.id
join isciler as i
on s.İşçiId= i.id
join filiallar as f 
on s.filialId=f.id


--sorgu 3
select  sum(satisQiy) as umumiqiymet
from satis as s
join mehsullar as m
on s.mehsulId=m.id
join isciler as i
on s.İşçiId= i.id
join filiallar as f 
on s.filialId=f.id
WHERE YEAR(s.satisTarixi) = YEAR(GETDATE()) 
    AND MONTH(s.satisTarixi) = MONTH(GETDATE());


--sorgu 4
select i.saa, count(m.id) as satilanMehsulSayi
from satis as s
join mehsullar as m
on s.mehsulId=m.id
join isciler as i
on s.İşçiId= i.id
join filiallar as f 
on s.filialId=f.id
group by i.saa


--sorgu 5
select TOP 1  f.name as filial, count(m.id) as mehsulSayi
from satis as s
join mehsullar as m
on s.mehsulId=m.id
join isciler as i
on s.İşçiId= i.id
join filiallar as f 
on s.filialId=f.id 
WHERE YEAR(s.satisTarixi) = YEAR(GETDATE()) 
  AND MONTH(s.satisTarixi) = MONTH(GETDATE())  
  AND DAY(s.satisTarixi) = DAY(GETDATE()) 
group by f.name
ORDER BY count(m.id) desc

--sorgu 6
select TOP 1 m.name as mehsulName, count(m.id)
from satis as s
join mehsullar as m
on s.mehsulId=m.id
join isciler as i
on s.İşçiId= i.id
join filiallar as f 
on s.filialId=f.id
WHERE YEAR(s.satisTarixi) = YEAR(GETDATE()) 
  AND MONTH(s.satisTarixi) = MONTH(GETDATE()) 
group by m.name 
order by count(m.id) desc