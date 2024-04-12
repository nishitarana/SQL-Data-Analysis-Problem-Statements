-- Objective: Find the user or users who flagged the most distinct videos that ended up approved by YouTube.
-- Output: Full name or names in case of a tie, including a space between the first and last name.

-- Assuming you have tables named 'users', 'flags', and 'videos', where 'flags' contains the user IDs and video IDs of flagged videos, 'videos' contains information about the videos including their approval status, and 'users' contains information about the users including their full names.

-- Solution
SELECT username
FROM
  (SELECT CONCAT(uf.user_firstname, ' ', uf.user_lastname) AS username,
          DENSE_RANK() OVER (
                             ORDER BY COUNT(DISTINCT video_id) DESC) AS rn
   FROM user_flags AS uf
   INNER JOIN flag_review AS fr ON uf.flag_id = fr.flag_id
   WHERE LOWER(fr.reviewed_outcome) = 'approved'
   GROUP BY username) AS inner_query
WHERE rn = 1