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