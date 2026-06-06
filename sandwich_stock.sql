SELECT * FROM `advanced-analytics-eenn-feb.sandwich_data.ingredients_stock` 




SELECT ingredient, SUM(total_value) AS total_value
FROM `advanced-analytics-eenn-feb.sandwich_data.ingredients_stock` 
WHERE stock_movement = "stock_in"
GROUP BY ingredient
ORDER BY total_value DESC

SELECT ingredient, month, SUM(total_value) AS total_value
FROM `advanced-analytics-eenn-feb.sandwich_data.ingredients_stock` 
WHERE stock_movement = "stock_in"
GROUP BY ingredient, month
ORDER BY total_value DESC

SELECT ingredient, month, SUM(total_value) AS total_value
FROM `advanced-analytics-eenn-feb.sandwich_data.ingredients_stock` 
GROUP BY ingredient, month
ORDER BY total_value DESC


SELECT ingredient, month, SUM(packs) AS total_packs
FROM `advanced-analytics-eenn-feb.sandwich_data.ingredients_stock` 
GROUP BY ingredient,month, packs
ORDER BY packs DESC


----4. What’s an average monthly spent in packs of the ingredients that was used the most (in money value)?
-- ingredients_stock

WITH
  most_spend AS (
    SELECT ingredient, sum(total_value) AS total_value
    FROM `advanced-analytics-eenn-feb.sandwich_data.ingredients_stock` 
    WHERE stock_movement = "stock_in"
    GROUP BY
      ingredient
    ORDER BY total_value DESC
    LIMIT 1
  )
SELECT AVG(packs) AS avg_monthly_spent_in_packs
FROM `advanced-analytics-eenn-feb.sandwich_data.ingredients_stock`  AS ma
JOIN most_spend AS mrm
  ON ma.ingredient = mrm.ingredient
WHERE stock_movement = "stock_out"
GROUP BY ma.ingredient


SELECT AVG(total_value) AS average_spent
FROM `advanced-analytics-eenn-feb.sandwich_data.ingredients_stock`
WHERE stock_movement = "stock_out"
