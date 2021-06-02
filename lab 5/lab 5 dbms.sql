create database student_enrolment;
use student_enrolment;
create table student(Regno varchar(50),Nmae varchar(50),Major varchar(50),Bdate date,primary key(Regno));
create table course(courseno int,cname varchar(50),dept varchar(50),primary key (courseno));
create table enroll(regno varchar(50),courseno int,sem int,marks int,primary key (regno,courseno),
foreign key (regno) references student (regno),
foreign key (courseno) references course (courseno));
create table text(book_isbn int,book_title varchar(50),publisher varchar(50),author varchar(50),primary key (book_isbn));
create table book_adoption(courseno int,sem int,book_isbn int,primary key (courseno),
foreign key (courseno) references course (courseno),
foreign key (book_isbn) references text(book_isbn));
show tables;
select*from student;
insert into student values('CS01','RAM','DS','1986-03-12');
insert into student values('IS02','SMITH','USP','1987-12-23');
insert into student values('EC03','AHMED','SNS','1985-04-17');
insert into student values('CS03','SNEHA','DBMS','1987-01-01');
insert into student values('TC05','AKHILA','EC','1986-10-06');
commit;
select*from course;
insert into course values('11','DS','CS');
insert into course values('22','USP','IS');
insert into course values('33','SNS','EC');
insert into course values('44','DBMS','CS');
insert into course values('55','EC','TC');
commit;
select*from enroll;
insert into enroll values('CS01','11','4','85');
insert into enroll values('IS02','22','6','80');
insert into enroll values('EC03','33','2','80');
insert into enroll values('CS03','44','6','75');
insert into enroll values('TC05','55','2','56');
commit;
select*from text;
insert into text values('1','DS AND C REDDY','PRINCETON','PADMA');
insert into text values('2','FUNDAMENTALS OF DS','PRINCETON','GODSE');
insert into text values('3','FUNDAMENTALS OF DBMS','PRINCETON','NAVATHE');
insert into text values('4','SQL','PRINCETON','FOLEY');
insert into text values('5','ELECTRONICS CIRCUITS','TMH','ELMASRI');
insert into text values('6','ADV UNIX PROG','TMH','STEVENS');
commit;

select*from book_adoption;
insert into book_adoption values('11','4','1');
insert into book_adoption values('11','4','2');
insert into book_adoption values('44','6','3');
insert into book_adoption values('44','6','4');
insert into book_adoption values('55','2','5');
insert into book_adoption values('22','6','6');
insert into book_adoption values('55','2','7');


