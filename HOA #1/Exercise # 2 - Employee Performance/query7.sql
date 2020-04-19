/*
Some DB environments like Oracle don't allow nested tables in their joins (Example in query #2)
so we use WITH on these scenarios.

WITH can also be used to filter the table you're going to use in preparation
for the main select query on the bottom.

This is just an alternate query for query #6. The main select query is much more
cleaner with less computation codes in the main query, besides for creating new
variables.
*/

WITH mt as(
    SELECT
    	mt.date,
			mt.total_value,
    	mt.salesRepEmployeeNumber
    FROM monthly_transactions as mt
    WHERE mt.status = 'Shipped' AND SUBSTRING(mt.date,1,4) = 2005
),

emp AS(
	SELECT
		emp.employeeNumber,
		CONCAT(emp.firstName, ' ', emp.lastName) as employee_name
	FROM employees as emp
)

SELECT
		emp.employee_name,
    SUM(mt.total_value) as sales,
    CASE
      WHEN SUM(mt.total_value) > 100000 THEN "For Promotion"
      WHEN SUM(mt.total_value) >= 50000 THEN "Meets Targets"
      ELSE "Performance Review"
    END as employment_status
FROM emp
INNER JOIN mt on emp.employeeNumber = mt.salesRepEmployeeNumber
GROUP BY emp.employeeNumber
ORDER BY sales  DESC
