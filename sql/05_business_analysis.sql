/* ============================================================
   SWIGGY SQL DATA ANALYSIS
   05 - BUSINESS ANALYSIS
   ============================================================ */

USE swiggy;

select city, restaurant_name, dish_name ,food_type, price_inr , rating
from swiggy where food_type = "Non-Veg" and price_inr Between 200 and 400;
/* Insight: This mid-range band is the sweet spot for Non-Veg — affordable enough for daily orders yet profitable for restaurants. */

-- Find all orders from Mumbai, New Delhi, or Kolkata only.
select restaurant_name , dish_name , city , price_inr
from swiggy where city in ("Mumbai","New Delhi","Kolkata") order by city asc;
/* Insight: These 3 metros represent india's commercial, political, and cultural capitals — together they reveal regional cuisine preferences. */

-- Find all dishes that are NOT Veg and have a rating above 4.5.
select city,restaurant_name,dish_name,food_type,price_inr,rating
from swiggy where food_type !=  "Veg" and rating > 4.5 order by rating desc;
/* Insight: Highly rated Non-Veg dishes signal quality leaders — restaurants serving these are strong candidates for "best in city" analysis. */

-- Find all dishes where rating count is 0 (completely unrated) but price is above 2000
select city,restaurant_name,dish_name,food_type,price_inr,rating,rating_count
from swiggy where rating_count = 0 and price_inr > 2000 order by price_inr desc;
/* Insight: Premium dishes with zero ratings are a business blind spot — restaurants need reviews to justify high prices to new customers. */

--  Find the Top 10 most expensive dishes in the entire dataset.
select city,restaurant_name,dish_name,food_type,price_inr,rating
from swiggy order by price_inr desc limit 10;
/* Insight: Most top-priced items are bulk/party packs — confirms that high price outliers are not regular menu items but event-based orders. */

-- Find the Top 10 highest rated dishes with rating count more than 100
select city,restaurant_name,dish_name,food_type,price_inr,rating ,rating_count
from swiggy where rating_count >= 100
order by rating desc, rating_count desc limit 10;
/* Insight: Dishes with 100+ ratings and high scores are proven bestsellers — these are the menu items restaurants should promote most aggressively. */

-- Which city has the most restaurants? Show top 5.
select city , count(distinct restaurant_name) as "Total Restaurants"
from swiggy group by city order by total_restaurants desc limit 5;
/* Insight: Bengaluru leads comfortably — as Swiggy's home city it has the deepest restaurant network, followed by other Tier-1 metros. */

-- Find all dishes where the dish name contains the word 'Biryani' 
select city,restaurant_name,dish_name,food_type,price_inr,rating
from swiggy where dish_name like '%Biryani%'
order by price_inr desc;
/* Insight: Biryani has the widest dish name presence across the platform — it is clearly the single most popular food category on Swiggy in india. */

--  Find all restaurants whose name starts with 'The'
select distinct restaurant_name,city from swiggy where restaurant_name like "The %" order by restaurant_name;
/* Insight: 'The' prefix is a common branding choice for premium/themed restaurants — signals an attempt to stand out with a formal identity. */

-- Show each dish name in UPPERcase, its length, and the first 15 characters only 
select dish_name , upper(dish_name) AS upper_name , length(dish_name) AS name_length , left(dish_name,15) AS short_name 
from swiggy limit 20;
/* Insight: Dish name lengths vary wildly — short names (Dosa, Roti) vs long descriptive names. Long names often signal fusion or specialty dishes. */

-- How many categories have extra spaces 
select 
distinct category AS original_category,
length(category) AS length_before_trim,
trim(category) AS trimmed_category,
length(trim(category)) AS length_after_trim
from swiggy
where length(category) <> length(trim(category));

-- count how many rows are affected
select count(*) AS category_with_extra_spaces
from swiggy
where LENGTH(category) != LENGTH(TRIM(category));
/* Insight: Hidden whitespace causes group by to treat identical categories as different — this silently inflates category counts in all analyses. */

-- Spelling Diffrence can make diffrent categories 
select distinct category
from swiggy
where category REGEXP "Biryani|Biriyani|Biryanis|Biryani's"   -- Biryani's ( last one )
order by category;
/* Insight: At least 3–4 spelling variants exist for Biryani alone — proof that category standardization is critical before any category-level analysis. */

-- Show dish name with the 'Biriyani' word replaced by 'Biryani' using REPLACE() 
select dish_name , replace(dish_name,'Biriyani','Biryani') from swiggy
where dish_name like "%Biriyani%";
/* Insight: 'Biriyani' is a common misspelling of 'Biryani' — REPLACE() can bulk-fix these without touching the original data. */

-- Longest city name and Shortest city name using order by
select distinct city, length(city) as name_length
from swiggy order by name_length desc limit 1;

-- Shortest city name
select distinct city, length(city) as name_length
from swiggy order by name_length asc limit 1;
/* Insight: A fun but useful check — longer city names can cause display issues in dashboards and need trimming in reporting layers. */

-- *****************************************************************************************************************************************************
-- *****************************************************************************************************************************************************

-- Find the total number of orders, average price, and average rating for each city. order by average price descending.
select city,count(*) as total_orders, round(avg(price_inr), 2)    as avg_price from swiggy group by city order by avg_price desc;
/* Insight: Panaji (Goa) leads with highest avg price (₹306), followed by Lucknow (₹305) — surprisingly NOT Bengaluru or Mumbai. Smaller cities with premium restaurant mix can outrank metros in avg spend per order.. */

-- Find the total orders and average price per food type (Veg / Non-Veg). Which is more expensive on average?
select food_type,count(*) as total_orders,round(avg(price_inr), 2) as avg_price,round(min(price_inr), 2) as min_price,round(max(price_inr), 2) as max_price
 from swiggy group by food_type;
/* Insight: Non-Veg dishes tend to be pricier on average — meat ingredients drive up cost, making Non-Veg a higher revenue-per-order segment. */

-- Which state generates the most orders? Show all states with their order count and average dish price.
select state, count(*) as total_orders, round(avg(price_inr), 2) as avg_price from swiggy group by state order by total_orders desc;
/* Insight: Karnataka leads with 20,077 orders — but only ~2x ahead of Maharashtra and Telangana (~10,000 each), showing demand is more distributed across states than expected.. */

-- Find all cities where the average dish price is >300. This is the having clause — filtering on aggregated values.
select city, round(avg(price_inr), 2) as avg_price, count(*) as total_orders 
from swiggy group by city having avg_price > 300 order by avg_price desc;
/* Insight: Only 2 cities clear the ₹300 avg price mark — Panaji (₹306) and Lucknow (₹305). Most indian cities including metros like Mumbai and Delhi fall below ₹300 avg,
 showing price sensitivity across the platform.*/

-- Find restaurants that have more than 50 dishes on their menu. Show restaurant name, city, and dish count.
select restaurant_name,city,count(distinct dish_name) as total_dishes 
from swiggy group by restaurant_name, city 
having total_dishes > 50 order by total_dishes desc;
/* Insight: Restaurants with 50+ dishes are large chains or multi-cuisine places — large menus attract more customers but can  dilute quality focus. */

-- Find the most expensive dish per city — the single highest priced item in each city.
select city, max(price_inr) as max_dish_price from swiggy group by city order by max_dish_price desc;
/* Insight: The max price per city reveals premium outliers — bulk orders and catering menus heavily influence the ceiling in metro cities. */

-- Find cities where the total number of Veg dishes is greater than Non-Veg dishes.
select city, sum(case when food_type = 'Veg'     then 1 else 0 end) as veg_count, sum(case when food_type = 'Non-Veg' then 1 else 0 end) as nonveg_count
from swiggy group by city having veg_count > nonveg_count order by veg_count desc;
/* Insight: ALL 28 cities have more Veg listings than Non-Veg — without exception. Bengaluru leads with 14,481 Veg vs 5,596 Non-Veg dishes, confirming Veg dominance is a platform-wide pattern, not regional. */


-- Find the average rating per city but only include cities that have at least 1000 orders and an average rating above 3.8.
select city,count(*) as total_orders,round(avg(rating), 2) as avg_rating from swiggy group by city having total_orders >= 1000 and avg_rating > 3.8 order by avg_rating desc;
/* Insight: ALL 28 cities pass both thresholds (1000+ orders, rating > 3.8) — showing consistently high quality across the platform. Kochi leads with the highest avg rating (4.44), followed by Aizawl and Kolkata (4.41). */


-- Extract the year, month number, month name, and day name from the order date. Show first 10 rows.
select order_date,year(order_date) as Year , month(order_date) as Month , monthname(order_date) as Month_Name , day(order_date) as Day , 
dayname(order_date) as Day_Name , weekofyear(order_date) as week_of_year from swiggy limit 10;
/* Insight: Breaking dates into components enables powerful time-series analysis — month and week trends are critical for demand forecasting. */

-- Find the total orders per month 
select month(order_date) as Month , monthname(order_date) as Month_Name , count(*) as total_orders from swiggy group by Month , Month_Name order by Month;
/* Insight: January leads with 25,398 orders, followed closely by August (25,231) and May (25,190). Orders are remarkably consistent month-on-month with no dramatic seasonal spike — demand is steady year-round.*/

-- Find total orders per week number. Which week had the most orders?
select week_no,count(*) as total_orders from swiggy group by week_no order by total_orders desc;
/* Insight: Identifying peak weeks helps restaurants prepare stock and Swiggy to plan delivery partner availability in advance. */

-- Find the total orders and average price per quarter, and calculate which quarter has the highest avg price.
select quarter as Quarter, count(*) as total_orders , round(avg(price_inr),2) as avg_Price , round(max(price_inr),2) as Max_Price , round(min(price_inr),2) as Min_Price 
from swiggy group by Quarter order by avg_Price desc;
/* Insight: Q1 has the highest avg price (₹269.07) but Q2 has the most orders (74,163). The avg price difference across quarters is very small (< ₹2) — pricing is stable, volume is what shifts by quarter. */

-- How many orders were placed on weekends (Saturday + Sunday) vs weekdays? Show count and percentage.
select
case when day in ("Sat","Sun") then "Weekend" else "Weekday" end as Day_Type, 
count(*) AS total_orders, concat(round(count(*) * 100.0 / sum(count(*)) over(),2)," %") as Percentage
from swiggy group by day_type;
/* Insight:  Weekdays account for 70.92% of orders (1,40,018) vs weekends at only 29.08% (57,412) — OPPOSITE of what was assumed. Swiggy's core audience is actually need/habit 
driven on weekdays, not just leisure weekend ordering. Weekdays = 5 days, weekends = 2 days, yet weekdays dominate even proportionally (~14% per day vs ~14.5% per day — nearly equal) */

-- *****************************************************************************************************************************************************
-- *****************************************************************************************************************************************************


/* ============================================================
   ADDITIONAL BUSINESS ANALYSIS
   Added from the extended Swiggy Analysis script
   ============================================================ */

-- Find the busiest day of the week per city.
SELECT
    city AS City,
    day AS Day,
    COUNT(*) AS total_orders
FROM swiggy
GROUP BY city, day
ORDER BY City, total_orders DESC;

/* Insight:
   This output allows each city's ordering pattern to be reviewed
   by day of the week. */

-- Find the date with the single highest number of orders.
SELECT
    order_date,
    DAY(order_date) AS day,
    DAYNAME(order_date) AS day_name,
    MONTH(order_date) AS month,
    MONTHNAME(order_date) AS month_name,
    COUNT(*) AS total_orders
FROM swiggy
GROUP BY order_date
ORDER BY total_orders DESC
LIMIT 1;

/* Insight:
   The busiest date identifies demand spikes that can be investigated
   against promotions, holidays, weekends, or other events. */

-- Create a price category label for every dish.
SELECT
    dish_name,
    price_inr,
    food_type,
    city,
    CASE
        WHEN price_inr < 150 THEN 'Budget'
        WHEN price_inr BETWEEN 150 AND 400 THEN 'Mid-Range'
        WHEN price_inr BETWEEN 401 AND 800 THEN 'Premium'
        ELSE 'Luxury'
    END AS price_category
FROM swiggy
LIMIT 20;

/* Insight:
   Price bands provide a simple way to understand the positioning
   of dishes across the platform. */

-- Count how many dishes fall into each price category.
SELECT
    CASE
        WHEN price_inr < 150 THEN 'Budget'
        WHEN price_inr BETWEEN 150 AND 400 THEN 'Mid-Range'
        WHEN price_inr BETWEEN 401 AND 800 THEN 'Premium'
        ELSE 'Luxury'
    END AS price_category,
    COUNT(*) AS total_dishes,
    CONCAT(
        ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 2),
        ' %'
    ) AS percentage
FROM swiggy
GROUP BY price_category
ORDER BY total_dishes DESC;

/* Insight:
   Price-category distribution shows whether the menu is primarily
   positioned toward budget, mid-range, premium, or luxury customers. */

-- Create a restaurant performance label based on average rating.
SELECT
    restaurant_name,
    city,
    ROUND(AVG(rating), 2) AS avg_rating,
    SUM(rating_count) AS total_reviews,
    CASE
        WHEN AVG(rating) < 3.5 THEN 'Poor'
        WHEN AVG(rating) < 4.0 THEN 'Average'
        WHEN AVG(rating) < 4.5 THEN 'Good'
        ELSE 'Excellent'
    END AS performance_label
FROM swiggy
GROUP BY restaurant_name, city
HAVING SUM(rating_count) >= 50
ORDER BY avg_rating DESC;

/* Insight:
   Restaurant performance labels make it easier to compare restaurants
   after applying a minimum review-volume threshold. */

-- Segment orders by weekday/weekend and food type.
SELECT
    CONCAT(
        CASE
            WHEN day IN ('Sat', 'Sun') THEN 'Weekend'
            ELSE 'Weekday'
        END,
        ' | ',
        food_type
    ) AS order_segment,
    COUNT(*) AS total_orders,
    ROUND(AVG(price_inr), 2) AS avg_price
FROM swiggy
GROUP BY order_segment
ORDER BY total_orders DESC;

/* Insight:
   Combining day type with food type highlights the largest ordering
   segments and their average prices. */

-- Find dishes priced above the overall average price.
SELECT
    dish_name,
    price_inr,
    food_type,
    city
FROM swiggy
WHERE price_inr > (
    SELECT AVG(price_inr)
    FROM swiggy
)
ORDER BY price_inr DESC;

/* Insight:
   Comparing individual dish prices against the platform-wide average
   identifies above-average priced menu items. */




