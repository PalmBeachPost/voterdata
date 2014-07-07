SET CLIENT_ENCODING TO UTF8;
SET STANDARD_CONFORMING_STRINGS TO ON;

/*----------------------------RAW History table--------------------------*/
	DROP TABLE IF EXISTS rawHistory CASCADE;
	CREATE TABLE rawHistory(
		county varchar,
		id int,
		poll_date date,
		election_type varchar,
		vote char
		);
/*----------------------------Elections table--------------------------*/
	DROP TABLE IF EXISTS elections CASCADE;
	CREATE TABLE elections(
		 id SERIAL PRIMARY KEY,	 
		 poll_date date NOT NULL,
		 type varchar NOT NULL,
		 UNIQUE (poll_date,type)
		);
	CREATE INDEX ON elections (id, type);

/*----------------------------History table--------------------------*/

	DROP TABLE IF EXISTS history CASCADE;
	CREATE TABLE history (
		 id SERIAL,
		 voter_id int,
		 county varchar(3) NOT NULL,	
		 election_id int REFERENCES elections(id),
		 vote char NOT NULL,
		 PRIMARY KEY(id)
		);
	CREATE INDEX ON history (voter_id, election_id);
	CREATE INDEX ON history (voter_id, election_id, vote);

/*----------------------LOOKUP TABLES-----------------------------------*/
	DROP TABLE IF EXISTS party;
	CREATE TABLE party(
			name varchar(3) PRIMARY KEY,
			descr varchar
	);
	COPY party FROM '..\..\..\data\partylookup.tsv' DELIMITER E'\t';

	DROP TABLE IF EXISTS race;
	CREATE TABLE race(
		id int PRIMARY KEY,
		name VARCHAR
	);
	COPY race FROM '..\..\..\data\racelookup.tsv' DELIMITER E'\t';


	DROP TABLE IF EXISTS voteCodes;
	CREATE TABLE voteCodes (
		vcode CHAR PRIMARY KEY,
		descr VARCHAR
	);
	COPY votecodes FROM '..\..\..\data\votecodelookup.tsv' DELIMITER E'\t';