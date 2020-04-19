/*
Using the Monthly Report produced on the earlier exercise, the client wants to
use this information in order to identify the performance of his employees for
the year of 2005.

These are the columns they requested:
Employee Name, Total Sales, and Employment status
*/


SELECT
	CONCAT(emp.firstName, ' ', emp.lastName) as employee_name,
    '' as sales,
    '' as employment_status
FROM employees as emp
