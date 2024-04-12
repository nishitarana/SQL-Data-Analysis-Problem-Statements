-- Objective: Find the total number of downloads for paying and non-paying users by date.
-- Include only records where non-paying customers have more downloads than paying customers.
-- Output: Sorted by earliest date first and containing 3 columns: date, non-paying downloads, paying downloads.

-- Assuming your table is named 'downloads' and contains columns 'date', 'user_type' (paying or non-paying), and 'num_downloads'.

--Solution

SELECT X.date, non_paying_downloads, paying_downloads
from
(SELECT date, SUM(c.downloads) as non_paying_downloads
from
ms_user_dimension a
JOIN
ms_acc_dimension b ON a.acc_id = b.acc_id
JOIN 
ms_download_facts c ON a.user_id = c.user_id
WHERE b.paying_customer = lower('no')
GROUP BY date) AS X
JOIN
(SELECT date, SUM(c.downloads) as paying_downloads
from
ms_user_dimension a
JOIN
ms_acc_dimension b ON a.acc_id = b.acc_id
JOIN 
ms_download_facts c ON a.user_id = c.user_id
WHERE b.paying_customer = lower('yes')
GROUP BY date) AS Y ON X.date = Y.date
WHERE non_paying_downloads > paying_downloads
order by X.date ASC;