/* ============================================================
   SWIGGY SQL DATA ANALYSIS
   01 - DATABASE & TABLE SETUP
   ============================================================ */

state VARCHAR(100),
    city VARCHAR(100),
    order_date DATE,
    week_no INT,
    quarter VARCHAR(10),
    day VARCHAR(15),
    restaurant_name VARCHAR(255),
    location VARCHAR(255),
    category VARCHAR(255),
    dish_name VARCHAR(255),
    food_type VARCHAR(20),
    price_inr DECIMAL(10,2),
    rating DECIMAL(3,2),
    rating_count INT
);

SHOW VARIABLES LIKE 'secure_file_priv';

SELECT *
FROM swiggy;

DESC swiggy;


/* ============================================================
   02. DATA LOADING
   ============================================================ */

-- Clear existing rows before reloading the raw CSV to avoid duplicate records.
TRUNCATE TABLE swiggy;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Swiggy Raw Data CSV.csv'
