create database if not exists 21cs116_bank_database;
use 21cs116_bank_database;

create table supplier(
	sid int primary key,
	sname varchar(20),
	city varchar(20)
);
select * from supplier;

insert into supplier values
	(10001,'Acme Widget','Bangalore'),
	(10002,'Johns','Kolkata'),
	(10003,'Vimal','Mumbai'),
	(10004,'Reliance','Delhi');

create table parts(
	pid int primary key,
	pname varchar(20),
	color varchar(20)
);
select * from parts;

insert into parts values
	(20001,'Book','Red'),
	(20002,'Pen','Red'),
	(20003,'Pencil','Green'),
	(20004,'Mobile','Green'),
	(20005,'Charger','Black');

create table catalog(
	sid int,
	pid int,
	cost int,
	primary key (sid,pid),
	foreign key (sid) references supplier(sid) on delete cascade on update cascade,
	foreign key (pid) references parts(pid) on delete cascade on update cascade
);
select * from catalog;

insert into catalog values
	(10001,20001,10),
	(10001,20002,10),
	(10001,20003,30),
	(10001,20004,10),
	(10001,20005,10),
	(10002,20001,10),
	(10002,20002,20),
	(10003,20003,30),
	(10004,20003,40);
    
insert into catalog values
	(10004,20001,10);
    
delete from catalog
where sid = 10004 and pid = 20001;

-- todo 1
select distinct p.pname
from parts p, catalog c
where sid is not null;

-- todo 2
select sname
from supplier
where sid in (select sid
	from catalog
	group by sid
	having count(pid) = (select count(*) from parts));
    
-- todo 3
select sname
from supplier oT
where (select count(pid) from parts where color = "Red") = (
	select count(*)
    from catalog c
    where c.sid = oT.sid and c.pid in (select pid from parts where color = "Red")
);
# select sname, c.sid
# from supplier s, catalog c, parts p
# where s.sid = c.sid and c.pid and p.pid and p.color = "Red"
# group by sid
# having count(c.pid) = (select count(pid) from parts where color = "Red");

-- todo 4
select p.pname
from catalog c, parts p
where c.pid = p.pid and sid = (select sid from supplier where sname = "Acme Widget")
	and c.pid not in (
		select pid
		from catalog
		where sid <> (select sid from supplier where sname = "Acme Widget")
    );

-- todo 5
select sid
from catalog outerC
where cost > (
		select avg(cost)
		from catalog c
        where outerC.pid = c.pid
		group by pid
	);


-- todo 6
select s.sid ,s.sname, c.pid
from Supplier s,Catalog c
where c.sid=s.sid and c.cost= (
		select max(c1.cost)
		from Catalog c1
		where c.pid=c1.pid
		group by c1.pid
	);
