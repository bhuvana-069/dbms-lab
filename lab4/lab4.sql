create database banking;
use banking;
create table branch(branch_name varchar(30) primary key,branch_city varchar(30),assets real);
create table accounts(accno int primary key,branch_name varchar(30),balance real,
foreign key (branch_name) references branch(branch_name)on delete cascade on update cascade);
create table customer(customer_name varchar(30) primary key,customer_street varchar(20),customer_city varchar(20));
create table depositor(customer_name varchar(30),accno int,primary key(customer_name ,accno),
foreign key (accno) references accounts(accno)on delete cascade on update cascade,
foreign key (customer_name) references customer(customer_name)on delete cascade on update cascade);
create table loan(loan_number int primary key,branch_name varchar(30),amount real,foreign key (branch_name) references branch(branch_name));
create table borrower (customer_name varchar(30),loan_number int,primary key(customer_name, loan_number),
foreign key (customer_name) references customer(customer_name)on delete cascade on update cascade,
foreign key (loan_number) references loan(loan_number)on delete cascade on update cascade);
show tables;

insert into branch values('SBI PD NAGAR','BANGALORE', 200000);
insert into branch values('SBI RAJAJI NAGAR','BANGALORE', 500000);
insert into branch values('SBI JAYANAGAR','DELHI', 660000);
insert into branch values('SBI VIJAY NAGAR','CHENNAI', 870000);
insert into branch values('SBI HOSAKEREHALLI','CHENNAI',  550000);
select *from branch;

insert into accounts values(1001, 'SBI PD NAGAR',15000);
insert into accounts values(1002, 'SBI RAJAJI NAGAR',25000);
insert into accounts values(1003 ,'SBI JAYANAGAR',500);
insert into accounts values(1004, 'SBI VIJAY NAGAR',10000);
insert into accounts values(1005,'SBI VIJAY NAGAR',40000);
insert into accounts values(1006 ,'SBI HOSAKEREHALLI',4000);
insert into accounts values(1007 ,'SBI RAJAJI NAGAR',7000);
insert into accounts values(1008 ,'SBI RAJAJI NAGAR',7000);
select*from accounts;

insert into customer values('KEZAR','M G ROAD','BANGALORE');
insert into customer values('LAL KRISHNA', 'ST MKS ROAD','DELHI');
insert into customer values('RAHUL','AUGSTEN ROAD','CHENNAI');
insert into customer values('FAIZAL','RESEDENCY ROAD','BANGALORE');
insert into customer values('RAJEEV','DICKNSN ROAD','CHENNAI');
select *from customer;

insert into depositor values('KEZAR',1001);
insert into depositor values('KEZAR',1002);
insert into depositor values('LAL KRISHNA',1003);
insert into depositor values('RAHUL',1004);
insert into depositor values('RAHUL',1005);
insert into depositor values('FAIZAL',1006);
insert into depositor values('RAJEEV',1007);
insert into depositor values('RAJEEV',1008);
select *from depositor;

insert into loan values(10011 ,'SBI PD NAGAR',10000);
insert into loan values(10012,'SBI RAJAJI NAGAR',5000);
insert into loan values(10013,'SBI RAJAJI NAGAR',20000);
insert into loan values(10014,'SBI JAYANAGAR',15000);
insert into loan values(10015,'SBI HOSAKEREHALLI',25000);
select *from loan;

insert into borrower values('FAIZAL', 10011);
insert into borrower values('KEZAR', 10012);
insert into borrower values('FAIZAL', 10013);
insert into borrower values('LAL KRISHNA', 10014);
insert into borrower values('RAJEEV', 10015);
select *from borrower;
/*1*/
select customer_name from depositor d, accounts a where d.accno=a.accno and a.branch_name="SBI VIJAY NAGAR" group by d.customer_name having count(d.customer_name) >= 2;
/*2*/
select d.customer_name from accounts a, branch b, depositor d where b.branch_name=a.branch_name and a.accno=d.accno and b.branch_city="BANGALORE" 
group by d.customer_name having count(distinct b.branch_name)=(select count(branch_name) from branch where branch_city="BANGALORE");
/*3*/
delete from accounts where branch_name in(select branch_name from branch where branch_city="BANGALORE");
select *from accounts;