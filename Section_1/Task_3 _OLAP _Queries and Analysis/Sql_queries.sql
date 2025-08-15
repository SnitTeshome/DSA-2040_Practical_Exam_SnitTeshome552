-- ======================================================
-- Step 1: Roll-up — Total Sales by Country and Quarter
-- ======================================================
SELECT 
    c.Country,
    t.Year,
    t.Quarter,
    SUM(f.TotalSales) AS TotalSales
FROM FactSales f
JOIN CustomerDim c ON f.CustomerID = c.CustomerID
JOIN TimeDim t ON f.TimeID = t.TimeID
GROUP BY c.Country, t.Year, t.Quarterg
ORDER BY c.Country, t.Year, t.Quarter;


-- ======================================================
-- Step 2: Drill-down — Sales Details for a Specific Country by Month
-- Replace 'United Kingdom' with any country as needed
-- ======================================================
SELECT 
    t.Year || '-' || printf('%02d', t.Month) AS YearMonth,
    SUM(f.TotalSales) AS TotalSales
FROM FactSales f
JOIN CustomerDim c ON f.CustomerID = c.CustomerID
JOIN TimeDim t ON f.TimeID = t.TimeID
WHERE c.Country = 'United Kingdom'
GROUP BY YearMonth
ORDER BY YearMonth;


-- ======================================================
-- Step 3: Slice — Total Sales for Electronics Category
-- ======================================================
SELECT 
    SUM(f.TotalSales) AS TotalSales
FROM FactSales f
JOIN ProductDim p ON f.ProductID = p.ProductID
WHERE p.Category = 'Electronics';


-- ======================================================
-- Step 4: List of Categories (optional for validation)
-- ======================================================
SELECT DISTINCT Category
FROM ProductDim;


-- ======================================================
-- Step 5: Top 10 Countries by Total Sales
-- ======================================================
SELECT 
    Country,
    SUM(TotalSales) AS TotalSales
FROM FactSales f
JOIN CustomerDim c ON f.CustomerID = c.CustomerID
GROUP BY Country
ORDER BY TotalSales DESC
LIMIT 10;
