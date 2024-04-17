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