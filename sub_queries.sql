
--For the region with the largest (sum) of sales total_amt_usd, how many total (count) orders were placed?
SELECT r.name region_name, count(o.total)
FROM region r
JOIN sales_reps s
ON s.region_id=r.id
JOIN accounts a
ON s.id=a.sales_rep_id
JOIN orders o
ON o.account_id=a.id
GROUP BY 1
HAVING r.name = (SELECT region_name  FROM
					(SELECT r.name region_name, sum(o.total_amt_usd) as total_sales
					FROM region r
					JOIN sales_reps s
					ON s.region_id=r.id
					JOIN accounts a
					ON s.id=a.sales_rep_id
					JOIN orders o
					ON o.account_id=a.id
					GROUP BY 1
					ORDER BY 2 desc
					limit 1) as t1
				)

				


--How many accounts had more total purchases than the account name which has bought the most standard_qty paper throughout their lifetime as a customer?

SELECT count(account_name)
From(
		SELECT a.name account_name, sum(o.total) as total_purchase
		FROM accounts a
		JOIN orders o
		ON a.id=o.account_id
		GROUP BY 1
		HAVING sum(o.total)> (SELECT sum(o.total)
								FROM orders o
								JOIN accounts a
								ON o.account_id=a.id
								where a.name=(SELECT account_name FROM 
												(SELECT a.name account_name, sum(o.standard_qty)as std_qty
													FROM accounts a
													JOIN orders o
													ON o.account_id=a.id
													GROUP BY 1
													ORDER BY 2 DESC
													LIMIT 1) as t1
												)
								)
	)as t2

--For the customer that spent the most (in total over their lifetime as a customer) total_amt_usd, how many web_events did they have for each channel?
SELECT w.channel, count(w.occurred_at),a.name
FROM web_events w
JOIN accounts a
ON w.account_id=a.id
where w.account_id =(SELECT account_id 
					 FROM 
					 (SELECT a.id account_id, sum(o.total_amt_usd) total_sum
						FROM accounts a
						JOIN orders o
						ON a.id=o.account_id
						GROUP BY 1
						ORDER BY 2 DESC
						LIMIT 1) 
					as t1)
Group BY 3,1
ORDER BY 2 DESC

--What is the lifetime average amount spent in terms of total_amt_usd for the top 10 total spending accounts?
SELECT AVG(total_spent)
FROM (SELECT a.name, sum(o.total_amt_usd)as total_spent
		FROM orders o
		JOIN accounts a
		ON a.id=o.account_id
		GROUP BY 1
		ORDER BY 2 DESC
		LIMIT 10) as t1




