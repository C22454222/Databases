-- "BUILDER".apple_gains_2019 source

CREATE OR REPLACE VIEW "BUILDER".apple_gains_2019
AS SELECT count(*) AS "Num_Gain_Days"
   FROM stock_daily_gains
  WHERE "Stock"::text = 'AAPL'::text AND "GAIN" = 1 AND "Date"::text >= '2019-01-01'::text AND "Date"::text < '2020-01-01'::text;