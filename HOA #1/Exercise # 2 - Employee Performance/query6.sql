/*
Now for employment status the client wants:

- If the employee reached more than 100k sales, they're up to Promotion
- More than 50k sales, meets the Targets
- Otherwise, the employee is up for performance review
*/

SELECT
	CONCAT(emp.firstName, ' ', emp.lastName) as employee_name,
    SUM(mt.total_value) as sales,
		CASE
    	WHEN SUM(mt.total_value) > 100000 THEN "For Promotion"
      WHEN SUM(mt.total_value) >= 50000 THEN "Meets Targets"
      ELSE "Performance Review"
    END as employment_status
FROM employees as emp
INNER JOIN monthly_transactions as mt on emp.employeeNumber = mt.salesRepEmployeeNumber
WHERE mt.status = 'Shipped' AND SUBSTRING(mt.date,1,4) = 2005
GROUP BY mt.date, emp.employeeNumber
ORDER BY sales DESC
