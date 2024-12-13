-- "BUILDER".top_gainer_2019 source

CREATE OR REPLACE VIEW "BUILDER".top_gainer_2019
AS WITH stock_gains AS (
         SELECT stocks."Stock",
            (stocks."Close" - lag(stocks."Close") OVER (PARTITION BY stocks."Stock" ORDER BY stocks."Date")) / lag(stocks."Close") OVER (PARTITION BY stocks."Stock" ORDER BY stocks."Date") * 100::double precision AS "Gain_Percentage"
           FROM stocks
          WHERE stocks."Date"::text >= '2019-01-01'::text AND stocks."Date"::text < '2020-01-01'::text
        )
 SELECT "Stock",
    max("Gain_Percentage") AS "Max_Gain_Percentage"
   FROM stock_gains
  GROUP BY "Stock"
  ORDER BY (max("Gain_Percentage")) DESC
 LIMIT 1;