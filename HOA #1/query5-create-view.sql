CREATE VIEW monthly_transactions AS (SELECT
		  CONCAT(YEAR(ord.orderDate),'-',MONTH(ord.orderDate)) as date,
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
		ORDER BY ord.orderDate,cst.customerName DESC
)
