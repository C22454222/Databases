drop table if exists insta_users;
create table insta_users (username varchar(30) primary key,
first_name char(20), last_name char(20), signup_date date);
insert into insta_users values ('lucky_cat', 'andrea', 'costa', '2021-09-27');
insert into insta_users values('john_doe', 'John', 'Doe', '2022-01-15');
insert into insta_users values('jane_smith', 'Jane', 'Smith', '2022-03-10');
insert into insta_users values('tom_jones', 'Tom', 'Jones', '2022-05-20');
select * from insta_users;