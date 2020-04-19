/*
The query can now be as simple as this compared to query #2 even though
they just produce the same output.
*/


SELECT
	CONCAT(emp.firstName, ' ', emp.lastName) as employee_name,
    mt.total_value as sales,
    '' as employment_status
FROM employees as emp
INNER JOIN monthly_transactions as mt on emp.employeeNumber = mt.salesRepEmployeeNumber
