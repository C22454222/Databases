-- "BUILDER".medal_table source

CREATE OR REPLACE VIEW "BUILDER".medal_table
AS WITH event_rankings AS (
         SELECT paris.participant_name,
            paris.participant_country,
            paris.event_name,
            paris.result,
            paris.result_type,
            dense_rank() OVER (PARTITION BY paris.event_name ORDER BY (
                CASE
                    WHEN paris.result_type::text = 'TIME'::text THEN paris.result
                    WHEN paris.result_type::text = 'DISTANCE'::text THEN - paris.result
                    ELSE NULL::real
                END)) AS ranking
           FROM paris
        )
 SELECT participant_country,
    count(
        CASE
            WHEN ranking = 1 THEN 1
            ELSE NULL::integer
        END) AS gold,
    count(
        CASE
            WHEN ranking = 2 THEN 1
            ELSE NULL::integer
        END) AS silver,
    count(
        CASE
            WHEN ranking = 3 THEN 1
            ELSE NULL::integer
        END) AS bronze
   FROM event_rankings
  GROUP BY participant_country
  ORDER BY (count(
        CASE
            WHEN ranking = 1 THEN 1
            ELSE NULL::integer
        END)) DESC, (count(
        CASE
            WHEN ranking = 2 THEN 1
            ELSE NULL::integer
        END)) DESC, (count(
        CASE
            WHEN ranking = 3 THEN 1
            ELSE NULL::integer
        END)) DESC, participant_country;