/*
In order for us to join the report we made on Exerise #1, we can simply just
join it by placing the entire query on a column after declaring a join.

It is important to give the table an alias after the column in order to give
it an id on this query like what was done below where the query was defined as
mt and joined on the necessary keys needed.
*/


SELECT
	CONCAT(emp.firstName, ' ', emp.lastName) as employee_name,
    mt.total_value as sales,
    '' as employment_status
FROM employees as emp
INNER JOIN (
	SELECT
	  CONCAT(YEAR(ord.orderDate),'-',MONTH(ord.orderDate)) as date,
	  cst.salesRepEmployeeNumber,
	  cst.customerNumber,
	  cst.customerName,
	  ord.orderNumber,
	  ord.status,
	  prd.productName,
	  ord_det.quantityOrdered,
	  (ord_det.quantityOrdered * ord_det.priceEach) as total_value
	FROM customers AS cst
	INNER JOIN orders AS ord ON cst.customerNumber = ord.customerNumber
	INNER JOIN orderdetails as ord_det ON ord.orderNumber = ord_det.orderNumber
	INNER JOIN products AS prd ON prd.productCode = ord_det.productCode
	ORDER BY ord.orderDate,cst.customerName   DESC
) as mt on emp.employeeNumber = mt.salesRepEmployeeNumber
