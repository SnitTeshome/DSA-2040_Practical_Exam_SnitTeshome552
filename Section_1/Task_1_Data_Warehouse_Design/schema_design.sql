-- ============================
-- Time Dimension Table
-- Stores information about dates, used for time analysis.
-- The primary key is TimeID, which uniquely identifies each date.
-- ============================
CREATE TABLE TimeDim (
    TimeID INTEGER PRIMARY KEY,           -- Unique identifier for each date 
    FullDate TEXT NOT NULL,               -- The full date
    Day INTEGER,                           -- Day of the month 
    Month INTEGER,                         -- Month number 
    Quarter INTEGER,                       -- Quarter of the year 
    Year INTEGER,                          -- Year 
    WeekOfYear INTEGER                     -- Week number in the year 
);

-- ============================
-- Customer Dimension Table
-- Stores details about customers.
-- The primary key is CustomerID.
-- ============================
CREATE TABLE CustomerDim (
    CustomerID INTEGER PRIMARY KEY,        -- Unique identifier for each customer
    CustomerName TEXT,                     -- Customer's full name
    Email TEXT,                             -- Customer email address
    Gender TEXT,                            -- Gender (Male, Female, Other)
    Age INTEGER,                            -- Age of the customer
    Country TEXT,                           -- Customer's country
    City TEXT,                              -- Customer's city
    CustomerSince TEXT                      -- Date when customer registered/first purchase
);

-- ============================
-- Product Dimension Table
-- Stores product information.
-- The primary key is ProductID.
-- ============================
CREATE TABLE ProductDim (
    ProductID TEXT PRIMARY KEY,        -- change INTEGER → TEXT to allow alphanumeric IDs
    StockCode TEXT,                    -- keep TEXT
    ProductName TEXT,                  -- keep TEXT
    Category TEXT,                     -- keep TEXT
    Brand TEXT,                        -- keep TEXT
    UnitCost REAL                      -- keep REAL (float)
);

-- ============================
-- Store Dimension Table
-- Stores information about store locations or sales channels.
-- The primary key is StoreID.
-- ============================
CREATE TABLE StoreDim (
    StoreID INTEGER PRIMARY KEY,           -- Unique identifier for each store
    StoreName TEXT,                         -- Name of the store
    Channel TEXT,                           -- Sales channel (e.g., Online, Retail, Wholesale)
    Country TEXT,                           -- Country where the store operates
    Region TEXT,                            -- Region within the country
    City TEXT                               -- City where the store is located
);

-- ============================
-- Fact Table: Sales
-- Records each sale transaction.
-- Contains foreign keys to all dimension tables.
-- Measures include quantity sold, price, discounts, and total sales.
-- ============================
CREATE TABLE FactSales (
    SaleID INTEGER PRIMARY KEY AUTOINCREMENT, -- Unique sale transaction ID (auto-increment)
    InvoiceNo TEXT,                            -- Invoice number for the sale
    InvoiceDate TEXT,                          -- Date of invoice
    TimeID INTEGER,                            -- Foreign key to TimeDim
    ProductID INTEGER,                         -- Foreign key to ProductDim
    CustomerID INTEGER,                        -- Foreign key to CustomerDim
    StoreID INTEGER,                           -- Foreign key to StoreDim
    Quantity INTEGER,                           -- Number of units sold
    UnitPrice REAL,                             -- Price per unit sold
    Discount REAL DEFAULT 0,                    -- Discount applied on sale (if any)
    TotalSales REAL,                            -- Total sale amount after discount
    FOREIGN KEY (TimeID) REFERENCES TimeDim(TimeID),
    FOREIGN KEY (ProductID) REFERENCES ProductDim(ProductID),
    FOREIGN KEY (CustomerID) REFERENCES CustomerDim(CustomerID),
    FOREIGN KEY (StoreID) REFERENCES StoreDim(StoreID)
);
