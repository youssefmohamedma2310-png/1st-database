
USE alpha;
GO



-- ============================================================
-- SECTION 1: ADVISORS (10 advisors — wealth tiered)
-- ============================================================
-- Tier 1 VIP  ($50k+):   Ahmed Shabaan, Loay Fawzy
-- Tier 2 Mid  ($20-50k): Fatima Hassan, Omar Khaled
-- Tier 3 Low  ($10-20k): Nour Ibrahim, Sara Mostafa
-- Tier 4 Mini ($5-10k):  Kareem Adel, Hana Al-Sayed
-- Tier 5 Starter (<$5k): Tarek Mansour, Rana Khalil

INSERT INTO Advisor (name, specialization) VALUES
('Ahmed Shabaan',  'Head of Wealth Management'),
('Loay Fawzy',     'Senior Portfolio Director'),
('Fatima Hassan',  'Portfolio Manager'),
('Omar Khaled',    'Senior Financial Analyst'),
('Nour Ibrahim',   'Financial Advisor'),
('Sara Mostafa',   'Investment Consultant'),
('Kareem Adel',    'Junior Investment Advisor'),
('Hana Al-Sayed',  'Junior Financial Analyst'),
('Tarek Mansour',  'Associate Advisor'),
('Rana Khalil',    'Trainee Financial Advisor');
GO

-- ============================================================
-- SECTION 2: CLIENTS (10 clients)
-- ===========================================================

INSERT INTO Client (Email, Total_balance, First_name, Last_name) VALUES
('youssefmohamed@gmail.com',    15000.00,  'Youssef',  'Mohamed'),
('ahmedshabaan@gmail.com',     200000.00,  'Ahmed',    'Shabaan'),
('abdomagdy@yahoo.com',         12300.00,  'Abdullah', 'Magdy'),
('loay@hotmail.com',            18000.00,  'Loay',     'Fawzy'),
('chatkoora@yahoo.com',         72000.00,  'Medo',     'Mostafa'),
('ahmed.hassan@email.com',      18000.00,  'Ahmed',    'Hassan'),
('hassan.nimer@email.com',      55000.00,  'Hassan',   'Al-Nimer'),
('rania.khaled@email.com',      40000.00,  'Rania',    'Khaled'),
('salma.tarek@email.com',        8000.00,  'Salma',    'Tarek'),
('khaled.samir@email.com',       4000.00,  'Khaled',   'Samir');
GO

-- ============================================================
-- SECTION 3: PHONE NUMBERS
-- ============================================================
-- VIP clients get 2 phone numbers

INSERT INTO Phone_Client (client_id, phone_number) VALUES
(1,  '+20-100-1234567'),
(2,  '+20-112-9999999'),
(2,  '+20-100-8888888'),   -- Ahmed Shabaan: 2 phones (VIP)
(3,  '+20-101-3333333'),
(4,  '+20-100-4444444'),
(5,  '+20-112-5555555'),
(5,  '+20-100-6666666'),   -- Medo Mostafa: 2 phones
(6,  '+20-101-7777777'),
(7,  '+20-100-2222222'),
(8,  '+20-112-1111111'),
(9,  '+20-101-9876543'),
(10, '+20-100-1111112');
GO

-- ============================================================
-- SECTION 4: ASSETS (33 stocks from watchlist file)
-- ============================================================
-- NOTE: CRST original price $0.0226 rounded to $0.02 (DECIMAL(10,2) limit)


-- EGX Stocks (20 Egyptian Exchange stocks)
INSERT INTO Asset (Ticker_symbol, Asset_name, Current_market_price) VALUES
('FWRY',  'Fawry Banking Technology',          0.37),
('EFID',  'EFG Hermes Financial Group',        0.53),
('CRST',  'Cairo Poultry Group',               0.02),
('SAUD',  'Al Saud Company',                   0.43),
('MPCI',  'Misr Protein Company Inc',          3.95),
('ISMQ',  'Ismailia Misr Poultry',             0.14),
('MFPC',  'Misr Fertilizers Production',       0.84),
('ASCM',  'Ascom Metals and Mining',           0.90),
('ETRS',  'Egyptian Resorts Company',          0.15),
('EGAL',  'Egypt Aluminum Company',            6.12),
('AMIA',  'Amoun Industrial Company',          0.17),
('PRCL',  'Pyramids Real Estate',              0.43),
('NCCW',  'North Cairo Cables and Wires',      0.10),
('ALUM',  'Aluminium Company of Egypt',        0.46),
('RAYA',  'Raya Contact Center',               0.14),
('EHDR',  'El Ahly Development Real Estate',   0.04),
('AALR',  'Al Ahli Real Estate Company',       3.84),
('CERA',  'Ceramica Cleopatra Group',          0.02),
('GGRN',  'Green Valley Real Estate',          0.03),
('MPCO',  'Medco Plast Company',               0.03);

-- NASDAQ Stocks (13 American stocks)
INSERT INTO Asset (Ticker_symbol, Asset_name, Current_market_price) VALUES
('NVDA',  'NVIDIA Corporation',               220.61),
('TSLA',  'Tesla Inc',                        404.11),
('AAPL',  'Apple Inc',                        298.97),
('MSFT',  'Microsoft Corporation',            417.42),
('MU',    'Micron Technology Inc',            698.74),
('AMD',   'Advanced Micro Devices',           414.05),
('AMZN',  'Amazon Inc',                       259.34),
('META',  'Meta Platforms Inc',               602.61),
('PLTR',  'Palantir Technologies',            135.26),
('INTC',  'Intel Corporation',                110.80),
('GOOGL', 'Alphabet Inc',                     387.66),
('NFLX',  'Netflix Inc',                       89.33),
('XPEL',  'XPEL Inc',                          43.30);
GO

-- ============================================================
-- SECTION 5: PORTFOLIOS (10 portfolios — tiered by wealth)
-- ============================================================

INSERT INTO Portfolio (create_date, total_value, client_id, emp_id) VALUES
('2024-01-10', 200000.00,  2,  1),  -- Ahmed Shabaan → Advisor: Shabaan (VIP)
('2024-01-15',  72000.00,  5,  1),  -- Medo Mostafa → Advisor: Shabaan (VIP)
('2024-02-01',  55000.00,  7,  2),  -- Hassan Al-Nimer → Advisor: Loay (VIP)
('2024-02-10',  40000.00,  8,  2),  -- Rania Khaled → Advisor: Loay (VIP)
('2024-03-01',  18000.00,  4,  3),  -- Loay → Advisor: Fatima
('2024-03-05',  18000.00,  6,  4),  -- Ahmed Hassan → Advisor: Omar
('2024-03-10',  15000.00,  1,  5),  -- Youssef Mohamed → Advisor: Nour
('2024-03-15',  12300.00,  3,  6),  -- Abdullah Magdy → Advisor: Sara
('2024-04-01',   8000.00,  9,  7),  -- Salma Tarek → Advisor: Kareem
('2024-04-10',   4000.00, 10,  8);  -- Khaled Samir → Advisor: Hana
GO

-- ============================================================
-- SECTION 6: PORTFOLIO ASSETS (tiered by wealth)
-- ============================================================

-- Portfolio 1: Ahmed Shabaan ($200k) — Premium NASDAQ Only
INSERT INTO Portfolio_Asset (portfolio_id, ticker_symbol, quantity) VALUES
(1, 'NVDA',  100),   -- 100 × $220.61 = $22,061
(1, 'AAPL',  200),   -- 200 × $298.97 = $59,794
(1, 'MSFT',  100),   -- 100 × $417.42 = $41,742
(1, 'AMZN',  200),   -- 200 × $259.34 = $51,868
(1, 'META',   40);   --  40 × $602.61 = $24,104
GO

-- Portfolio 2: Medo Mostafa ($72k) — NASDAQ Blend
INSERT INTO Portfolio_Asset (portfolio_id, ticker_symbol, quantity) VALUES
(2, 'NVDA',   50),   --  50 × $220.61 = $11,030
(2, 'AAPL',  100),   -- 100 × $298.97 = $29,897
(2, 'GOOGL',  80);   --  80 × $387.66 = $31,012
GO

-- Portfolio 3: Hassan Al-Nimer ($55k) — NASDAQ Blend
INSERT INTO Portfolio_Asset (portfolio_id, ticker_symbol, quantity) VALUES
(3, 'MSFT',   50),   --  50 × $417.42 = $20,871
(3, 'AMZN',  100),   -- 100 × $259.34 = $25,934
(3, 'TSLA',   20);   --  20 × $404.11 =  $8,082
GO

-- Portfolio 4: Rania Khaled ($40k) — Growth Stocks
INSERT INTO Portfolio_Asset (portfolio_id, ticker_symbol, quantity) VALUES
(4, 'PLTR',  100),   -- 100 × $135.26 = $13,526
(4, 'AMD',    50),   --  50 × $414.05 = $20,702
(4, 'NFLX',   60);   --  60 ×  $89.33 =  $5,360
GO

-- Portfolio 5: Loay Fawzy client ($18k) — EGX + NASDAQ Mix
INSERT INTO Portfolio_Asset (portfolio_id, ticker_symbol, quantity) VALUES
(5, 'EGAL',   500),  --  500 × $6.12  =  $3,060
(5, 'AALR',   500),  --  500 × $3.84  =  $1,920
(5, 'MPCI',  1000),  -- 1000 × $3.95  =  $3,950
(5, 'INTC',    80);  --   80 × $110.80 =  $8,864
GO

-- Portfolio 6: Ahmed Hassan ($18k) — EGX + Small NASDAQ
INSERT INTO Portfolio_Asset (portfolio_id, ticker_symbol, quantity) VALUES
(6, 'EGAL',   400),  --  400 × $6.12  =  $2,448
(6, 'MPCI',   800),  --  800 × $3.95  =  $3,160
(6, 'XPEL',   200),  --  200 × $43.30 =  $8,660
(6, 'ASCM',  2000);  -- 2000 × $0.90  =  $1,800
GO

-- Portfolio 7: Youssef Mohamed ($15k) — Mid EGX
INSERT INTO Portfolio_Asset (portfolio_id, ticker_symbol, quantity) VALUES
(7, 'AALR',   500),  --  500 × $3.84  =  $1,920
(7, 'EGAL',   300),  --  300 × $6.12  =  $1,836
(7, 'NFLX',   100),  --  100 × $89.33 =  $8,933
(7, 'FWRY',  5000);  -- 5000 × $0.37  =  $1,850
GO

-- Portfolio 8: Abdullah Magdy ($12.3k) — Affordable Mix
INSERT INTO Portfolio_Asset (portfolio_id, ticker_symbol, quantity) VALUES
(8, 'AALR',   300),  --  300 × $3.84  =  $1,152
(8, 'EFID',  2000),  -- 2000 × $0.53  =  $1,060
(8, 'MFPC',  1500),  -- 1500 × $0.84  =  $1,260
(8, 'XPEL',   200);  --  200 × $43.30 =  $8,660
GO

-- Portfolio 9: Salma Tarek ($8k) — EGX Heavy
INSERT INTO Portfolio_Asset (portfolio_id, ticker_symbol, quantity) VALUES
(9, 'EGAL',   500),  --  500 × $6.12  =  $3,060
(9, 'FWRY',  5000),  -- 5000 × $0.37  =  $1,850
(9, 'SAUD',  3000),  -- 3000 × $0.43  =  $1,290
(9, 'EFID',  2000);  -- 2000 × $0.53  =  $1,060
GO

-- Portfolio 10: Khaled Samir ($4k) — Pure EGX Starter
INSERT INTO Portfolio_Asset (portfolio_id, ticker_symbol, quantity) VALUES
(10, 'EGAL',   200),  --  200 × $6.12  =  $1,224
(10, 'MPCI',   300),  --  300 × $3.95  =  $1,185
(10, 'AALR',   200),  --  200 × $3.84  =    $768
(10, 'FWRY',  1000),  -- 1000 × $0.37  =    $370
(10, 'ALUM',   500);  --  500 × $0.46  =    $230
GO

-- ============================================================
-- SECTION 7: TRANSACTIONS (10 transactions, one per portfolio)
-- ============================================================

INSERT INTO Transaction_Table (transaction_type, amount, transaction_date, portfolio_id) VALUES
('DEPOSIT',   200000.00, '2024-01-10 09:00:00',  1),   -- Shabaan opens VIP account
('BUY',        72000.00, '2024-01-15 10:30:00',  2),   -- Medo buys NASDAQ
('BUY',        55000.00, '2024-02-01 11:00:00',  3),   -- Hassan buys NASDAQ blend
('DEPOSIT',    40000.00, '2024-02-10 14:00:00',  4),   -- Rania deposits
('BUY',        18000.00, '2024-03-01 09:30:00',  5),   -- Loay buys EGX+NASDAQ
('BUY',        18000.00, '2024-03-05 11:15:00',  6),   -- Ahmed Hassan buys
('DEPOSIT',    15000.00, '2024-03-10 10:00:00',  7),   -- Youssef opens account
('BUY',        12300.00, '2024-03-15 13:30:00',  8),   -- Abdullah buys EGX
('BUY',         8000.00, '2024-04-01 09:45:00',  9),   -- Salma buys EGX
('DEPOSIT',     4000.00, '2024-04-10 16:00:00', 10);   -- Khaled opens starter account
GO

-- ============================================================
-- SECTION 8: VERIFICATION — Should show correct row counts
-- ============================================================

SELECT 'Advisors'        AS [Table], COUNT(*) AS [Rows] FROM Advisor
UNION ALL
SELECT 'Clients',         COUNT(*) FROM Client
UNION ALL
SELECT 'Phone Numbers',   COUNT(*) FROM Phone_Client
UNION ALL
SELECT 'Assets',          COUNT(*) FROM Asset
UNION ALL
SELECT 'Portfolios',      COUNT(*) FROM Portfolio
UNION ALL
SELECT 'Portfolio Assets',COUNT(*) FROM Portfolio_Asset
UNION ALL
SELECT 'Transactions',    COUNT(*) FROM Transaction_Table;
GO

PRINT '✅ Alpha Investment Database populated successfully.';
GO
