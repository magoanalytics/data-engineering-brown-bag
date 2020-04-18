SELECT
	CONCAT(emp.firstName, ' ', emp.lastName) as employee_name,
    SUM(m_t.total_value) as sales,
    CASE
    	WHEN SUM(m_t.total_value) > 80000 THEN "For Promotion"
      WHEN SUM(m_t.total_value) >= 25000 THEN "Meets Targets"
      ELSE "Performance Review"
    END as employment_status
FROM monthly_transactions as m_t
INNER JOIN customers as cst ON cst.customerNumber = m_t.customerNumber
INNER JOIN employees as emp on emp.employeeNumber = cst.salesRepEmployeeNumber
WHERE m_t.status = 'Shipped' AND SUBSTRING(m_t.date,1,4) = 2005
GROUP BY m_t.date, emp.employeeNumber
ORDER BY sales  DESC
