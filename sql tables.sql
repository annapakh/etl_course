CREATE SCHEMA "final" AUTHORIZATION postgres;

CREATE TABLE final.fact_flights (
	passenger int4 NULL,
	date_dep timestamp NULL,
	date_arr timestamp NULL,
	diff_dep varchar(20) NULL,
	diff_arr varchar(20) NULL,
	model text NULL,
	airport_dep varchar(50) NULL,
	airport_arr varchar(50) NULL,
	fare_condition varchar(20) NULL,
	amount numeric(10, 2) NULL
);

CREATE TABLE final.calendar (
	"date" date NOT NULL,
	CONSTRAINT calendar_pk PRIMARY KEY (date)
);

CREATE TABLE final.aircrafts (
	aircraft_code varchar(30) NOT NULL,
	model text NOT NULL,
	"range" varchar(300) NOT NULL,
	CONSTRAINT aircrafts_pkey PRIMARY KEY (aircraft_code)
);

CREATE TABLE final.aircrafts_reg (
	aircraft_code varchar(30) NOT NULL,
	model text NOT NULL,
	"range" varchar(300) NOT NULL,
	CONSTRAINT aircrafts_pkey_reg PRIMARY KEY (aircraft_code)
);

CREATE TABLE final.passenger (
	passenger_id varchar(30) NOT NULL,
	passenger_name text NOT NULL,
	contact_data varchar(300) NULL,
	CONSTRAINT passenger_pkey PRIMARY KEY (passenger_id)
);

CREATE TABLE final.passenger_reg (
	passenger_id varchar(30) NOT NULL,
	passenger_name text NOT NULL,
	contact_data varchar(300) NULL,
	CONSTRAINT passenger_pkey_reg PRIMARY KEY (passenger_id)
);


CREATE TABLE final.airports (
	airport_code bpchar(3) NOT NULL,
	airport_name text NOT NULL,
	city text NOT NULL,
	timezone text NOT NULL,
	CONSTRAINT airports_pkey PRIMARY KEY (airport_code)
);

CREATE TABLE final.airports_reg (
	airport_code bpchar(3) NOT NULL,
	airport_name text NOT NULL,
	city text NOT NULL,
	timezone text NOT NULL,
	CONSTRAINT airports_pkey_reg PRIMARY KEY (airport_code)
);

CREATE TABLE final.tariff (
	ticket_no bpchar(13) NOT NULL,
	flight_id int4 NOT NULL,
	fare_conditions varchar(10) NOT NULL,
	amount numeric(10, 2) NOT NULL,
	CONSTRAINT ticket_flights_amount_check CHECK ((amount >= (0)::numeric)),
	CONSTRAINT ticket_flights_fare_conditions_check CHECK (((fare_conditions)::text = ANY (ARRAY[('Economy'::character varying)::text, ('Comfort'::character varying)::text, ('Business'::character varying)::text]))),
	CONSTRAINT ticket_flights_pkey PRIMARY KEY (ticket_no, flight_id)
);

CREATE TABLE "final".fact_flights_reg (
	passenger int4 NULL,
	date_dep timestamp NULL,
	date_arr timestamp NULL,
	diff_dep varchar(20) NULL,
	diff_arr varchar(20) NULL,
	model text NULL,
	airport_dep varchar(50) NULL,
	airport_arr varchar(50) NULL,
	fare_condition varchar(20) NULL,
	amount numeric(10, 2) NULL
);

insert into final.calendar select dt::date from generate_series('2017-01-01'::date, 
  current_date::date, '1 day'::interval) dt
