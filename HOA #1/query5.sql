SELECT
	CONCAT(emp.firstName, ' ', emp.lastName) as employee_name,
    SUM(m_t.total_value) as sales,
    CASE
    	WHEN SUM(m_t.total_value) > 100000 THEN "For Promotion"
        WHEN SUM(m_t.total_value) >= 50000 THEN "Meets Targets"
        ELSE "Performance Review"
    END as employment_status
FROM
    (SELECT
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
		ORDER BY ord.orderDate,cst.customerName   DESC
) as m_t
INNER JOIN customers as cst ON cst.customerNumber = m_t.customerNumber
INNER JOIN employees as emp on emp.employeeNumber = cst.salesRepEmployeeNumber
WHERE m_t.status = 'Shipped' AND SUBSTRING(m_t.date,1,4) = 2005
GROUP BY m_t.date, emp.employeeNumber
ORDER BY sales  DESC
