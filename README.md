# 🍔 Swiggy Food Orders Analysis using MySQL

A complete SQL data analysis project built using the Swiggy Food Orders dataset. This project focuses on solving real business problems using SQL and demonstrates skills such as data exploration,
filtering, aggregation, views, stored procedures, window functions, subqueries, and string functions.

---

# 📌 Project Overview

This project analyzes 1,97,430 food orders from Swiggy to understand customer ordering patterns, restaurant performance, pricing trends, food preferences, and city-wise demand.

The analysis was performed completely in **MySQL Workbench** using SQL queries.

---

# 🎯 Objectives

The main objectives of this project are:

- Explore and understand the dataset
- Perform data quality checks
- Analyze restaurant and city performance
- Compare Veg and Non-Veg dishes
- Study pricing and rating trends
- Analyze orders by day, week, month, and quarter
- Practice SQL using real business scenarios

---

# 🛠️ Tools Used

| Tool | Purpose |
|------|---------|
| MySQL Workbench | SQL Analysis |
| SQL | Data Exploration & Business Analysis |
| Git | Version Control |
| GitHub | Project Hosting |

---

# 📊 Dataset Information

| Property | Value |
|----------|--------|
| Dataset | Swiggy Food Orders |
| Total Records | 197,430 |
| Total Cities | 28 |
| Total States | 28 |
| Total Restaurants | 993 |
| Unique Dishes | 59,064 |
| Columns | 14 |

---

# 🗂️ Database Schema

The dataset contains the following columns:

- State
- City
- Order Date
- Week Number
- Quarter
- Day
- Restaurant Name
- Location
- Category
- Dish Name
- Food Type
- Price (INR)
- Rating
- Rating Count

---

# 📚 SQL Concepts Used

This project includes the following SQL concepts:

- CREATE DATABASE
- CREATE TABLE
- LOAD DATA INFILE
- SELECT
- WHERE
- ORDER BY
- GROUP BY
- HAVING
- Aggregate Functions
- CASE WHEN
- Date Functions
- String Functions
- Window Functions
- Subqueries
- Views
- Stored Procedures

---

# 📈 Business Questions Solved

Some of the business questions answered in this project include:

- How many orders are available in the dataset?
- Which city has the most restaurants?
- Which state generates the highest number of orders?
- Which dishes are the most expensive?
- Which dishes have the highest ratings?
- What is the average dish price?
- Which cities have the highest average dish price?
- How do Veg and Non-Veg dishes compare?
- Which day receives the highest number of orders?
- How do weekday and weekend orders compare?
- Which quarter has the highest number of orders?
- Which restaurants have the largest menu?
- Which dishes have no customer ratings?
- Which food categories are the most popular?

---

# 💡 Key Insights

- The dataset contains **1,97,430** food orders from **993 restaurants** across **28 cities**.
- No missing values were found in the dataset.
- Veg dishes make up the majority of the menu.
- Mid-range priced dishes are the most common.
- Saturday records the highest number of orders.
- Q2 has the highest number of total orders.
- Panaji and Lucknow have the highest average dish prices.
- Most dishes have very few customer ratings.
- Bengaluru has the largest number of restaurants.

---

# 👨‍💻 Advanced SQL Features

This project also demonstrates:

### Views

- **vw_city_summary**
  - City-wise summary including total orders, average price, and average rating.

- **vw_top_rated_dishes**
  - Displays dishes with high ratings and sufficient customer reviews.

---

### Stored Procedures

**GetTopDishes()**

Returns the top N dishes for a selected city.

**CityReport()**

Generates a summary report for any city including:

- Total Orders
- Restaurants
- Average Price
- Average Rating

---

# 📁 Project Structure

```

Swiggy-SQL-Data-Analysis-using-MySQL
│
├── Dataset
│   ├── Swiggy Raw Data CSV.csv
│   └── Swiggy-SQL-Data-Analysis-using-MySQL.sql
│
├── Images
│   ├── I-1.png
│   ├── I-2.png
│   ├── I-3.png
│   ├── I-4.png
│   ├── I-5.png
│   ├── I-6.png
│   ├── I-7.png
│   ├── I-8.png
│   ├── I-9.png
│   ├── I-10.png
│   └── I-11.png
│
└── README.md
```

# 💼 Skills Demonstrated

- SQL
- MySQL
- Data Cleaning
- Exploratory Data Analysis (EDA)
- Data Aggregation
- Business Analysis
- Window Functions
- Views
- Stored Procedures
- Query Optimization
- Problem Solving

---

# 🚀 Future Improvements

- Build an interactive Power BI dashboard.
- Add more advanced SQL queries.
- Optimize complex queries.
- Create additional views and stored procedures.
- Perform customer segmentation.

---

# 👨‍💻 Author

**Karan Singh**

## ⭐ If you found this project useful, consider giving it a star!
