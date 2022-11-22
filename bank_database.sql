create table branch(
	branch_name varchar(255) primary key,
	branch_city varchar(255) not null,
	assets float
);

create table bank_account(
	acc_num int primary key,
	branch_name varchar(255) not null,
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
	acc_num varchar(255),
	primary key (customer_name, acc_no),
	foreign key (acc_num) references bank_account (acc_num),
	foreign key (customer_name) references bank_customer (customer_name)
);

create table loan(
	loan_num int primary key,
	branch_name varchar(255),
	amount float,
	foreign key (branch_name) references branch (branch_name)
);
