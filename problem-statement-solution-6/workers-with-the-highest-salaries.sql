-- Objective: Find the job titles of the highest-paid employees.
-- Output: Highest-paid title or multiple titles with the same salary.

-- Assuming your table is named 'employees' and contains columns 'job_title' and 'salary'.

-- Solution

SELECT *
FROM
  (SELECT CASE
              WHEN salary =
                     (SELECT MAX(salary)
                      FROM worker) THEN worker_title
          END AS highest_paid_title
   FROM 
        worker w
   INNER JOIN 
        title t ON t.worker_ref_id = w.worker_id
   ORDER BY highest_paid_title) subquery
WHERE highest_paid_title IS NOT NULL