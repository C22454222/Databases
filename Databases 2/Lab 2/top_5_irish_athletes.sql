-- "BUILDER".top_5_irish_athletes source

CREATE OR REPLACE VIEW "BUILDER".top_5_irish_athletes
AS ( SELECT paris."da e",
    paris.event_name,
    paris.gender,
    paris.discipline_name,
    paris.participant_name,
    paris.participant_type,
    paris.participant_country_code,
    paris.participant_country,
    paris.result,
    paris.result_type
   FROM paris
  WHERE paris.participant_country_code::text = 'IRL'::text AND paris.result_type::text = 'DISTANCE'::text
  ORDER BY paris.result
 LIMIT 5)
UNION ALL
( SELECT paris."da e",
    paris.event_name,
    paris.gender,
    paris.discipline_name,
    paris.participant_name,
    paris.participant_type,
    paris.participant_country_code,
    paris.participant_country,
    paris.result,
    paris.result_type
   FROM paris
  WHERE paris.participant_country_code::text = 'IRL'::text AND paris.result_type::text = 'TIME'::text
  ORDER BY paris.result DESC
 LIMIT 5);