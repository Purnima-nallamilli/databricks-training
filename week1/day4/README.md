# SQL Practice – CTEs & Window Functions

## Overview

This document summarizes my practice on **Common Table Expressions (CTEs)** and **Window Functions** in SQL. The focus was on writing efficient, readable queries for real-world analytical scenarios.

---

## Topics Covered

### 1. Common Table Expressions (CTEs)

* Created temporary result sets using `WITH`
* Improved query readability and structure
* Broke complex queries into smaller steps

### 2. Recursive CTEs

* Generated sequences (e.g., numbers 1 to 10)
* Built hierarchical queries (employee-manager relationships)

### 3. Aggregations with CTEs

* Calculated total sales per employee
* Computed customer total spending
* Compared values with company averages

### 4. Window Functions

* Used `RANK()`, `DENSE_RANK()`, and `MAX() OVER()`
* Performed partition-based calculations
* Found second-highest salaries per department
* Calculated differences within groups

### 5. Combining CTEs and Window Functions

* Ranked customers based on spending
* Identified top-performing employees per department
* Solved advanced analytical queries efficiently

---

## Key Learnings

* CTEs make complex SQL queries easier to understand and maintain
* Recursive CTEs are useful for hierarchical and iterative data
* Window functions allow advanced analytics without grouping data
* Combining CTEs and window functions is powerful for real-world problems

---

## Tools Used

* SQL (MySQL / PostgreSQL / SQL Server)

---

## Conclusion

This practice improved my ability to write structured, optimized SQL queries and strengthened my understanding of analytical problem-solving using CTEs and window functions.
