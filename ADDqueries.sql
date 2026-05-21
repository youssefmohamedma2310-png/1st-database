use alpha;
GO
SELECT ticker_symbol FROM Asset WHERE Current_market_price > 50;
GO
select SUM(total_balance) as all_money from Client
ORDER BY SUM(total_balance) ASC;
GO

UPDATE Client SET Email = 'youssefmohamedps5@gmail.com'
WHERE client_id = 1;
GO
SELECT  * FROM asset where Asset_name LIKE 'm%';
GO
alter tABLE Transaction_Table
ADD Asset_name varchar(255); 
INSERT INTO Transaction_Table (transaction_type, amount, portfolio_id, ) VALUES ('BUY',1599, 1);
INSERT INTO Transaction_Table (transaction_type, amount, portfolio_id) VALUES ('BUY', NULL, 1);
Delete from Portfolio_Asset
WHERE ticker_symbol = 'PLTR'
GO
Delete from Asset
WHERE ticker_symbol = 'PLTR'
GO

-- join SQL 
-- With JOIN (meaningful output)
SELECT 
Portfolio.total_value AS totalmoney,
Client.First_name, 
client.Last_name,
Portfolio_Asset.ticker_symbol as stockshare,
SUM(Portfolio_Asset.quantity * asset.Current_market_price) as marketshare
from portfolio
INNER JOIN Client on portfolio.client_id = client.client_id
LEFT JOIN Portfolio_Asset on portfolio.portfolio_id = Portfolio_Asset.portfolio_id
INNER JOIN asset on Portfolio_Asset.ticker_symbol =  Asset.Ticker_symbol
GROUP BY client.First_name,portfolio.total_value,client.Last_name,Portfolio_Asset.ticker_symbol
 HAVING SUM (Portfolio_Asset.quantity * asset.Current_market_price) > 2000
GO
