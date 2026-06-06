# Ingredient Stock Analysis with BigQuery

## Project Overview

This project analyzes inventory movements and spending patterns for sandwich ingredients using Google BigQuery. The dataset tracks ingredient purchases (`stock_in`) and usage (`stock_out`) over time.

The objective is to answer key business questions related to inventory management, purchasing costs, and ingredient consumption trends.

---

## Dataset

**Table:**
`advanced-analytics-eenn-feb.sandwich_data.ingredients_stock`

### Key Fields

| Column         | Description                                  |
| -------------- | -------------------------------------------- |
| ingredient     | Ingredient name                              |
| stock_movement | Type of movement (`stock_in` or `stock_out`) |
| total_value    | Monetary value of stock movement             |
| packs          | Number of packs moved                        |
| month          | Transaction month                            |

---

## Business Questions Answered

### 1. Explore Inventory Data

Retrieve all records from the inventory table.

```sql
SELECT *
FROM `advanced-analytics-eenn-feb.sandwich_data.ingredients_stock`
```

**Purpose:** Understand dataset structure and available fields.

---

### 2. Which Ingredient Has the Highest Purchase Cost?

Calculate total spending per ingredient based on stock purchases.

```sql
SELECT ingredient,
       SUM(total_value) AS total_value
FROM `advanced-analytics-eenn-feb.sandwich_data.ingredients_stock`
WHERE stock_movement = "stock_in"
GROUP BY ingredient
ORDER BY total_value DESC
```

**Insight:** Identifies ingredients that represent the largest purchasing expense.

---

### 3. Monthly Purchase Spending by Ingredient

Analyze monthly spending trends for purchased ingredients.

```sql
SELECT ingredient,
       month,
       SUM(total_value) AS total_value
FROM `advanced-analytics-eenn-feb.sandwich_data.ingredients_stock`
WHERE stock_movement = "stock_in"
GROUP BY ingredient, month
ORDER BY total_value DESC
```

**Insight:** Helps identify seasonal purchasing patterns and spending fluctuations.

---

### 4. Total Inventory Value by Ingredient and Month

View inventory value movements across all transaction types.

```sql
SELECT ingredient,
       month,
       SUM(total_value) AS total_value
FROM `advanced-analytics-eenn-feb.sandwich_data.ingredients_stock`
GROUP BY ingredient, month
ORDER BY total_value DESC
```

**Insight:** Provides a complete picture of inventory value changes over time.

---

### 5. Monthly Pack Volume Analysis

Calculate pack quantities by ingredient and month.

```sql
SELECT ingredient,
       month,
       SUM(packs) AS total_packs
FROM `advanced-analytics-eenn-feb.sandwich_data.ingredients_stock`
GROUP BY ingredient, month, packs
ORDER BY packs DESC
```

**Insight:** Measures inventory movement volume and ingredient demand.

---

### 6. Average Monthly Packs Used for the Most Expensive Ingredient

First identify the ingredient with the highest purchasing cost, then calculate its average monthly consumption.

```sql
WITH most_spend AS (
    SELECT ingredient,
           SUM(total_value) AS total_value
    FROM `advanced-analytics-eenn-feb.sandwich_data.ingredients_stock`
    WHERE stock_movement = "stock_in"
    GROUP BY ingredient
    ORDER BY total_value DESC
    LIMIT 1
)

SELECT AVG(packs) AS avg_monthly_spent_in_packs
FROM `advanced-analytics-eenn-feb.sandwich_data.ingredients_stock` AS ma
JOIN most_spend AS ms
    ON ma.ingredient = ms.ingredient
WHERE stock_movement = "stock_out"
GROUP BY ma.ingredient
```

**Insight:** Determines average consumption levels of the highest-cost ingredient.

---

### 7. Average Inventory Spending

Calculate average spending value for ingredients leaving inventory.

```sql
SELECT AVG(total_value) AS average_spent
FROM `advanced-analytics-eenn-feb.sandwich_data.ingredients_stock`
WHERE stock_movement = "stock_out"
```

**Insight:** Measures average cost associated with ingredient usage.

---

## Skills Demonstrated

* SQL Querying
* Google BigQuery
* Aggregate Functions

  * SUM()
  * AVG()
* Common Table Expressions (CTEs)
* Filtering with WHERE
* GROUP BY Analysis
* Sorting and Ranking
* Inventory Analytics
* Business Intelligence Reporting

---

## Business Value

This analysis helps businesses:

* Monitor ingredient purchasing costs.
* Identify high-cost ingredients.
* Track monthly spending trends.
* Measure inventory consumption.
* Improve purchasing decisions.
* Optimize stock management processes.

---

## Tools Used

* Google BigQuery
* SQL
* GitHub

---

## Author

Data Analyst Portfolio Project demonstrating inventory analysis, cost tracking, and business intelligence reporting using SQL and BigQuery.

