INSERT INTO voters (id,gender,race)
SELECT DISTINCT voter_id, 'U', 0 FROM history WHERE voter_id NOT IN (SELECT id FROM voters)

UPDATE voters
SET isactive = true
WHERE id IN
(SELECT voter_id FROM registration WHERE status ='ACT')


