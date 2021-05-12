create database order_Processing;
use order_Processing;
create table customer(custno int,cname varchar(30),city varchar(30),primary key(custno));
create table order1(orderno int,odate date,custno int,ord_amt int,primary key(orderno),foreign key(custno) references customer(custno));
create table item(itemno int,untiprice int,primary key(itemno));
create table order_item(orderno int,itemno int,quantity int,primary key(orderno,itemno),foreign key(orderno) references order1(orderno),foreign key(itemno) references item(itemno) on delete cascade);
create table warehouse(warehouseno int,city varchar(30),primary key(warehouseno));
create table shipment(orderno int,warehouseno int,ship_date date,primary key(orderno,warehouseno),foreign key(orderno) references order1(orderno),foreign key(warehouseno) references warehouse(warehouseno));
show tables;

insert into customer values (771,'PUSHPA K','BANGALORE');
insert into customer values (772,'SUMAN','MUMBAI');
insert into customer values (773,'SOURAV','CALICUT');
insert into customer values (774,'LAILA','HYDERABAD');
insert into customer values (775,'FAIZAL','BANGALORE');

insert into order1 values (111,'2002-1-22',771,18000);
insert into order1 values (112,'2002-7-30',774,6000);
insert into order1 values (113,'2003-4-3',775,9000);
insert into order1 values (114,'2003-10-3',775,29000);
insert into order1 values (115,'2003-11-3',773,29000);
insert into order1 values (116,'22-8-4',772,56000);
insert into order1 values (117,'22-9-4',771,20000);
insert into order1 values (118,'22-11-4',775,29000);
insert into order1 values (119,'22-2-5',774,29000);
insert into order1 values (120,'22-10-5',775,29000);

insert into item values (5001,503);
insert into item values (5002,750);
insert into item values (5003,150);
insert into item values (5004,600);
insert into item values (5005,890);

insert into order_item values (111,5001,50);
insert into order_item values (112,5003,20);
insert into order_item values (113,5002,50);
insert into order_item values (114,5005,60);
insert into order_item values (115,5004,90);
insert into order_item values (116,5001,10);
insert into order_item values (117,5003,80);
insert into order_item values (118,5005,50);
insert into order_item values (119,5002,10);
insert into order_item values (120,5004,45);

insert into warehouse values (1,'DELHI');
insert into warehouse values (2,'BOMBAY');
insert into warehouse values (3,'CHENNAI');
insert into warehouse values (4,'BANGALORE');
insert into warehouse values (5,'BANGALORE');
insert into warehouse values (6,'DELHI');
insert into warehouse values (7,'BOMBAY');
insert into warehouse values (8,'CHENNAI');
insert into warehouse values (9,'DELHI');
insert into warehouse values (10,'BANGALORE');

insert into shipment values (111,1,'2002-2-10');
insert into shipment values (112,5,'2002-2-10');
insert into shipment values (113,8,'2003-2-10');
insert into shipment values (114,3,'2003-10-10');
insert into shipment values (115,9,'2004-1-19');
insert into shipment values (116,1,'2004-9-20');
insert into shipment values (117,5,'2004-9-10');
insert into shipment values (118,7,'2004-11-30');
insert into shipment values (119,7,'2005-4-30');
insert into shipment values (120,6,'2005-10-21');

select * from customer;
select * from order1;
select * from item;
select * from order_item;
select * from warehouse;
select * from shipment;

/*query(1)*/
select c.custno,count(*) as No_of_orders,avg(o.ord_amt) as Avg_order_amount from customer c,
order1 o where o.custno=c.custno group by c.custno;
/*query(3)*/
delete from item where itemno=5002;
/*query(2)*/
select orderno from shipment, warehouse where shipment.warehouseno = warehouse.warehouseno and 
warehouse.city = 'BANGALORE';

commit;