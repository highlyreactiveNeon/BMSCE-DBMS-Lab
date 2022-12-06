create database if not exists 21cs116_bank_database;
use 21cs116_bank_database;

-- todo 1
create table dept(
	dept_num int primary key,
	dname varchar(255),
	dloc varchar(255)
);

create table project(
	pnum int primary key,
	ploc varchar(255),
	pname varchar(255)
);

create table employee(
	emp_num int,
	ename varchar(255),
	mgr_num int,
	hiredate date,
	sal int,
	dept_num int,
	primary key (emp_num),
	foreign key (dept_num) references dept (dept_num) on delete cascade on update cascade
);

create table incentives(
	emp_num int,
	incentive_date date,
	incentive_amount int,
	primary key (emp_num,incentive_date),
    foreign key (emp_num) references employee (emp_num) on delete cascade on update cascade
);

create table assigned_to(
	emp_num int,
	pnum int,
	job_role varchar(255),
	primary key(emp_num,pnum),
	foreign key(emp_num) references employee(emp_num) on delete cascade on update cascade,
	foreign key(pnum) references project(pnum) on delete cascade on update cascade
);

-- todo 2
insert into dept values
(1,'Logistics','Bengaluru'),
(2,'Statistics','Mysuru'),
(3,'Marketing','Hyderabad'),
(4,'Design','Bengaluru'),
(5,'Management','Mysuru'),
(6,'Finance','Bombay');

insert into project values
(01,'Hyderabad','Project_Zero'),
(02,'Mysuru','Project_Alpha'),
(03,'Hyderabad','Project_Bozo'),
(04,'Bengaluru','Project_Waaris'),
(05,'Bombay','Project_Onslaught'),
(06,'Mysuru','Project_DivideBY');

insert into employee values
(101,'Avinash',2310,'2021-10-09',56000,1),
(102,'Dinesh',2317,'2021-03-07',96000,1),
(103,'Balaji',2510,'2021-10-08',66000,1),
(104,'Sovesh',9310,'2021-02-09',42000,2),
(105,'Sordelu',3310,'2021-03-04',76000,2),
(106,'Hasbulla',5561,'2022-01-05',47900,3),
(107,'Tacitus Kilgore',7810,'2021-11-19',420000,4),
(108,'Govardhan Prasad',4231,'2021-02-13',327100,5),
(109,'Champika',1324,'2021-07-14',87600,5),
(110,'Robin',6780,'2021-12-31',123000,5);

insert into incentives values
(101,'2022-10-01',5000),
(106,'2022-11-02',7000),
(102,'2022-05-03',5000),
(105,'2022-07-05',5000),
(110,'2022-08-07',9000);

insert into assigned_to values
(101,01,'Developer'),
(103,04,'Tester'),
(102,05,'Manager'),
(105,03,'Supervisor'),
(107,02,'Team Leader'),
(106,06,'Executive Manager');

-- todo 3
select a.emp_num
from assigned_to a, project p
where a.pnum = p.pnum and p.ploc in ('Hyderabad','Mysuru','Bengaluru');

-- todo 4
select e.emp_num
from employee e
where e.emp_num not in (select emp_num
	from incentives);
    
-- todo 5
select e.ename, e.emp_num, d.dname, a.job_role, d.dloc, p.ploc
from dept d, employee e, assigned_to a, project p
where e.emp_num = a.emp_num and a.pnum = p.pnum and e.dept_num = d.dept_num and d.dloc = p.ploc;

-- todo onSpot
