SELECT
  CONCAT(YEAR(ord.orderDate),'-',MONTH(ord.orderDate)) as date,
  cst.customerNumber,
  cst.customerName,
  ord.orderNumber,
  ord.status,
  ord_det.productCode,
  ord_det.quantityOrdered,
  (ord_det.quantityOrdered * ord_det.priceEach) as total_value
FROM customers AS cst
INNER JOIN orders AS ord ON cst.customerNumber = ord.customerNumber
INNER JOIN orderdetails as ord_det ON ord.orderNumber = ord_det.orderNumber
ORDER BY ord.orderDate,cst.customerName   DESC
