
-- Queries 

-- Query_1: List all the customer’s names, dates, and services booked by these customers in a range of two dates
-- Question: Who are the customers that had their services fulfilled between 2020-06-06 and 2020-08-08? 

-- EXPLAIN
SELECT 
     c.customer_id,
     CONCAT(c.first_name ,' ',c.last_name) AS Customer_name,
     so.date_of_service,
     sv.service_type
FROM
     customer AS c
        INNER JOIN
     service_order as so  ON c.customer_id = so.customer_customer_id
		INNER JOIN 
	 service AS sv ON so.service_service_id = sv.service_id
WHERE so.date_of_service BETWEEN DATE_FORMAT("2020-06-06", "%Y-%m-%d") AND DATE_FORMAT("2020-08-08", "%Y-%m-%d") 
		AND so.fulfilled = 1
;

-- To optimize the last query we can set date_of_service column has our index.
-- After running, we could check that the code goes from 15 rows in service_order table to 5 rows which may lead to less time consuming. 
-- CREATE INDEX date_of_service ON service_order (date_of_service);
-- We checked the time consuming with EXPLAIN command in this query where we found really low time spent.
-- We decided not to write here in the comments the exact time spent, because every time we run the query it changes slightly the time, but it is always low time spent.

-- Query_2: List best three customers (Best customers are the ones that spent more money in our company)
-- Question: What are the top three customers who spent the most money with 24Fixed company?

-- EXPLAIN
SELECT 
    c.customer_id,
    CONCAT(c.first_name ,' ',c.last_name) AS Customer_name,
    ROUND(SUM(t.amount_in_eur),2) AS Total_amount
FROM
    customer AS c
        INNER JOIN
    service_order so ON c.customer_id = so.customer_customer_id
		INNER JOIN
	transactions t ON so.transactions_transaction_id =t.transaction_id
WHERE so.fulfilled = 1
GROUP BY c.customer_id
ORDER BY SUM(t.amount_in_eur) DESC
LIMIT 3
;
-- To optimize: We will not set fulfilled column as an Index, because this column has low cardinality (same for other queries).
-- With the EXPLAIN command, we looked at how long this query took and saw that it took incredibly little time.
-- Because the time varies slightly every time we run the query, we have chosen not to include the precise time spent here in the comments. However, the time spent is always minimal.

-- Query_3: Get average amount of sales for a period that is 2 or more years, should only return one row.
-- Question: What is the average amount of sales during the last two years including 2021?
-- The selected period is between the years of 2020 and 2021 (including)

-- EXPLAIN
SELECT 
	CONCAT('01/2020','-','12/2021') as PeriodOfSales,
	CONCAT(Sum(so.total_amount_eur),' €') as 'TotalSales (euros)',
    CONCAT(ROUND(SUM(so.total_amount_eur)/2,2),' €') AS 'YearlyAverage (2020-2021)',
    CONCAT(ROUND(SUM(so.total_amount_eur)/24,2),' €') AS 'MonthlyAverage (2020-2021)'
FROM
    service_order AS so 
    INNER JOIN 
    transactions as t on so.transactions_transaction_id = t.transaction_id
WHERE
    so.fulfilled = 1
    AND DATE_FORMAT(t.date_of_issue, "%Y %M") <= '2021-12' and DATE_FORMAT(t.date_of_issue, "%Y %M") >='2020-01'
;
-- To optimize: If we set date_of_issue has an Index, it does not bring necessarily less time consuming, also due to small dataset.
-- We could use BETWEEN operator inside where clause to filter date_of_issue of transactions table.
-- We checked at how long this query took using the EXPLAIN command and discovered that it took relatively little time.
-- We have decided not to mention the exact time spent here in the comments because it changes significantly every time we execute the query. However, there is never much time invested.

-- Query_4: Get the total sales by geographical location (city/country)
-- Question: What is the total sales per city?

-- EXPLAIN
SELECT 
    ct.city_name,
    SUM(so.total_amount_eur) AS Total_Amount
FROM
    service_order so
        INNER JOIN
    employee e ON so.employee_employee_id = e.employee_id
        INNER JOIN
    postal_region pr ON pr.region_id = e.postal_region_region_id
        INNER JOIN
    postal_code pc ON pc.postal_region_region_id  = pr.region_id
        INNER JOIN
    city ct ON ct.city_id = pc.city_city_id
WHERE
    so.fulfilled = 1
GROUP BY ct.city_name
ORDER BY ct.city_name DESC;

-- To optimize: As mentioned earlier, we will not set fulfilled column as an Index, because this column has low cardinality.
-- Using the EXPLAIN command, we looked at how long this query took and found that it did so very quickly.
-- Because it varies so much every time we run the query, we have chosen not to specify the precise time spent here in the comments. However, little time is ever committed.

-- Query_5: List all the locations where products/services were sold, and the product has customer’s ratings
-- Question: What are the locations of the services and what are the customers' ratings?

-- EXPLAIN
SELECT 
    ct.city_name as Location,
    s.service_type as Service,
    ROUND(AVG(so.rating),2) AS Customer_Rating
FROM service s
		INNER JOIN 
    service_order so ON s.service_id = so.service_service_id
        INNER JOIN
    employee e ON so.employee_employee_id = e.employee_id
        INNER JOIN
    postal_region pr ON pr.region_id = e.postal_region_region_id
        INNER JOIN
    postal_code pc ON pc.postal_region_region_id  = pr.region_id
        INNER JOIN
    city ct ON ct.city_id = pc.city_city_id
WHERE
    so.fulfilled = 1
GROUP BY 1,2
ORDER BY ct.city_name;

-- To optimize: As mentioned earlier, we will not set fulfilled column as an Index, because this column has low cardinality.
-- We examined the execution time of this query using the EXPLAIN command and discovered that it was extremely speedy.
-- We have opted not to provide the specific time spent here in the comments because it varies so greatly every time we run the query. But very little time is actually given when performing the query using EXPLAIN.