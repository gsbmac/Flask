drop table if exists users;
create table users (
  id integer primary key autoincrement,
  username text not null,
  password text not null
);

drop table if exists logs;
create table logs (
  log_id integer primary key autoincrement,
  username text not null,
  start_date timestamp not null,
  end_date timestamp not null,
  status smallint not null
);

insert into users (username, password) values ('mac', '140c1f12feeb2c52dfbeb2da6066a73a');
insert into users (username, password) values ('alexis', '059bf68f71c80fce55214b411dd2280c');
insert into users (username, password) values ('jovie', '2240ef71392026698809c0df09c4c694');

insert into logs (log_id, username, start_date, end_date, status) values (1, 'mac', '2015-03-30 08:00:00', '2015-03-30 17:00:00', 0);
insert into logs (log_id, username, start_date, end_date, status) values (2, 'mac', '2015-03-31 08:00:00', '2015-03-31 17:00:00', 0);