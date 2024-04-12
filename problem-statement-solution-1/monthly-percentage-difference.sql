-- Problem Statement: Given a table of purchases by date, calculate the month-over-month percentage change in revenue.
-- The output should include the year-month date (YYYY-MM) and percentage change, rounded to the 2nd decimal point, and sorted from the beginning of the year to the end of the year.
-- The percentage change column will be populated from the 2nd month forward and can be calculated as ((this month's revenue - last month's revenue) / last month's revenue)*100.

-- Assuming your table is named 'purchases' and has columns 'date' and 'revenue'


-- Solution
WITH revenue_cte(month, revenue) AS (
            SELECT 
                    DATE_FORMAT(created_at, "%Y-%m") AS month, 
                    SUM(value) as revenue
            FROM 
                sf_transactions
            GROUP BY 
                month
            ORDER BY month) 
SELECT 
        r.month,
        ROUND(((r.revenue - LAG(r.revenue) OVER (ORDER BY r.month))/
                LAG(r.revenue) OVER (ORDER BY r.month)) * 100, 2) AS percentage_change
FROM 
    revenue_cte r;