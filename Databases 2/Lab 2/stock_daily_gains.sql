-- "BUILDER".stock_daily_gains source

CREATE OR REPLACE VIEW "BUILDER".stock_daily_gains
AS SELECT "Date",
    "Stock",
        CASE
            WHEN "Close" > lag("Close") OVER (PARTITION BY "Stock" ORDER BY "Date") THEN 1
            WHEN "Close" < lag("Close") OVER (PARTITION BY "Stock" ORDER BY "Date") THEN 0
            ELSE NULL::integer
        END AS "GAIN"
   FROM stocks
  WHERE "Date"::text >= '2019-01-01'::text AND "Date"::text < '2020-01-01'::text;