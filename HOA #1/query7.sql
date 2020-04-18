WITH m_t as(
    SELECT
    	m_t.date,
			m_t.total_value,
    	cst.salesRepEmployeeNumber
    FROM monthly_transactions as m_t
	  INNER JOIN customers as cst ON cst.customerNumber = m_t.customerNumber
    WHERE m_t.status = 'Shipped' AND SUBSTRING(m_t.date,1,4) = 2005
),

emp AS(
	SELECT
		emp.employeeNumber,
		CONCAT(emp.firstName, ' ', emp.lastName) as employee_name
	FROM employees as emp
)

SELECT
		emp.employee_name,
    SUM(m_t.total_value) as sales,
    CASE
      WHEN SUM(m_t.total_value) > 80000 THEN "For Promotion"
      WHEN SUM(m_t.total_value) >= 25000 THEN "Meets Targets"
      ELSE "Performance Review"
    END as employment_status
FROM m_t
INNER JOIN emp on emp.employeeNumber = m_t.salesRepEmployeeNumber
GROUP BY m_t.date, emp.employeeNumber
ORDER BY sales  DESC
