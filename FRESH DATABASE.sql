

-- 2. CREATE DATABASE
CREATE DATABASE alpha;
GO
USE alpha;
GO

-- ==========================================
-- STAGE 1: Independent Tables
-- ==========================================

CREATE TABLE Client (
    Client_id INT PRIMARY KEY IDENTITY(1,1),
    Email VARCHAR(255) NOT NULL UNIQUE,                     -- Constraint: No duplicate emails
    Total_balance DECIMAL(10,2) NOT NULL,
    First_name VARCHAR(50) NOT NULL,
    Last_name VARCHAR(50) NOT NULL,
    
    CONSTRAINT CK_Client_MinBalance CHECK (Total_balance > 1500) -- Constraint: Enforces > 1500 balance
);
GO

CREATE TABLE Asset (
    Ticker_symbol VARCHAR(50) PRIMARY KEY NOT NULL,
    Asset_name VARCHAR(100) NOT NULL UNIQUE,                -- Constraint: Unique asset names
    Current_market_price DECIMAL(10,2) NOT NULL,
    
    CONSTRAINT CK_Asset_Price CHECK (Current_market_price >= 0) -- Constraint: No negative prices
);
GO

CREATE TABLE Advisor (
    emp_id INT PRIMARY KEY IDENTITY(1,1),
    name VARCHAR(255) NOT NULL,
    specialization VARCHAR(255) NOT NULL
);
GO

-- ==========================================
-- STAGE 2: Tables Referencing Stage 1
-- ==========================================

CREATE TABLE Phone_Client (
    client_id INT NOT NULL,
    phone_number VARCHAR(20) NOT NULL,
    PRIMARY KEY (client_id, phone_number),
    FOREIGN KEY (client_id) REFERENCES Client(Client_id) ON DELETE CASCADE
);
GO

CREATE TABLE Portfolio (
    portfolio_id INT PRIMARY KEY IDENTITY(1,1),
    create_date DATE NOT NULL DEFAULT GETDATE(),
    total_value DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    client_id INT NOT NULL,
    emp_id INT NOT NULL,
    FOREIGN KEY (client_id) REFERENCES Client(Client_id),
    FOREIGN KEY (emp_id) REFERENCES Advisor(emp_id)
);
GO

-- ==========================================
-- STAGE 3: Junction/Bridge Table
-- ==========================================

CREATE TABLE Portfolio_Asset (
    portfolio_id INT NOT NULL,
    ticker_symbol VARCHAR(50) NOT NULL,
    quantity INT NOT NULL,
    PRIMARY KEY (portfolio_id, ticker_symbol),
    FOREIGN KEY (portfolio_id) REFERENCES Portfolio(portfolio_id) ON DELETE CASCADE,
    FOREIGN KEY (ticker_symbol) REFERENCES Asset(ticker_symbol),
    
    CONSTRAINT CK_Asset_Quantity CHECK (quantity > 0)       -- Constraint: Must own positive shares
);
GO

-- ==========================================
-- STAGE 4: Transaction Table
-- ==========================================

CREATE TABLE Transaction_Table (
    trans_id INT PRIMARY KEY IDENTITY(1,1),
    transaction_type VARCHAR(50) NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    transaction_date DATETIME2 NOT NULL DEFAULT GETDATE(),
    portfolio_id INT NOT NULL,
    FOREIGN KEY (portfolio_id) REFERENCES Portfolio(portfolio_id),
    
    CONSTRAINT CK_Trans_Type CHECK (transaction_type IN ('BUY', 'SELL', 'DEPOSIT', 'WITHDRAWAL')),
    CONSTRAINT CK_Trans_Amount CHECK (amount > 0)
);
GO
