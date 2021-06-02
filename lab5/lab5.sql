create database student_enrol;
use student_enrol;
create table student(regno varchar(20),name VARCHAR(50),major varchar(20),bdate date,primary key (regno));
create table course(courseno int,cname varchar(20),dept VARCHAR(20),primary key(courseno));
create table enroll(regno varchar(20),courseno int,sem int,marks int,primary key(regno,courseno),foreign key(regno) references student(regno),
foreign key(courseno) references course(courseno));
create table text(book_isbn int,book_title varchar(50),publisher varchar(50),author varchar(50),primary key(book_isbn));
create table book_adoption(courseno int,sem int,book_isbn int,primary key(courseno,book_isbn),foreign key(courseno) references course(courseno),
foreign key(book_isbn) references text(book_isbn));
insert into student values('CS01','RAM','DS','1986-03-12');
insert into student values('IS02','SMITH','USP','1987-12-23');
insert into student values('EC03','AHMED','SNS','1985-04-17');
insert into student values('CS03','SNEHA','DBMS','1987-01-01');
insert into student values('TC05','AKHILA','EC','1986-10-06');
commit;
select*from student;
insert into course values('11','DS','CS');
insert into course values('22','USP','IS');
insert into course values('33','SNS','EC');
insert into course values('44','DBMS','CS');
insert into course values('55','EC','TC');
commit;
select*from course;
insert into enroll values('CS01','11','4','85');
insert into enroll values('IS02','22','6','80');
insert into enroll values('EC03','33','2','80');
insert into enroll values('CS03','44','6','75');
insert into enroll values('TC05','55','2','56');
commit;
select*from enroll;
insert into text values('1','DS AND C REDDY','PRINCETON','PADMA');
insert into text values('2','FUNDAMENTALS OF DS','PRINCETON','GODSE');
insert into text values('3','FUNDAMENTALS OF DBMS','PRINCETON','NAVATHE');
insert into text values('4','SQL','PRINCETON','FOLEY');
insert into text values('5','ELECTRONICS CIRCUITS','TMH','ELMASRI');
insert into text values('6','ADV UNIX PROG','TMH','STEVENS');
commit;
select*from text;
insert into book_adoption values('11','4','1');
insert into book_adoption values('11','4','2');
insert into book_adoption values('44','6','3');
insert into book_adoption values('44','6','4');
insert into book_adoption values('55','2','5');
insert into book_adoption values('22','6','6');
commit;
select*from book_adoption;

insert into text values('7','C PROGRAMMING','TMH','THAREJA');
insert into book_adoption values('55','2','7');
insert into book_adoption values(11,4,3);

select c.courseno,t.book_isbn,t.book_title from course c,book_adoption ba,text t where c.courseno=ba.courseno and ba.book_isbn=t.book_isbn and c.dept='CS'
and 2<(select count(book_isbn) from book_adoption b where c.courseno=b.courseno) order by t.book_title;

select distinct c.dept from course c where c.dept in(select c.dept from course c,book_adoption b,text t where c.courseno=b.courseno 
and t.book_isbn=b.book_isbn and t.publisher='PRINCETON')
and c.dept not in(Select c.dept from course c,book_adoption b,text t where c.courseno=b.courseno and t.book_isbn=b.book_isbn and t.publisher !='PRINCETON');