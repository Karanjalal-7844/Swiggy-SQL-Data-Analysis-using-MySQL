/* ============================================================
   SWIGGY SQL DATA ANALYSIS
   03 - DATA QUALITY CHECKS
   ============================================================ */

USE swiggy;

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
