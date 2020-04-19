SELECT
	cst.salesRepEmployeeNumber,
	cst.customerNumber,
  cst.customerName
FROM customers AS cst
INNER JOIN orders AS ord ON cst.customerNumber = ord.customerNumber
