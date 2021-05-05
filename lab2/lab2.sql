create database book_dealer;
use book_dealer;
create table author(author_id int,name varchar(15),city varchar(15),country varchar(15),primary key(author_id));
create table publisher(publisher_id int,name varchar(15),city varchar(15),country varchar(15),primary key(publisher_id));
create table category(category_id int,description varchar(15),primary key(category_id));
create table catalog(book_id int,title varchar(15),author_id int,publisher_id int,category_id int,year int,price int,primary key(book_id),
foreign key(author_id)references author(author_id) on delete cascade,
foreign key(publisher_id)references publisher(publisher_id) on delete cascade,
foreign key(category_id)references category(category_id) on delete cascade);
create table order_details(order_no int,book_id int,quantity int,primary key(order_no),
foreign key(book_id)references catalog(book_id) on delete cascade);
insert into author values('1001','TERAS CHAIN','CA','USA');
insert into author values('1002','STEVENS','ZOMBI','UGANDA');
insert into author values('1003','M MANO','CAIR','CANADA');
insert into author values('1004','KARTHIK B.P.','NEW YORK','USA');
insert into author values('1005','WILLIAM','LAS VEGAS','USA');
commit;
select*from author;
insert into publisher values('101','PEARSON','NEW YORK','USA');
insert into publisher values('102','EEE','NEW SOUTHVALES','USA');
insert into publisher values('103','PHI','DELHI','INDIA');
insert into publisher values('104','WILLEY','BERLIN','GERMANY');
insert into publisher values('105','MGH','NEW YORK','USA');
commit;
select*from publisher;
insert into category values('1011','CSE');
insert into category values('1022','ADA');
insert into category values('1033','ELECTRONICS');
insert into category values('1044','PROGRAMMING');
insert into category values('1055','OS');
commit;
select*from category;
insert into catalog values('11','UNIX SYSTEM','1001','101','1011','1998','235');
insert into catalog values('12','DIG ANALYSIS','1001','102','1033','1997','255');
insert into catalog values('13','LOGIC DESIGN','1002','103','1022','2001','352');
insert into catalog values('14','SERVER','1002','103','1011','2002','523');
insert into catalog values('15','LINUX OS','1003','104','1044','2003','124');
commit;
select*from catalog;
insert into order_details values('1','11','12');
insert into order_details values('1','12','2');
insert into order_details values('2','12','15');
insert into order_details values('3','13','22');
insert into order_details values('4','13','14');
insert into order_details values('5','15','7');
commit;
select*from order_details;

select a.author_id,a.name,a.city,a.country,c.price,year from author a join catalog c on  a.author_id=c.author_id where c.year>=2000 group by a.author_id having count(c.author_id)>=2 ;

select name from author a where a.author_id=(
 select c.author_id from catalog c where book_id=(select book_id from order_details od where quantity=(select max(quantity) from order_details having max(quantity)))) ;
 
update catalog set price=1.1*price where publisher_id=(select publisher_id from publisher where name='PEARSON');
select*from catalog;