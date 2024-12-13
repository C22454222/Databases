CREATE OR REPLACE VIEW "BUILDER".woman_marathon_winner AS
WITH woman_marathon_winner AS (
    SELECT event_rankings_1.result
    FROM event_rankings event_rankings_1
    WHERE event_rankings_1.event_name::text = 'Women''s Marathon'::text
    ORDER BY event_rankings_1.result
    LIMIT 1
)
SELECT count(*) + 1 AS "position"
FROM event_rankings
WHERE event_name::text = 'Men''s Marathon'::text
AND result < (
    SELECT woman_marathon_winner.result
    FROM woman_marathon_winner
);
