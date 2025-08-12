---Create and use database
CREATE DATABASE RetailDB;
GO

USE RetailDB;
GO
-- ============================
-- Time Dimension Table
-- Stores information about dates, used for time analysis.
-- The primary key is TimeID, which uniquely identifies each date.
-- ============================
CREATE TABLE TimeDim (
    TimeID INT PRIMARY KEY,           -- Unique identifier for each date 
    FullDate DATE NOT NULL,           -- The full date
    Day INT,                         -- Day of the month 
    Month INT,                       -- Month number 
    Quarter INT,                     -- Quarter of the year 
    Year INT,                       -- Year 
    WeekOfYear INT                  -- Week number in the year 
);
GO

-- ============================c:\Users\Snit Kahsay\Downloads\schema_diagram (3).png
-- Customer Dimension Table
-- Stores details about customers.
-- The primary key is CustomerID.
-- ============================
CREATE TABLE CustomerDim (
    CustomerID INT PRIMARY KEY,        -- Unique identifier for each customer
    CustomerName NVARCHAR(100),        -- Customer's full name
    Email NVARCHAR(100),               -- Customer email address
    Gender NVARCHAR(10),               -- Gender ( Male, Female, Other)
    Age INT,                          -- Age of the customer
    Country NVARCHAR(50),             -- Customer's country
    City NVARCHAR(50),                -- Customer's city
    CustomerSince DATE                -- Date when customer registered/first purchase
);
GO

-- ============================
-- Product Dimension Table
-- Stores product information.
-- The primary key is ProductID.
-- ============================
CREATE TABLE ProductDim (
    ProductID INT PRIMARY KEY,         -- Unique identifier for each product
    StockCode NVARCHAR(50),            -- Product stock code
    ProductName NVARCHAR(100),         -- Name of the product
    Category NVARCHAR(50),             -- Category of the product (e.g., Electronics, Clothing)
    Brand NVARCHAR(50),                -- Brand name
    UnitCost MONEY                    -- Cost price of the product
);
GO

-- ============================
-- Store Dimension Table
-- Stores information about store locations or sales channels.
-- The primary key is StoreID.
-- ============================
CREATE TABLE StoreDim (
    StoreID INT PRIMARY KEY,           -- Unique identifier for each store
    StoreName NVARCHAR(100),           -- Name of the store
    Channel NVARCHAR(50),              -- Sales channel (e.g., Online, Retail, Wholesale)
    Country NVARCHAR(50),              -- Country where the store operates
    Region NVARCHAR(50),               -- Region within the country
    City NVARCHAR(50)                 -- City where the store is located
);
GO

-- ============================
-- Fact Table: Sales
-- Records each sale transaction.
-- Contains foreign keys to all dimension tables.
-- Measures include quantity sold, price, discounts, and total sales.
-- ============================
CREATE TABLE FactSales (
    SaleID INT PRIMARY KEY IDENTITY(1,1), -- Unique sale transaction ID (auto-increment)
    InvoiceNo NVARCHAR(50),                -- Invoice number for the sale
    InvoiceDate DATE,                      -- Date of invoice
    TimeID INT,                           -- Foreign key to TimeDim
    ProductID INT,                        -- Foreign key to ProductDim
    CustomerID INT,                       -- Foreign key to CustomerDim
    StoreID INT,                         -- Foreign key to StoreDim
    Quantity INT,                        -- Number of units sold
    UnitPrice MONEY,                     -- Price per unit sold
    Discount MONEY DEFAULT 0,            -- Discount applied on sale (if any)
    TotalSales MONEY,                    -- Total sale amount after discount
    FOREIGN KEY (TimeID) REFERENCES TimeDim(TimeID),
    FOREIGN KEY (ProductID) REFERENCES ProductDim(ProductID),
    FOREIGN KEY (CustomerID) REFERENCES CustomerDim(CustomerID),
    FOREIGN KEY (StoreID) REFERENCES StoreDim(StoreID)
);
GO