CREATE SCHEMA IF NOT EXISTS project;

DROP TABLE IF EXISTS project.donor;
DROP TABLE IF EXISTS project.donation;
DROP TABLE IF EXISTS project.bank;
DROP TABLE IF EXISTS project.con_don_bank;
DROP TABLE IF EXISTS project.con_don_bank_of_type;
DROP TABLE IF EXISTS project.bank_of_type;
DROP TABLE IF EXISTS project.transmission;
DROP TABLE IF EXISTS project.hospital;
DROP TABLE IF EXISTS project.request;


CREATE TABLE IF NOT EXISTS project.donor (
  id_donor integer primary key,
  how_many_times integer not null,
  name_don varchar(50) not null,
  blood_group varchar(10) not null,
  birth_date timestamp not null
);

CREATE TABLE IF NOT EXISTS project.donation (
  donation_id integer primary key,
  id_donor integer REFERENCES project.donor,
  type_donation varchar(50) not null,
  valid_from timestamp not null,
  valid_until timestamp not null,
  storage_conditions integer not null
);

CREATE TABLE IF NOT EXISTS project.bank (
  bank_id integer primary key,
  address varchar(50) not null
);


CREATE TABLE IF NOT EXISTS project.con_don_bank (
  unique_id integer primary key,
  donation_id integer REFERENCES project.donation,
  bank_id integer REFERENCES project.bank
);

CREATE TABLE IF NOT EXISTS project.bank_of_type (
  bank_of_type_id integer primary key,
  address varchar(50) not null,
  stored_volume integer not null
);

CREATE TABLE IF NOT EXISTS project.con_don_bank_of_type (
  unique_id integer primary key,
  donation_id integer REFERENCES project.donation,
  bank_of_type_id integer REFERENCES project.bank_of_type
);

CREATE TABLE IF NOT EXISTS project.transmission (
  transfer_id integer primary key,
  bank_id integer REFERENCES project.bank,
  bank_of_type_id integer REFERENCES project.bank_of_type,
  transfer_date timestamp not null,
  amount integer not null
);

CREATE TABLE IF NOT EXISTS project.hospital (
  hospital_id integer primary key,
  address varchar(50) not null
);

CREATE TABLE IF NOT EXISTS project.request (
  order_id integer primary key,
  bank_of_type_id integer REFERENCES project.bank_of_type,
  hospital_id integer REFERENCES project.hospital,
  blood_group varchar(10) not null,
  amount integer not null
);


INSERT into project.donor (id_donor, how_many_times, name_don, blood_group, birth_date) Values
(1, 23,'Jean Byrd', 'A', '1976-06-25'),
(2, 1,'Stanley Myers', 'AB', '1993-01-03'),
(3, 12,'Ricardo Rowe', 'A', '2002-02-02'),
(4, 7,'James Gray', 'O', '1989-01-01'),
(5, 7,'Virginia Russell', 'B', '2002-09-10'),
(6, 3,'Sherry Fisher', 'O', '2004-03-25'),
(7, 10,'Doris Jones', 'A', '2004-03-25'),
(8, 9,'John Stephens', 'O', '2000-03-25'),
(9, 4,'Virginia Russell', 'A', '1998-09-10'),
(10, 2,'Angel Holmes', 'B', '2001-09-10'),
(11, 5,'Sylvia Wilson', 'AB', '1988-09-10'),
(12, 1,'Sandra Schmidt', 'AB', '2004-09-10'),
(13, 0,'Norman Walker', 'B', '2000-09-10')
on conflict(id_donor) do nothing;

INSERT into project.donation (donation_id, id_donor, type_donation, valid_from, valid_until, storage_conditions) Values
(1, 11,'thrombocytic','2024-03-25', '2024-04-01',7),
(2, 12,'erythrocytic','2023-03-22', '2023-03-29',7),
(3, 6,'erythrocytic','2024-03-25', '2024-04-01', 7),
(4, 13,'thrombocytic','2024-03-25', '2024-04-01', 7),
(5, 4,'plasma','2023-03-26', '2024-03-29',3),
(6, 1,'thrombocytic','2012-03-22', '2023-03-29', 7),
(7, 12,'erythrocytic','2024-03-22', '2023-03-29', 7),
(8, 2,'erythrocytic','2024-03-22', '2023-03-29', 7),
(9, 13,'thrombocytic','2021-05-13', '2021-05-20', 7),
(10, 10,'plasma','2024-03-27', '2024-03-30',3),
(11, 6,'plasma','2024-03-25', '2024-03-28',3),
(12, 7,'thrombocytic','2024-03-22', '2024-03-29', 7),
(13, 9,'erythrocytic','2020-09-22', '2020-09-29', 7),
(14, 6,'erythrocytic','2020-09-22', '2020-09-29', 7),
(15, 13,'thrombocytic','2018-01-19', '2018-01-26', 7),
(16, 3,'plasma','2024-03-27', '2024-03-27', 3),
(17, 11,'thrombocytic','2018-09-03', '2018-09-10', 7),
(18, 12,'erythrocytic','2018-01-19', '2018-01-26', 7),
(19, 3,'erythrocytic','2019-06-03', '2019-06-10', 7),
(20, 10,'thrombocytic','2018-09-03', '2018-09-10', 7),
(21, 13,'plasma','2021-03-25', '2021-03-28', 3),
(22, 5,'plasma','2021-03-25', '2021-03-28', 3);

INSERT into project.bank (bank_id, address) Values
(1, 'Savestreet');

INSERT into project.bank_of_type (bank_of_type_id, address, stored_volume) Values
(1, 'Gage street', 12350),
(2, 'Ery street', 41250),
(3, 'Mirrow street', 1450);

INSERT into project.con_don_bank (unique_id, donation_id, bank_id) Values
(1, 1, 1),
(2, 2, 1),
(3, 3, 1),
(4, 4, 1),
(5, 5, 1),
(6, 6, 1),
(7, 7, 1),
(8, 8, 1),
(9, 9, 1),
(10, 10, 1),
(11, 11, 1),
(12, 12, 1),
(13, 13, 1),
(14, 14, 1),
(15, 15, 1),
(16, 16, 1),
(17, 17, 1),
(18, 18, 1),
(19, 19, 1),
(20, 20, 1),
(21, 21, 1),
(22, 22, 1);

INSERT into project.con_don_bank_of_type (unique_id, donation_id, bank_of_type_id) Values
(1, 1, 1),
(2, 2, 2),
(3, 3, 2),
(4, 4, 1),
(5, 5, 3),
(6, 6, 1),
(7, 7, 2),
(8, 8, 2),
(9, 9, 1),
(10, 10, 3),
(11, 11, 3),
(12, 12, 1),
(13, 13, 2),
(14, 14, 2),
(15, 15, 1),
(16, 16, 3),
(17, 17, 1),
(18, 18, 2),
(19, 19, 2),
(20, 20, 1),
(21, 21, 3),
(22, 22, 3);

INSERT into project.transmission (transfer_id, bank_id, bank_of_type_id, transfer_date, amount) Values
(1, 1, 1, '2024-03-25', 900),
(2, 1, 2, '2024-03-25', 450),
(3, 1, 3, '2024-03-25', 600),
(4, 1, 2, '2023-03-22', 450),
(5, 1, 3, '2023-03-26', 600),
(6, 1, 1, '2012-03-22', 450),
(7, 1, 2, '2024-03-22', 900),
(8, 1, 1, '2024-03-22', 450),
(9, 1, 1, '2021-05-13', 450),
(10, 1, 3, '2024-03-27', 1200),
(11, 1, 3, '2020-09-22', 900),
(12, 1, 1, '2018-01-19', 450),
(13, 1, 2, '2018-01-19', 450),
(14, 1, 1, '2018-09-03', 900),
(15, 1, 2, '2019-06-03', 450),
(16, 1, 3, '2021-03-25', 1200);

INSERT into project.hospital (hospital_id, address) Values
(1, 'Peace square'),
(2, 'Michurina street'),
(3, 'Sweet street'),
(4, 'Doctor queue'),
(5, 'Samoilovskaya street'),
(6, 'Mirror alley'),
(7, 'Dvoreckaya valley'),
(8, 'Kolomenska square');

INSERT into project.request (order_id, bank_of_type_id, hospital_id, blood_group, amount) Values
(1, 3, 2, 'A', 1000),
(2, 3, 1, 'AB', 900),
(3, 1, 8, 'AB', 945),
(4, 1, 2, 'A', 2130),
(5, 2, 6, 'AB', 600),
(6, 2, 2, 'B', 4500),
(7, 1, 5,'B', 1234);

--1) вывод всех людей, пришедших на донацию в определённый день
select
  t1.id_donor ,
  t1.name_don,
  t1.blood_group
from
  project.donor t1
join project.donation t2 on
  t1.id_donor = t2.id_donor
where
  t2.type_donation = 'erythrocytic' and 
  t2.valid_from = '2024-03-22';

--2) вывод имён доноров, которые проходили донацию хотя бы 2 раза
select
  name_don 
from
  project.donor 
where id_donor in (
    select
      id_donor 
    from
      project.donation 
    group by
      id_donor 
    having 
      count(*) > 1
);

--3) объём крови, который хранится в определенных банках
select 
  sum(stored_volume) 
from
  project.bank_of_type 
where bank_of_type_id in (
    select
      bank_of_type_id 
    from 
      project.con_don_bank_of_type 
    where 
      bank_of_type_id = 1
);

--4) вывод количества людей, которые сдавали кровь группы А
select 
  count(*) 
from 
  project.donation 
where id_donor in (
    select distinct 
      id_donor 
    from 
      project.donor 
    where 
      blood_group = 'A'
);

--5) количества донаций, каждого донора.
select
  d1.id_donor,
  d2.name_don,
  count(*) as count
from
  project.donation d1
join project.donor d2 on
  d1.id_donor = d2.id_donor
group by
  (d2.name_don,
  d1.id_donor)
order by
  count desc ;

--6) вывод количества запросов больныцы на улице Michurina street
select 
 count(*) 
from 
  project.request r 
join project.hospital h on 
  r.hospital_id = h.hospital_id 
where 
  h.address = 'Michurina street';

--7) все донации, совершаемые Norman Walker
select
  *
from
  project.donation d1
where id_donor in (
    select 
      id_donor 
    from 
      project.donor 
    where 
      name_don = 'Norman Walker'
);

--8) вывод самого последнего трансфера
select
  bank_of_type_id,
  transfer_date,
  amount
from
  project.transmission
where
  transfer_date =(
  select
    max(transfer_date)
  from
    project.transmission);

--9) Вывод первых 5 донаций
select
  don.valid_from,
  d.name_don,
  don.type_donation ,
  don.valid_until,
  d.blood_group
from
  project.donation don
join project.donor d on
  don.id_donor = d.id_donor
order by
  don.valid_from
limit 5;

--10) вывод всех донаций, хранимых в главном банке
select
  don.id_donor,
  don.valid_from,
  don.type_donation,
  t.bank_id
from
  project.donation don
join project.con_don_bank t on
  t.donation_id = don.donation_id
where bank_id in (
    select
      bank_id 
    from
      project.bank)
order by
  (don.id_donor,don.valid_from);
