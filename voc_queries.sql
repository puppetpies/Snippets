CREATE VIEW v_craftsmen AS (SELECT v.*, c.onboard_at_departure, c.death_at_cape, c.left_at_cape, c.onboard_at_cape, c.death_during_voyage, c.onboard_at_arrival 
FROM voyages v 
JOIN craftsmen c ON (v.number = c.number));


CREATE VIEW v_invoices AS (SELECT v.*, i.invoice 
FROM voyages v 
JOIN invoices i ON (v.number = i.number));

SELECT *
FROM voyages v 
JOIN seafarers sea ON (v.number = sea.number)
LIMIT 30;

SELECT *
FROM voyages v 
JOIN soldiers s ON (v.number = s.number)
LIMIT 30;

SELECT *
FROM voyages v 
JOIN passengers p ON (v.number = p.number)
LIMIT 30;


SELECT *
FROM voyages v 
JOIN total t on (v.number = t.number)
LIMIT 30;

SELECT * 
FROM voyages v 
JOIN impotenten imp ON (v.number = imp.number)
LIMIT 30;
