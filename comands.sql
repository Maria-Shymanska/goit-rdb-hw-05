
-- 1: Використовує підзапит у SELECT для вибору customer_id з таблиці orders для кожного запису з таблиці order_details.
SELECT 
    od.*, 
    (SELECT o.customer_id FROM orders o WHERE o.id = od.order_id) AS customer_id
FROM order_details od;

--2: Використовує вкладений запит у операторі WHERE для фільтрації записів за shipper_id = 3 з таблиці orders.
SELECT * 
FROM order_details od
WHERE od.order_id IN (
    SELECT o.id 
    FROM orders o
    WHERE o.shipper_id = 3
);

--3: Використовує вкладений запит у операторі FROM для вибору рядків з order_details, де quantity > 10, і обчислення середнього значення quantity, групуючи за order_id.
SELECT 
    avg(od.quantity) AS average_quantity
FROM 
    (SELECT quantity, order_id 
     FROM order_details 
     WHERE quantity > 10) AS od
GROUP BY od.order_id;

--4: Використовує WITH для створення тимчасової таблиці temp, що дозволяє обчислити середнє значення quantity для рядків з order_details, де quantity > 10.
WITH temp AS (
    SELECT order_id, quantity
    FROM order_details
    WHERE quantity > 10
)
SELECT order_id, AVG(quantity) AS avg_quantity
FROM temp
GROUP BY order_id;

--5: Створює функцію для ділення двох значень типу FLOAT і використовує її для обчислення результату ділення поля quantity на число 10.
-- Створення функції
DELIMITER $$

CREATE FUNCTION divide_floats(numerator FLOAT, denominator FLOAT)
RETURNS FLOAT
DETERMINISTIC
NO SQL
BEGIN
    RETURN numerator / denominator;
END$$

DELIMITER ;

SELECT divide_floats(quantity, 10) AS quantity_divided
FROM order_details;


-- DROP FUNCTION IF EXISTS divide_floats;



