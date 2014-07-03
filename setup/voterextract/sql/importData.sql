SET CLIENT_ENCODING TO UTF8;
SET STANDARD_CONFORMING_STRINGS TO ON;



	DROP TABLE IF EXISTS temp;

	CREATE TABLE temp (
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

	COPY temp FROM :file DELIMITER E'\t';

	COPY rawvoter FROM :file DELIMITER E'\t';
	

	INSERT INTO voters
	SELECT 
		 id, 
		 gender,
		 race,
		 CASE
			WHEN birth_date is NULL OR birth_date= '' OR birth_date = '*' THEN NULL
			ELSE to_date(birth_date, 'MM/DD/YY')
		 END,
		 CASE
		 	WHEN status = 'INA' THEN false
		 	ELSE true
		 END
	FROM temp
	WHERE NOT EXISTS (SELECT id FROM voters v WHERE v.id = temp.id);
	
	INSERT  INTO registration (voter_id, county, reg_date, party, status)
	SELECT 
		 id,
		 county,	
		 CASE
			WHEN reg_date is NULL OR reg_date= '' OR reg_date = '*' THEN NULL
			ELSE to_date(reg_date, 'MM/DD/YY')
		END,
		 party,
		 status
	FROM temp;

	INSERT  INTO voter_details
	SELECT 
	     (SELECT reg_id FROM registration R WHERE R.voter_id = id AND R.county = county  AND R.status  = status LIMIT 1),		 
		 id,
		 last_name,
		 name_suffix,
		 first_name,
		 middle_name,
		 res_address_suppress,
		 res_address_line1,
		 res_address_line2,
		 res_city,
		 res_state,
		 res_zip,
		 mail_address_line1,
		 mail_address_line2,
		 mail_city,
		 mail_state,
		 mail_zip,
		 mail_country,
		 precinct,
		 precinct_group,
		 precinct_Split,
		 precinct_Suffix,
		 congressional_District,
		 house_District,
		 senate_District,
		 county_district,
		 school_District,
		 area_Code,
		 phone_Number,
		 email
	FROM temp;