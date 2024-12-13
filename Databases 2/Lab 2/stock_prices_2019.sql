-- "BUILDER".stock_prices_2019 source

CREATE OR REPLACE VIEW "BUILDER".stock_prices_2019
AS SELECT "Stock",
    min("Close") FILTER (WHERE "Date"::text >= '2019-01-01'::text AND "Date"::text < '2020-01-01'::text) AS "Min_Price_2019",
    max("Close") FILTER (WHERE "Date"::text >= '2019-01-01'::text AND "Date"::text < '2020-01-01'::text) AS "Max_Price_2019"
   FROM stocks
  GROUP BY "Stock";