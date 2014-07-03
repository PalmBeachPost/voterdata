SET CLIENT_ENCODING TO UTF8;
SET STANDARD_CONFORMING_STRINGS TO ON;

BEGIN;

/*--------------------------Raw Data------------------------------*/
CREATE TABLE IF NOT EXISTS rawvoter (
		county varchar(3),
		 id int ,
		 last_name varchar,
		 name_suffix varchar,
		 first_name varchar,
		 middle_name varchar,
		 res_address_suppress varchar,
		 res_address_line1 varchar,
		 res_address_line2 varchar,
		 res_city varchar,
		 res_state varchar,
		 res_zip varchar,
		 mail_address_line1 varchar,
		 mail_address_line2 varchar,		 
		 mail_address_line3 varchar,
		 mail_city varchar,
		 mail_state varchar,
		 mail_zip varchar,
		 mail_country varchar,
		 gender char,
		 race int,
		 birth_date varchar, 
		 reg_date varchar,
		 party varchar,
		 precinct varchar,
		 precinct_group varchar,
		 precinct_Split varchar,
		 precinct_Suffix varchar,
		 status varchar,
		 congressional_District varchar,
		 house_District varchar,
		 senate_District varchar,
		 county_district varchar,
		 school_District varchar,
		 area_Code varchar,
		 phone_Number varchar,
		 dummy varchar,
		 email varchar
		);

/*----------------------------Voter table--------------------------*/
	DROP TABLE IF EXISTS voters CASCADE;
	CREATE TABLE voters (
		 id int PRIMARY KEY,	 
		 gender char NOT NULL,
		 race int NOT NULL,
		 birth_date date,
		 isactive boolean DEFAULT false --for easy querying
		);
	CREATE INDEX ON voters (id, race);
	CREATE INDEX ON voters (id, gender);
	CREATE INDEX ON voters (id, isactive);
	CREATE INDEX ON voters (id, race, isactive);
	CREATE INDEX ON voters (id, gender, isactive);
	/*----------------------------Voter table--------------------------*/
	DROP TABLE IF EXISTS registration CASCADE;
	CREATE TABLE registration (
		 reg_id SERIAL,
		 voter_id int REFERENCES voters(id),
		 county varchar(3) NOT NULL,	
		 reg_date date,
		 party varchar,
		 status varchar,
		 PRIMARY KEY(voter_id, county, status)
		);
	CREATE INDEX ON registration (voter_id);
	CREATE INDEX ON registration (voter_id, status);
	CREATE INDEX ON registration (voter_id, party);
	CREATE INDEX ON registration (voter_id, party, status);

	/*----------------------------Voter details table--------------------------*/
    DROP TABLE IF EXISTS voter_details CASCADE;
	CREATE TABLE voter_details (
		 reg_id int PRIMARY KEY,		 
		 voter_id int REFERENCES voters (id),
		 last_name varchar NOT NULL,
		 name_suffix varchar,
		 first_name varchar NOT NULL,
		 middle_name varchar,
		 res_address_suppress varchar,
		 res_address_line1 varchar,
		 res_address_line2 varchar,
		 res_city varchar,
		 res_state varchar,
		 res_zip varchar,
		 mail_address_line1 varchar,
		 mail_address_line2 varchar,
		 mail_city varchar,
		 mail_state varchar,
		 mail_zip varchar,
		 mail_country varchar,
		 precinct varchar,
		 precinct_group varchar,
		 precinct_Split varchar,
		 precinct_Suffix varchar,
		 congressional_District varchar,
		 house_District varchar,
		 senate_District varchar,
		 county_district varchar,
		 school_District varchar,
		 area_Code varchar,
		 phone_Number varchar,
		 email varchar
		 );
		 CREATE INDEX ON voter_details (voter_id, reg_id);
		 CREATE INDEX on voter_details(voter_id);
COMMIT;