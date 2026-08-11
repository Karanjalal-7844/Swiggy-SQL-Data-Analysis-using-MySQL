/* ============================================================
   SWIGGY SQL DATA ANALYSIS
   04 - EXPLORATORY DATA ANALYSIS
   ============================================================ */

USE swiggy;

-- Data Analysis
select 
count(distinct city) as total_cities,
count(distinct state) as total_states,
count(distinct restaurant_name) as total_restaurants,
count(distinct dish_name) as total_dishes,
count(distinct food_type) as food_type,
count(distinct category) as Category
from swiggy;
/* Insight: 993 restaurants across 28 cities offer 59,064 unique dishes,showing massive menu diversity on the platform. */

-- NUll Check
select 
sum(case when state is null then 1 else 0 end ) as null_state,
sum(case when city is null then 1 else 0 end ) as null_city,
sum(case when order_date is null then 1 else 0 end ) as null_date,
sum(case when week_no is null then 1 else 0 end ) as null_weekno,
sum(case when quarter is null then 1 else 0 end ) as null_quarter,
sum(case when day is null then 1 else 0 end ) as null_day,
sum(case when restaurant_name is null then 1 else 0 end ) as null_restaurant,
sum(case when location is null then 1 else 0 end ) as null_location,
sum(case when category is null then 1 else 0 end ) as null_category,
sum(case when dish_name is null then 1 else 0 end ) as null_dish,
sum(case when food_type is null then 1 else 0 end ) as null_food,
sum(case when price_inr is null then 1 else 0 end ) as null_price,
sum(case when Rating is null then 1 else 0 end ) as null_rating,
sum(case when rating_count is null then 1 else 0 end ) as null_ratingcount
from swiggy;
/* Insight: Zero nulls across all 14 columns — data is clean and ready for analysis without any imputation needed. */

-- maximum, minimum & Average Price of Dishes
select 
concat(max(price_inr)," /-") as maximum_price,
concat(round(min(price_inr),1)," /-") as minimum_price,
concat(round(avg(price_inr),2)," /-") as average_price
from swiggy;
/* Insight: Avg price ~₹268.51 with a wide range (₹0.95–₹8,000) — high-end outliers likely represent bulk/catering orders. */

-- minimum, maximum & Average Rating
select 
min(rating) as minimum_rating,
max(rating) as maximum_rating,
round(avg(rating),2) as average_rating,
sum(case when rating_count = 0 then 1 else 0 end) as unrated_dishes
from swiggy;
/* Insight: Avg rating of 4.34 is healthy across the platform. Unrated dishes suggest many new or low-traffic menu items that haven't received enough customer feedback yet. */

-- Rating count Distribution
select 
case when rating_count = 0 then "Unrated"
	 when rating_count Between 1 and 25 then "Low (1-25)"
	 when rating_count Between 26 and 100 then "Medium (26-100)"
	 else "High (100+)"
end as rating_window,
count(*) as "Total Dishes"
from swiggy group by rating_window order by total_dishes desc;
/*  Insight: Majority of dishes fall in the "Unrated" or "Low" bucket,meaning most dishes have very few customer reviews. */

-- Food Type Distribution
 select food_typeAS 'Food Type', count(*) AS total_orders,
concat(round(count(*) * 100.0 / sum( count(*) ) over() ,2)," %")AS 'Percentage Contribution'
from swiggy group by food_type;
/* Insight: Veg dishes dominate at ~71.5% (1,40,604 orders) vs Non-Veg at ~28.5% (56,826 orders) — 
reflecting india's strong vegetarian food culture. */

-- Dates Covered
select 
min(order_date) AS start_date , 
max(order_date) AS end_date , 
datediff(max(order_date),min(order_date)) +1 AS total_days_covered
from swiggy;

/* Insight: Data spans approx. 8–9 months (Q1–Q3), giving a good window to study seasonal and weekly ordering trends. */
-- Quarter wise Orders 
select quarter,count(*) AS total_orders from swiggy group by quarter order by total_ordersdesc;
/* --  Insight: Q2 leads in orders — April to June is peak season,possibly driven by summer holidays and IPL season. */

-- Day wise Orders
select day,count(*) AS total_orders from swiggy group by day order by total_ordersdesc;
/*  Insight: Saturday has the most orders (28,938), closely followed by Sunday (28,474) — weekends dominate but Thursday and Friday are surprisingly strong too. Tuesday is the slowest day, not Monday. */

-- Least Food Price
select restaurant_name, dish_name, price_inr, city from swiggy where price_inr < 10;
/* A small number of items priced below ₹10 are there (e.g. sauces, ketchup ) */

-- *****************************************************************************************************************************************************
-- *****************************************************************************************************************************************************

-- All dishes from Bengaluru with a price greater than 2000/-
select state,city,restaurant_name,dish_name,price_inr,rating
from swiggy 
where city = "Bengaluru" and price_inr >= 2000
order by price_inr desc;
/* Insight: Premium dishes (₹2000+) in Bengaluru are likely bulk platters or catering menus — Bengaluru's high-income tech workforce drives luxury orders. */
