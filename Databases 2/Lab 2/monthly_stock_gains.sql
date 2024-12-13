-- "BUILDER".monthly_stock_gains source

CREATE OR REPLACE VIEW "BUILDER".monthly_stock_gains
AS WITH monthly_stock_prices AS (
         SELECT stocks."Stock",
            date_trunc('month'::text, stocks."Date"::date::timestamp with time zone) AS "Month",
            first_value(stocks."Close") OVER (PARTITION BY stocks."Stock", (date_trunc('month'::text, stocks."Date"::date::timestamp with time zone)) ORDER BY (stocks."Date"::date)) AS "First_Day_Close",
            last_value(stocks."Close") OVER (PARTITION BY stocks."Stock", (date_trunc('month'::text, stocks."Date"::date::timestamp with time zone)) ORDER BY (stocks."Date"::date)) AS "Last_Day_Close"
           FROM stocks
          WHERE stocks."Date"::date >= '2019-01-01'::date AND stocks."Date"::date < '2020-01-01'::date
        )
 SELECT "Stock",
    "Month",
    ("Last_Day_Close" - "First_Day_Close") / "First_Day_Close" * 100::double precision AS "Monthly_Gain_Percentage"
   FROM monthly_stock_prices;