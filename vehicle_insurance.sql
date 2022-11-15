create database if not exists 21cs116_vehicle_insurance;
use 21cs116_vehicle_insurance;

create table person(
	driver_id char(10) primary key,
    name varchar(255) not null,
    address varchar(255) not null
);

create table car(
	reg_num char(10) primary key,
    model varchar(255) not null,
    year int
);

create table owns(
	driver_id char(10),
    reg_num char(10),
    primary key(driver_id, reg_num),
    foreign key(driver_id) references person(driver_id),
    foreign key(reg_num) references car(reg_num)
);

create table accidents(
	report_num int primary key,
    accident_date date,
    location varchar(255)
);

create table participated(
	driver_id char(10),
    reg_num char(10),
    report_num int,
    damage_amount int,
    primary key(driver_id, reg_num, report_num),
    foreign key(driver_id) references person(driver_id),
    foreign key(reg_num) references car(reg_num) on delete cascade,
    foreign key(report_num) references accidents(report_num) on delete cascade
);

drop table participated;

-- inserting values
insert into person values
	('A01', 'Richard', 'Srinivas Nagar'),
    ('A02', 'Pradeep', 'Rajaji Nagar'),
    ('A03', 'Smith', 'Ashok Nagar'),
    ('A04', 'Venu', 'NR Colony'),
    ('A05', 'John', 'Hanumanth Nagar');
    
insert into car values
	('KA052250', 'Indica', 1990),
    ('KA031181', 'Lancer', 1957),
    ('KA095477', 'Toyota', 1998),
    ('KA053408', 'Honda', 2008),
    ('KA041702', 'Audi', 2005);
    
insert into owns values
	('A01', 'KA052250'),
    ('A02', 'KA053408'),
    ('A03', 'KA031181'),
    ('A04', 'KA095477'),
    ('A05', 'KA041702');

insert into accidents values
	(11, '2003-01-01', 'Mysore Road'),
    (12, '2004-02-02', 'South end Circle'),
    (13, '2003-01-21', 'Bull temple Road'),
    (14, '2008-02-17', 'Mysore Road'),
    (15, '2004-03-05', 'Kanakpura Road');

insert into participated values
	('A01', 'KA052250', 11, 10000),
    ('A02', 'KA053408', 12, 50000),
    ('A03', 'KA031181', 13, 25000),
    ('A04', 'KA095477', 14, 3000),
    ('A05', 'KA041702', 15, 5000);


-- Queries  
select * from car order by year asc;

select count(report_num)
from participated p, car
where p.reg_num = car.reg_num and car.model = "Lancer";

select count(distinct driver_id)
from accidents a, participated p
where a.accident_date like '2008%' and p.report_num = a.report_num;

-- Todos
-- T1
select * from participated
order by damage_amount desc;

-- T2
select avg(damage_amount) from participated;

-- T3
delete from participated
where damage_amount < (select t.amt from (select avg(damage_amount) as amt from participated) t);

select * from participated;

-- T4
select person.name
from person, participated p
where person.driver_id = p.driver_id and p.damage_amount > (select avg(damage_amount) from participated);

-- T5
select max(damage_amount) from participated;

select * from accidents;


-- on spot
select c.model
from accidents a, car c, participated p
where a.report_num = p.report_num and c.reg_num = p.reg_num and a.location = "Bull temple Road";
