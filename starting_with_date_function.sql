--Find the sales in terms of total dollars for all orders in each year, ordered from greatest to least. 
select date_part('year',o.occurred_at),sum(total_amt_usd)
from orders o
group by 1
order by 2 desc

--Which month did Parch & Posey have the greatest sales in terms of total dollars? Are all months evenly represented by the dataset?
select date_part('month',o.occurred_at),sum(total_amt_usd)
from orders o
group by 1
order by 2 desc
limit 1
--result is 12th month is having highest data sales 
-- by the following query we can know that only 1st month of 2017 and last month of 2013 is considered so results are having 1 additional value for month 12 and 1 avg would have been batter choice to get idea about the sales
select date_trunc('month',o.occurred_at),sum(total_amt_usd)
from orders o
group by 1
order by 1 desc
--Which year did Parch & Posey have the greatest sales in terms of total number of orders? Are all years evenly represented by the dataset?
select date_part('year',o.occurred_at),count(*) total_orders	
from orders o
group by 1
order by 2 desc
limit 1
--years are not evenly represented as 2013 and 2017 have only data of one month
