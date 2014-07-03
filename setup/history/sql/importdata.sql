SET CLIENT_ENCODING TO UTF8;
SET STANDARD_CONFORMING_STRINGS TO ON;

DROP TABLE IF EXISTS temphist;

CREATE TABLE temphist (
	county varchar,
	id int,
	poll_date date,
	election_type varchar,
	vote char
	);

COPY temphist FROM :file DELIMITER E'\t';

COPY rawhistory FROM :file DELIMITER E'\t';


INSERT INTO elections (poll_date,type)
SELECT 
	DISTINCT poll_date, election_type
FROM temphist
WHERE NOT EXISTS (SELECT * FROM elections e WHERE e.poll_date = temphist.poll_date AND e.type = temphist.election_type);

INSERT INTO history
(voter_id, county,election_id, vote)
SELECT 
	id,
	county,
	(SELECT id from elections e WHERE e.poll_date = temphist.poll_date AND e.type = temphist.election_type),
	vote
FROM temphist;
