create database s_tudent;
use s_tudent;

CREATE TABLE student(
snum INT,
sname VARCHAR(10),
major VARCHAR(2),
lvl VARCHAR(2),
age INT,
primary key(snum));

CREATE TABLE faculty(
fid INT,
fname VARCHAR(20),
deptid INT,
PRIMARY KEY(fid));

CREATE TABLE class(
cname VARCHAR(20),
metts_at TIMESTAMP,
room VARCHAR(10),
fid INT,
PRIMARY KEY(cname),
FOREIGN KEY(fid) REFERENCES faculty(fid));

CREATE TABLE enrolled(
snum INT,
cname VARCHAR(20),
PRIMARY KEY(snum,cname),
FOREIGN KEY(snum) REFERENCES student(snum),
FOREIGN KEY(cname) REFERENCES class(cname));

INSERT INTO STUDENT 
VALUES(1,'jhon','CS','Sr',19),(2,'Smith','CS','Jr',20),(3,'Jacob','CV','Sr',20),(4,'Tom','CS','Jr',20),(5,'Rahul','CS','Jr',20),(6,'Rita','CS','Sr',21);

INSERT INTO FACULTY 
VALUES (11,'Harish',1000),(12,'MV',1000),(13,'Mira',1001),(14,'Shiva',1002),(15,'Nupur',1000);

insert into class 
values ('class1', '12/11/15 10:15:16', 'R1', 14),('class10', '12/11/15 10:15:16', 'R128', 14),('class2', '12/11/15 10:15:20', 'R2', 12),('class3', '12/11/15 10:15:25', 'R3', 11),('class4', '12/11/15 20:15:20', 'R4', 14),('class5', '12/11/15 20:15:20', 'R3', 15),('class6', '12/11/15 13:20:20', 'R2', 14),('class7', '12/11/15 10:10:10', 'R3', 14);

insert into enrolled 
values (1, 'class1'),(2, 'class1'),(3, 'class3'),(4, 'class3'),(5, 'class4'),(1, 'class5'),(2, 'class5'),(3, 'class5'),(4, 'class5'),(5, 'class5');

select distinct s.sname
from student s, class c, enrolled e, faculty f
where s.snum = e.snum and e.cname = c.cname and c.fid = f.fid and
f.fname ='Harish' and s.lvl ='Jr';

select C.cname
from Class C
where C.room = 'R128'
or C.cname in (select E.cname
		FROM Enrolled E
		GROUP BY E.cname
		HAVING COUNT(E.snum) >= 5);

select distinct S.sname
from Student S
where S.snum in (select E1.snum
			from Enrolled E1, Enrolled E2, Class C1, Class C2
			where E1.snum = E2.snum AND E1.cname <> E2.cname
			AND E1.cname = C1.cname
			AND E2.cname = C2.cname AND C1.metts_at = C2.metts_at);

select distinct F.fname
from Faculty F,Class C
where F.fid=C.fid 
group by C.fid
having count(distinct room) = 5;

select distinct F.fname
from Faculty F
where 5 > (select COUNT(E.snum)
from Class C, Enrolled E
where C.cname = E.cname
and C.fid = F.fid);

select distinct S.sname
from Student S
where S.snum NOT IN (select E.snum
from Enrolled E );

select S.age, S.lvl
from Student S
group by S.age, S.lvl
having S.lvl IN (select S1.lvl from Student S1
      where S1.age = S.age
group by S1.lvl, S1.age
having COUNT(S1.snum) >= ALL (select COUNT(S2.snum)
from Student S2
where s1.age = S2.age
group by S2.lvl, S2.age));


/*i.	Find the names of all Juniors (level = JR) who are enrolled in a class taught by Harish.*/
select distinct s.sname
from student s, class c, enrolled e, faculty f
where s.snum = e.snum and e.cname = c.cname and c.fid = f.fid and
f.fname ='Harish' and s.lvl ='Jr';
/*ii.	Find the names of all classes that either meet in room R128 or have five or more Students enrolled.*/
select C.cname
from Class C
where C.room = 'R128'
or C.cname in (select E.cname
		FROM Enrolled E
		GROUP BY E.cname
		HAVING COUNT(E.snum) >= 5);
/*iii.	Find the names of all students who are enrolled in two classes that meet at the same time.*/
select distinct S.sname
from Student S
where S.snum in (select E1.snum
			from Enrolled E1, Enrolled E2, Class C1, Class C2
			where E1.snum = E2.snum AND E1.cname <> E2.cname
			AND E1.cname = C1.cname
			AND E2.cname = C2.cname AND C1.metts_at = C2.metts_at);
/*iv.	Find the names of faculty members who teach in every room in which some class is taught.*/
select distinct F.fname
from Faculty F,Class C
where F.fid=C.fid 
group by C.fid
having count(distinct room) = 5;
/*v.	Find the names of faculty members for whom the combined enrollment of the courses that they teach is less than five.*/
select distinct F.fname
from Faculty F
where 5 > (select COUNT(E.snum)
from Class C, Enrolled E
where C.cname = E.cname
and C.fid = F.fid);
/*vi.	Find the names of students who are not enrolled in any class. */
select distinct S.sname
from Student S
where S.snum NOT IN (select E.snum
from Enrolled E );
/*vii.	For each age value that appears in Students, find the level value that appears most often. For example, if there are more FR level students aged 18 than 
SR, JR, or SO students aged 18, you should print the pair (18, FR).*/
select S.age, S.lvl
from Student S
group by S.age, S.lvl
having S.lvl IN (select S1.lvl from Student S1
      where S1.age = S.age
group by S1.lvl, S1.age
having COUNT(S1.snum) >= ALL (select COUNT(S2.snum)
from Student S2
where s1.age = S2.age
group by S2.lvl, S2.age));






