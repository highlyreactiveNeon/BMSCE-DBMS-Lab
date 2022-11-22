create database if not exists 21cs116_bank_database;
use 21cs116_bank_database;

-- todo 1
create table branch(
	branch_name varchar(255) primary key,
	branch_city varchar(255) not null,
	assets float
);

create table bank_account(
	acc_num int primary key,
	branch_name varchar(255),
	balance float,
	foreign key (branch_name) references branch(branch_name)
);

create table bank_customer(
	customer_name varchar(255) primary key,
	customer_street varchar(255) not null,
	city varchar(255) not null
);


create table depositer(
	customer_name varchar(255),
	acc_num int,
	primary key (customer_name, acc_num),
	foreign key (acc_num) references bank_account (acc_num),
	foreign key (customer_name) references bank_customer (customer_name)
);

create table loan(
	loan_num int primary key,
	branch_name varchar(255),
	amount float,
	foreign key (branch_name) references branch (branch_name)
);

-- todo 2
insert into branch values
  ("SBI_Chamrajpet", "Bangalore", 50000),
  ("SBI_ResidencyRoad", "Bangalore", 10000),
  ("SBI_ShivajiRoad", "Bombay", 20000),
  ("SBI_ParlimentRoad", "Delhi", 10000),
  ("SBI_Jantarmantar", "Delhi", 20000);
  
insert into bank_account values
  (1, "SBI_Chamrajpet", 2000),
  (2, "SBI_ResidencyRoad", 5000),
  (3, "SBI_ShivajiRoad", 6000),
  (4, "SBI_ParlimentRoad", 9000),
  (5, "SBI_Jantarmantar", 8000),
  (6, "SBI_ShivajiRoad", 4000),
  (8, "SBI_ResidencyRoad", 4000),
  (9, "SBI_ParlimentRoad", 3000),
  (10, "SBI_ResidencyRoad", 5000),
  (11, "SBI_Jantarmantar", 2000);

insert into bank_customer values
  ("Avinash", "Bull Temple Road", "Bangalore"),
  ("Dinesh", "Bannergatta Road", "Bangalore"),
  ("Mohan", "National College Road", "Bangalore"),
  ("Nikil", "Akbar Road", "Delhi"),
  ("Ravi", "Prithviraj Road", "Delhi");

insert into depositer values
  ("Avinash", 1),
  ("Dinesh", 2),
  ("Nikil", 4),
  ("Ravi", 5),
  ("Avinash", 8),
  ("Nikil", 9),
  ("Dinesh", 10),
  ("Nikil", 11);
  
insert into loan values
  (1, "SBI_Chamrajpet", 1000),
  (2, "SBI_ResidencyRoad", 2000),
  (3, "SBI_ShivajiRoad", 3000),
  (4, "SBI_ParlimentRoad", 4000),
  (5, "SBI_Jantarmantar", 5000);
  
-- todo 3
select branch_name, assets/100000 as assets_in_lakh from branch;

-- todo 4
create view todo3 as
select d.acc_num, branch_name, customer_name
from bank_account b, depositer d
where d.acc_num = b.acc_num;

select * from todo3;

select distinct customer_name
from todo3 outerT
where 1 < (
	select count(*)
    from todo3
    where branch_name = outerT.branch_name and customer_name = outerT.customer_name
);

-- todo 5
create view branch_loans as 
select branch_name, amount
from loan;

select * from branch_loans;

-- todo OnSpot
update bank_account
set balance = balance + 1000
where acc_num in (select acc_num
		from depositer d
        where d.customer_name in (select customer_name
				from bank_customer where city = "Bangalore"
            )
    );
    
select * from bank_account;
