SELECT
  CONCAT(YEAR(ord.orderDate),'-',MONTH(ord.orderDate)) as date,
  cst.salesRepEmployeeNumber,
	cst.customerNumber,
  cst.customerName,
  ord.orderNumber,
  ord.status
FROM customers AS cst
INNER JOIN orders AS ord ON cst.customerNumber = ord.customerNumber
ORDER BY ord.orderDate,cst.customerName   DESC
