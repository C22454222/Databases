-- "BUILDER".stock_prices_with_moving_average source

CREATE OR REPLACE VIEW "BUILDER".stock_prices_with_moving_average
AS SELECT "Date",
    "Stock",
    "Close",
    avg("Close") OVER (PARTITION BY "Stock" ORDER BY "Date" ROWS 4 PRECEDING) AS "5_day_moving_average"
   FROM stocks;