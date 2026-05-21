# Alpha Investment Management Database 📊

![SQL Server](https://img.shields.io/badge/SQL%20Server-2022-CC2927?style=flat&logo=microsoftsqlserver&logoColor=white)
![Status](https://img.shields.io/badge/Status-Active-brightgreen?style=flat)
![Tables](https://img.shields.io/badge/Tables-7-blue?style=flat)
![Assets](https://img.shields.io/badge/Assets-33%20Stocks-orange?style=flat)

A relational database system built with **Microsoft SQL Server 2022**, designed to manage client investment portfolios, financial advisor assignments, and real-time market asset tracking. The schema is fully normalized, constraint-driven, and built around a clear four-stage dependency hierarchy.

---

## 📁 Repository Structure

```
alpha-investment-db/
├── DATABASE FRESH CODE.sql     # DDL — Creates all tables, keys, and constraints
├── Alpha_INSERT_DATA.sql       # DML — Populates 10 clients, 10 advisors, 33 assets
└── README.md
```

---

## 🗂️ Schema Overview

The database is structured in four dependency stages to guarantee referential integrity.

```
Stage 1 — Independent        Stage 2 — Dependent          Stage 3 — Junction        Stage 4 — Audit
─────────────────────────    ──────────────────────────    ──────────────────────    ──────────────────
Client                   ──► Portfolio (client_id FK)  ──► Portfolio_Asset        ──► Transaction_Table
Advisor                  ──► Portfolio (emp_id FK)          (portfolio_id FK)           (portfolio_id FK)
Asset                    ──► Phone_Client (client_id FK)    (ticker_symbol FK)
```

### Table Reference

| Table | Type | Purpose |
|---|---|---|
| `Client` | Core entity | Client profiles, balances, enforces $1,500 minimum entry |
| `Advisor` | Core entity | Wealth management professionals and their specializations |
| `Asset` | Core entity | Master directory of 33 global stocks (EGX + NASDAQ) |
| `Phone_Client` | Dependent | Multi-valued phone numbers per client (composite PK) |
| `Portfolio` | Dependent | Links one client to one advisor; tracks total holdings value |
| `Portfolio_Asset` | Junction (M:N) | Bridges portfolios and assets; stores quantity per holding |
| `Transaction_Table` | Audit log | Immutable record of all BUY, SELL, DEPOSIT, WITHDRAWAL events |

---

## ⚙️ Data Integrity & Constraints

Business rules are enforced at the schema level — not in application code.

| Constraint | Table | Rule Enforced |
|---|---|---|
| `CK_Client_MinBalance` | Client | `Total_balance > 1500` — Minimum account entry requirement |
| `UQ_Client_Email` | Client | No duplicate client email addresses |
| `CK_Asset_Price` | Asset | `Current_market_price >= 0` — No negative market prices |
| `CK_Asset_Quantity` | Portfolio_Asset | `quantity > 0` — Must own at least one share |
| `CK_Trans_Type` | Transaction_Table | Restricts to `BUY`, `SELL`, `DEPOSIT`, `WITHDRAWAL` only |
| `CK_Trans_Amount` | Transaction_Table | `amount > 0` — No zero-value transactions |
| `ON DELETE CASCADE` | Phone_Client, Portfolio_Asset | Child records auto-deleted when parent is removed |

---

## 🚀 Deployment Guide

### Step 1 — Create the Schema

Run `DATABASE FRESH CODE.sql` to build all tables, primary keys, foreign keys, and constraints.

```sql
-- The script handles cleanup automatically
USE master;
GO
IF EXISTS (SELECT * FROM sys.databases WHERE name = 'alpha')
    DROP DATABASE alpha;
GO
CREATE DATABASE alpha;
```

### Step 2 — Populate the Data

Run `Alpha_INSERT_DATA.sql` to insert:
- ✅ 10 Advisors (tiered by client wealth)
- ✅ 10 Clients (with real Egyptian and international names)
- ✅ 33 Assets (20 EGX + 13 NASDAQ stocks)
- ✅ 10 Portfolios with advisor assignments
- ✅ 38 Portfolio–Asset holdings
- ✅ 10 Transactions

### Step 3 — Verify

```sql
SELECT 'Advisors'         AS [Table], COUNT(*) AS [Rows] FROM Advisor
UNION ALL SELECT 'Clients',          COUNT(*) FROM Client
UNION ALL SELECT 'Assets',           COUNT(*) FROM Asset
UNION ALL SELECT 'Portfolios',       COUNT(*) FROM Portfolio
UNION ALL SELECT 'Portfolio_Assets', COUNT(*) FROM Portfolio_Asset
UNION ALL SELECT 'Transactions',     COUNT(*) FROM Transaction_Table;
```

---

## 💼 Wealth Tier System

Advisor assignment is based on client total balance — richer clients receive more senior advisors.

| Tier | Balance Range | Advisor |
|---|---|---|
| 🥇 VIP | $50,000+ | Ahmed Shabaan, Loay Fawzy |
| 🥈 Mid | $20,000 – $49,999 | Fatima Hassan, Omar Khaled |
| 🥉 Standard | $10,000 – $19,999 | Nour Ibrahim, Sara Mostafa |
| 🔰 Starter | $5,000 – $9,999 | Kareem Adel, Hana Al-Sayed |
| 📋 Entry | Below $5,000 | Tarek Mansour, Rana Khalil |

---

## 📊 Analytical Query Showcase

### Premium Portfolio Report
Identifies clients whose portfolio market value exceeds $50,000.

```sql
SELECT
    c.First_name + ' ' + c.Last_name           AS [Client Name],
    p.portfolio_id                              AS [Portfolio Ref],
    SUM(pa.quantity * a.Current_market_price)   AS [Total Market Value]
FROM Client c
INNER JOIN Portfolio       p  ON c.Client_id       = p.client_id
INNER JOIN Portfolio_Asset pa ON p.portfolio_id    = pa.portfolio_id
INNER JOIN Asset           a  ON pa.ticker_symbol  = a.Ticker_symbol
GROUP BY c.First_name, c.Last_name, p.portfolio_id
HAVING SUM(pa.quantity * a.Current_market_price) > 50000;
```

### Full Holdings Breakdown
Shows every client's stock holdings with calculated market value, filtered above $2,000.

```sql
SELECT
    c.First_name,
    c.Last_name,
    p.total_value                               AS [Portfolio Value],
    pa.ticker_symbol                            AS [Stock],
    SUM(pa.quantity * a.Current_market_price)   AS [Holding Market Value]
FROM Portfolio p
INNER JOIN Client          c  ON p.client_id       = c.Client_id
LEFT  JOIN Portfolio_Asset pa ON p.portfolio_id    = pa.portfolio_id
INNER JOIN Asset           a  ON pa.ticker_symbol  = a.Ticker_symbol
GROUP BY c.First_name, c.Last_name, p.total_value, pa.ticker_symbol
HAVING SUM(pa.quantity * a.Current_market_price) > 2000;
```

### Market Exposure Scan
Lists all assets priced above $50 (premium instruments).

```sql
SELECT Ticker_symbol, Asset_name, Current_market_price
FROM Asset
WHERE Current_market_price > 50
ORDER BY Current_market_price DESC;
```

### Total Capital Under Management

```sql
SELECT SUM(Total_balance) AS [Total AUM]
FROM Client;
```

---

## 🔧 Operational Reference

### Update a Client Profile

```sql
UPDATE Client
SET Email = 'newemail@example.com'
WHERE Client_id = 1;
```

### Safely Remove an Asset
Must clear the junction table first to avoid FK constraint violations.

```sql
-- Step 1: Remove all portfolio holdings of this asset
DELETE FROM Portfolio_Asset
WHERE ticker_symbol = 'PLTR';

-- Step 2: Now safely remove the asset itself
DELETE FROM Asset
WHERE ticker_symbol = 'PLTR';
```


### Schema Evolution — Add Audit Column

```sql
ALTER TABLE Transaction_Table
ADD Asset_name VARCHAR(255);
```

---

## 🔮 Roadmap — Version 2.0

- [ ] **Automated Advisor Assignment** — Stored procedure that assigns advisors dynamically based on client balance thresholds
- [ ] **Expanded Asset Classes** — Support for Commodities, ETFs, and bundled asset packages
- [ ] **Inactivity Engine** — Stored procedure to handle client exits and portfolio archiving after inactivity period
- [ ] **Raised Entry Requirement** — Increase minimum account balance from $1,500 to $10,000
- [ ] **Web Interface** — Interactive HTML dashboard with real-time SQL query preview

---

## 👤 Author

**Youssef Mohamed**
Database Design Project — College Course
Built with Microsoft SQL Server 2022
