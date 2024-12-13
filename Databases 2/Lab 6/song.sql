drop table if exists  songs_words;
drop table if exists  songs;

create table songs(
	song_title varchar(300) primary key,
	singer varchar(100),
	song_year int);

create table songs_words(
	song_title varchar(300) references songs(song_title),
	word varchar(40),
	word_count int);

insert into songs values ('Last Night','Morgan Wallen',2023);
insert into songs values ('Flowers','Miley Cyrus',2023);
insert into songs values ('Kill Bill','SZA',2023);
insert into songs values ('Anti-Hero','Taylor Swift',2023);
insert into songs values ('Creepin','Metro Boomin',2023);
insert into songs values ('Calm Down','Rema',2023);
insert into songs values ('Die For You','Weekend',2023);
insert into songs values ('Fast Car','Luke Combs',2023);
insert into songs values ('Snooze','SZA',2023);
insert into songs values ('Physical','Olivia Newton-John',1982);
insert into songs values ('Eye of the Tiger','Survivor',1982);
insert into songs values ('I Love Rock n Roll','Joan Jett',1982);
insert into songs values ('Ebony and Ivory','Paul McCartney',1982);
insert into songs values ('Centerfold','The J. Geils Band',1982);
insert into songs values ('Jack and Diane','John Cougar',1982);
insert into songs values ('Hurts So Good','John Cougar',1982);
insert into songs values ('dont you want me','human league',1982);
insert into songs values ('Abracadabra','Steve Miller Band',1982);
insert into songs values ('Hard to Say Im sorry','Chicago',1982);