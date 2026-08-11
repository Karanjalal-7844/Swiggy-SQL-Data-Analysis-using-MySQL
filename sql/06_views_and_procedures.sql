/* ============================================================
   SWIGGY SQL DATA ANALYSIS
   06 - VIEWS & STORED PROCEDURES
   ============================================================ */

USE swiggy;

SELECT
    city,
    COUNT(*) AS total_orders,
    COUNT(DISTINCT restaurant_name) AS total_restaurants,
    ROUND(AVG(price_inr), 2) AS avg_price,
    ROUND(AVG(rating), 2) AS avg_rating
FROM swiggy
GROUP BY city;

SELECT *
FROM vw_city_summary
ORDER BY total_orders DESC;

/* Insight:
   The city summary view provides reusable city-level performance
   metrics without repeating the aggregation logic. */


-- Top-rated dishes view.
DROP VIEW IF EXISTS vw_top_rated_dishes;

CREATE VIEW vw_top_rated_dishes AS
SELECT
    city,
    restaurant_name,
    dish_name,
    food_type,
    price_inr,
    rating,
    rating_count
FROM swiggy
WHERE rating > 4.5
  AND rating_count >= 100;

SELECT *
FROM vw_top_rated_dishes
ORDER BY rating DESC, rating_count DESC;

/* Insight:
   This curated view provides a reusable list of highly rated dishes
   with meaningful review volume. */


-- Stored procedure for retrieving top dishes for any city.
DROP PROCEDURE IF EXISTS GetTopDishes;

DELIMITER //

CREATE PROCEDURE GetTopDishes(
    IN city_name VARCHAR(100),
    IN top_n INT
)
BEGIN
    SELECT
        dish_name,
        food_type,
        COUNT(*) AS order_count,
        ROUND(AVG(price_inr), 2) AS avg_price,
        ROUND(AVG(rating), 2) AS avg_rating
    FROM swiggy
    WHERE city = city_name
    GROUP BY dish_name, food_type
    ORDER BY order_count DESC
    LIMIT top_n;
END //

DELIMITER ;

CALL GetTopDishes('Bengaluru', 10);
CALL GetTopDishes('Mumbai', 5);
CALL GetTopDishes('Hyderabad', 3);

/* Insight:
   A parameterized procedure eliminates repetitive SQL when the same
   top-dish analysis is required for different cities. */


-- Stored procedure for a city-level report.
DROP PROCEDURE IF EXISTS CityReport;

DELIMITER //

CREATE PROCEDURE CityReport(
    IN city_name VARCHAR(100)
)
BEGIN
    SELECT
        city,
        COUNT(*) AS total_orders,
        COUNT(DISTINCT restaurant_name) AS total_restaurants,
        ROUND(AVG(price_inr), 2) AS avg_price,
        ROUND(AVG(rating), 2) AS avg_rating
    FROM swiggy
    WHERE city = city_name
    GROUP BY city;
END //

DELIMITER ;

CALL CityReport('Bengaluru');
CALL CityReport('Mumbai');

/* Insight:
   A parameterized city report provides a reusable way to retrieve
   core performance metrics for any selected city. */


/* ============================================================
   END OF SWIGGY SQL DATA ANALYSIS
   ============================================================ */
