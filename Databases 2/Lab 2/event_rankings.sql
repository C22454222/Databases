-- "BUILDER".event_rankings source

CREATE OR REPLACE VIEW "BUILDER".event_rankings
AS SELECT participant_name,
    event_name,
    result,
    dense_rank() OVER (PARTITION BY event_name ORDER BY (
        CASE
            WHEN result_type::text = 'TIME'::text THEN result::double precision
            WHEN result_type::text = 'DISTANCE'::text THEN result * '-1'::integer::double precision
            ELSE NULL::double precision
        END)) AS rank
   FROM paris;