create database if not exists 21cs116_vehicle_insurance;
use 21cs116_vehicle_insurance;

create table person(
	driver_id char(10) primary key,
    name varchar(255),
    address varchar(255)
);

create table car(
	reg_num char(10) primary key,
    model varchar(255),
    year int
);

drop table car;

alter table car modify reg_no char(10);

create table owns(
	driver_id char(10),
    reg_no char(10),
    primary key(driver_id, reg_no),
    foreign key(driver_id) references person(driver_id),
    foreign key(reg_no) references car(reg_no)
);

create table accidents(
	report_num int primary key,
    accident_date date,
    location varchar(255)
);

create table paticipated(
	driver_id char(10),
    reg_num char(10),
    report_num int,
    damage_amount int,
    primary key(driver_id, reg_num, report_num),
    foreign key(driver_id) references person(driver_id),
    foreign key(reg_num) references car(reg_num),
    foreign key(report_num) references accidents(report_num)
);

