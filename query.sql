-- database=college;
create database college1;

use college1;
create table Books(
 Author varchar(20),
 Book_id int primary key,
 Title varchar(10),
 Price int,
 Available varchar(30) NOT NULL
);
insert into Books values 
("RabinderNathTagore",099,"NewMan",200,"yes"),
("Aman",101,"NewWomen",300,"yes"),
("Pradeep",102,"Engineer",400,"no"),
("Karan",103,"Default",500,"yes"),
("Arun",104,"Nothing",600,"yes"),
("Mukesh",105,"Freeman",700,"no");
select * from Books;
DROP Table Books;
-- View_ in Mysql; 
CREATE VIEW new_books AS
SELECT Title, Price
FROM Books
WHERE Available ="yes";
select*from new_books;

CREATE VIEW new_book AS
SELECT Title, Price
FROM Books
WHERE Book_id>=102;
select*from new_books;
create table Publisher (
 Pub_id int,
 Pub_Name varchar(10),
 Address varchar(30)
);
insert into Publisher values(101,"Kamal","Jammu"),
(102,"Raju","kashmir"),
(103,"Reena","Pathankot"),
(104,"kajol","Jalandhar"),
(105,"Shunnu","Amritsar"),
(106,"Adda","Ludhiana");
select * from Publisher;
Drop TABLE Publisher;
create table Members(
 Mem_name varchar(30), 

 Mem_id int primary key,
 Mem_date DATE,
 Mem_type varchar(10),
 Address varchar(20),
 expiry_date DATE
);
insert into Members 
values("Ram",001,'2022-01-16',"male","jammu",'2022-02-16'),
("Sham",002,"2022-01-17","male","kashmir","2022-02-17"),
("Harman",003,"2022-01-18","male","jalandhar","2022-02-18"),
("Raman",004,"2022-01-19","female","amritsar","2022-02-19"),
("Varun",005,"2022-01-20","male","ludhiana","2022-02-20"),
("Vivek",006,"2022-01-21","female","kolkata","2022-02-21");
drop table Members;
select * from Members;
create table BorrowBy(
 Mem_id int,
 Issue varchar(20),
 Due_date DATE,
 Return_date DATE
);
insert into BorrowBy values(004,"yes","2022-01-17","2022-02-17"),

(005,"yes","2022-01-18","2022-02-18"),
(006,"no","2022-01-19","2022-02-19"),
(007,"yes","2022-01-20","2022-02-20"),
(008,"yes","2022-01-21","2022-02-21"),
(009,"no","2022-01-22","2022-02-22"),
(010,"yes","2022-01-23","2022-02-23");
alter table BorrowBy add foreign key(Mem_id) references 
Members(Mem_id);
select*from BorrowBy;
drop table BorrowBy;
select Mem_id,Issue from BorrowBy where Mem_id>006;
create table PublishedBy(
 Author varchar(10),
 Pub_id int ,
 constraint foreign key (Author) references Books(Author) on delete set 
null
);
select Due_date,Mem_name
from BorrowBy,Members
where BorrowBy.Mem_id = Members.Mem_id and
BorrowBy.Issue = "yes";

select distinct Due_Date
from Members as M, BorrowBY as B
where M.Mem_id > B.Mem_id and B.Issue = 'yes';
-- MYSQL aggregrate functions;
-- COUNT, SUM, AVG, MAX,MIN;
SELECT COUNT(*) FROM Members;
select count(distinct Mem_type),Mem_type from Members;
select count(Address) from Members where Mem_id <=004;
select sum(Price) from Books; 
select sum(Price) from Books where Book_id<104;
select sum(Price) from Books where Book_id<104 group by Author;
select avg(Price) from Books;
select max(Price) from Books;
select min(Price) from Books;
-- Set_function in MYSQL;;;
UPDATE BorrowBy SET Issue = 'no' WHERE Mem_id= 008; 
update Members set Mem_type="male" where Mem_id=006; -- group by Address;
update Members set Mem_id="010" 
where Mem_name in 
(select Mem_name from Members where Mem_name="Vivek");
--  string_ statements
select Mem_name
from Members
where Mem_name like '%ma%';
select Mem_name
from Members
where Mem_name like 'V%';
select Mem_name
from Members
where Mem_name like '___';

select Mem_name
from Members
where Mem_name like '____%';
-- sql_join statemens
(select Address from Members where Mem_type = "male" and Mem_id=
002)
Union 
(select Address from Members where Mem_type = "female" and 
Mem_id=004);
SELECT DISTINCT Mem_type FROM Members WHERE Mem_type="male" 
and
Mem_id=002 and Mem_type IN (SELECT Mem_type="male" FROM
Members where Mem_type="female" and Mem_id=004);
select Address from Members where Mem_type = "male" and Mem_id=
002  NOT IN (select Address from Members where Mem_type = "female" and 
Mem_id=004);
select Members.Mem_id,BorrowBy.Issue from Members inner join 

BorrowBy on Members.Mem_id=BorrowBy.Mem_id; 
select Members.Mem_id,BorrowBy.Issue from Members left join 
BorrowBy on Members.Mem_id=BorrowBy.Mem_id; 
select Members.Mem_id,BorrowBy.Issue from Members right join 
BorrowBy on Members.Mem_id=BorrowBy.Mem_id; 
select Members.Mem_id,BorrowBy.Issue from Members full join 
BorrowBy on Members.Mem_id=BorrowBy.Mem_id; 
-- sub-queries statements
select distinct Mem_type
from Members
where Mem_type="male" and Mem_id=002 and
Mem_type in (select Mem_type
from Members
where Mem_type="female" and Mem_id=004);
select distinct Mem_type
from Members
where Mem_type="male" and Mem_id=002 and

Mem_type not in (select Mem_type="female"
from Members
where Mem_type="female" and Mem_id=004);
select * from Members
where Mem_name in 
(select Mem_name from Members where Mem_id>003);
select Mem_name, address from Members 
where Mem_id in 
(select Mem_id from BorrowBy where Issue="yes");
