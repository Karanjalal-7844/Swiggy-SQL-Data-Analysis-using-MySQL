/* ============================================================
   SWIGGY SQL DATA ANALYSIS
   02 - DATA LOADING
   ============================================================ */

USE swiggy;

INTO TABLE swiggy
CHARACTER SET latin1
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(
    state,
    city,
    @order_date,
    week_no,
    quarter,
    day,
    restaurant_name,
    location,
    category,
    dish_name,
    food_type,
    price_inr,
    rating,
    rating_count
)
SET order_date = STR_TO_DATE(@order_date, '%d-%m-%Y');

SELECT *
FROM swiggy;

-- Understanding Dataset
select * from swiggy limit 10;
/* Insight: Dataset contains food orders across multiple cities with pricing, ratings, and category details per dish. */

-- Total Rows in Dataset
select count(*) as total_rows from swiggy;
/* Insight: 1,97,430 rows — a large enough dataset for meaningful business analysis across cities and categories. */
