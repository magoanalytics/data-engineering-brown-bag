/*
Since the employee and the transactions is a one is to many relationship, the
rows of the employees increased in number to match each transactions.

We have to group all the sales to their respective employee numbers and get the
sum.

WE also have to filter out the sales to those whose transactions were sucessfully
shipped and made during 2005.
*/

SELECT
	CONCAT(emp.firstName, ' ', emp.lastName) as employee_name,
    SUM(mt.total_value) as sales,
    '' as employment_status
FROM employees as emp
INNER JOIN monthly_transactions as mt on emp.employeeNumber = mt.salesRepEmployeeNumber
WHERE mt.status = 'Shipped' AND SUBSTRING(mt.date,1,4) = 2005
GROUP BY emp.employeeNumber
ORDER BY sales DESC
