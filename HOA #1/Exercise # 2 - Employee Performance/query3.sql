/*
Looking back at query 2, it could be quite messy using a long query as a table,
especially in the future if the what you're going to join is a very long query.

A solution to make things easier is by turning entire queries into VIEWS.
Views simply save the entire queries to be called on its respective name.

In this case, we're saving the entire query we made into a view called
"monthly_transactions".

Please note that it does not generate static data when we call the view. It just
simply runs the query specified to the view, so it always does processing whenever
its called
*/


CREATE VIEW monthly_transactions AS (SELECT
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
			ORDER BY ord.orderDate,cst.customerName DESC
	)
