# DSA-2040_Practical_Exam_SnitTeshome552

## *Overview*
This repository contains my submission for the *DSA 2040 End Semester Practical Exam (2025)*. The exam covers *Data Warehousing* and *Data Mining* tasks. All code is implemented in Python, using libraries such as *pandas, numpy, scikit-learn, sqlite3*, and *matplotlib*. SQL queries are executed using *SQLite*.

---

## *Project Folder Structure*

```plaintext

DSA-2040_Practical_Exam_SnitTeshome552/
├── Section_1/
│   ├── Task_1_DataWarehouse_Design.sql
│   ├   ├── schema_diagram.png
│   ├   └── schema_design.sql
│   ├── Task_2_ETL_Process_Implementation/
│   │   ├── etl_retail.py
│   │   ├── retail_dw.db
│   │   └── synthetic_data/             ← CSVs if generated
│   └── Task_3_OLAP_Queries_and_Analysis/
│       ├── olap_queries.sql
│       ├── total_sales_by_Country.png
│       └── analysis_report.md
├── Section_2/
│   ├── preprocessing_iris.py    
│   ├── clustering_iris.py
│   ├── mining_iris_basket.ipynb
│   ├── iris.ipynb
│   └── train_test/                     ← Train/test CSV splits
├── Visualization/
│   └── *.png                           ← Additional visualizations
└── README.md
                                  # This file
````
# *Section 1: Data Warehousing (50 Marks)*
## *Task 1: Data Warehouse Design (15 Marks)*


### *1.Design a star schema for this data warehouse.*
### *Star Schema Diagram:`Usingdbdiagram.io`*
![alt text](Section_1/Task_1_Data_Warehouse_Design/schema_diagram.png)

## *2. Explain why you chose star schema over snowflake (2-3 sentences).*


A *Star Schema* is a data warehousing design where a central *fact table* containing measurable metrics (e.g., sales amount, quantity sold) is directly linked to multiple *dimension tables* containing descriptive attributes (e.g., product category, customer demographics, time period, store location). The schema visually resembles a star, with the fact table at the center and the dimensions radiating outward.

### *Why Star Schema is Used in This Assignment*

- **_Simplified Querying_**  
  - *Direct links between the fact table and dimension tables reduce query complexity.*  
  - *Eliminates multiple joins from normalization, making analytical queries (e.g., total sales per quarter by category) faster to write and interpret.*  

- **_Optimized for OLAP_**  
  - *Purpose-built for Online Analytical Processing tasks.*  
  - *Supports aggregation, filtering, drill-down, and slicing efficiently — matching the assignment’s sales, inventory, and demographic analysis needs.*  

- **_High Aggregation Performance_**  
  - *Small, denormalized dimension tables speed up joins with the fact table.*  
  - *Outperforms snowflake schemas that require multiple join operations for analysis.*  

- **_Ease of Maintenance & Scalability_**  
  - *New facts (e.g., returns, shipments) or expanded dimensions can be added without major redesign.*  
  - *Suitable for growing retail datasets with evolving requirements.*  

- **_Clear Business Representation_**  
  - *Dimensions directly map to real-world entities (Product, Customer, Time, Store).*  
  - *Both technical teams and business analysts can quickly understand and use the model.*  

----
### *3.Write SQL CREATE TABLE statements for the fact and dimension tables*

### *Full Schema Code Location*

The *complete schema creation scripts* (including all dimension tables) and the schema diagram are located in:

```
Section_1/
├── Task_1_DataWarehouse_Design.sql
    └── schema_design.sql
```

---

### *Dimension Tables Defined in the Folder*

*These dimension tables are fully defined inside the SQL scripts above:*

- *TimeDim* – Stores date-related attributes for temporal analysis.  
- *CustomerDim* – Stores customer details such as name, contact info, and demographics.  
- *ProductDim* – Stores product details including category, brand, and cost.  
- *StoreDim* – Stores store or sales channel details including location and region.  
### *Data Warehouse Schema – Fact Table Sample*
The *FactSales* table links to these dimensions for analytical queries such as roll-up, drill-down, and slicing.


```sql
CREATE TABLE FactSales (
    SaleID INT PRIMARY KEY IDENTITY(1,1),
    InvoiceNo NVARCHAR(50),
    InvoiceDate DATE,
    TimeID INT,
    ProductID INT,
    CustomerID INT,
    StoreID INT,
    Quantity INT,
    UnitPrice MONEY,
    Discount MONEY DEFAULT 0,
    TotalSales MONEY,
    FOREIGN KEY (TimeID) REFERENCES TimeDim(TimeID),
    FOREIGN KEY (ProductID) REFERENCES ProductDim(ProductID),
    FOREIGN KEY (CustomerID) REFERENCES CustomerDim(CustomerID),
    FOREIGN KEY (StoreID) REFERENCES StoreDim(StoreID)
);
```
## *Task_2_ETL_Process_Implementation*
### *Dataset Description*

The dataset used is the *Online Retail* dataset from the *UCI ML Repository*. It contains *transactional data for a UK-based online store*, consisting of approximately *500,000 transactions*.

The dataset includes the following columns:

* *InvoiceNo*: the *unique invoice number for each transaction*.
* *StockCode*: the *unique product identifier*.
* *Description*: the *product description or name*.
* *Quantity*: the *quantity of items in each transaction*.
* *InvoiceDate*: the *date and time of the transaction*.
* *UnitPrice*: the *price per unit of the product*.
* *CustomerID*: the *unique identifier for each customer*.
* *Country*: the *country of the customer*.

This dataset provides detailed transactional records suitable for building a *retail data warehouse* including dimensions for customers, products, stores, time, and a fact table for sales.

---

## *Synthetic Data Generation Activities*

Since the dataset could be generated synthetically, the following steps were performed to create a realistic retail dataset:

1. *Customer Dimension*:

   * Generated *100 unique customers* with *synthetic names* created by hashing `CustomerID`.
   * Assigned *gender* randomly from Male, Female, or Other.
   * Assigned *age* randomly between 18 and 75.
   * Generated *cities* using the Faker library based on customer country.

2. *Store Dimension*:

   * Created *5–10 unique stores* corresponding to distinct countries.
   * Assigned *store names* based on country (e.g., “Online Store – UK”).
   * Assigned *channel* as Online.
   * Generated *city locations* using Faker locales.

3. *Product Dimension*:

   * Generated *unique products* with `StockCode`, `Description`, and `UnitCost`.
   * Categorized products (e.g., Electronics, Clothing, Books, Toys & Games).
   * Assigned *synthetic brand names* using Faker company names.

4. *Time Dimension*:

   * Extracted unique *invoice dates* and normalized them.
   * Generated *TimeID* (YYYYMMDD format) and additional attributes: Day, Month, Quarter, Year, WeekOfYear.

5. *FactSales Table*:

   * Generated *transactional records* linking customers, products, stores, and time.
   * Computed *TotalSales = Quantity × UnitPrice*.
   * Assigned *InvoiceNo*, `InvoiceDate`, `Quantity`, `UnitPrice`, `Discount` (default 0), and foreign keys (CustomerID, ProductID, StoreID, TimeID).

```python
fake = Faker()
# Extract unique products from the original dataset: StockCode, Description, UnitPrice.
product_dim = df[['StockCode', 'Description', 'UnitPrice']].drop_duplicates().copy()

# Rename columns to fit dimensional model schema
product_dim = product_dim.rename(columns={
    'StockCode': 'ProductID',
    'Description': 'ProductName',
    'UnitPrice': 'UnitCost'
})

# Define a simple function to categorize products based on keywords in ProductName
def categorize_product(name):
    if pd.isna(name):
        return 'Miscellaneous'
    name = name.lower()
    if any(keyword in name for keyword in ['electronic', 'computer', 'usb', 'laptop', 'cable']):
        return 'Electronics'
    elif any(keyword in name for keyword in ['shirt', 'clothing', 'dress', 't-shirt', 'jeans']):
        return 'Clothing'
    elif any(keyword in name for keyword in ['book', 'novel', 'journal']):
        return 'Books'
    elif any(keyword in name for keyword in ['toy', 'game']):
        return 'Toys & Games'
    else:
        return 'Miscellaneous'

# Apply the category function to create a Category column
product_dim['Category'] = product_dim['ProductName'].apply(categorize_product)

# Generate a synthetic Brand name using Faker company names for each product
product_dim['Brand'] = [fake.company() for _ in range(len(product_dim))]

```
---

## *Retail Data Warehouse: Dataset and ETL Overview*

*The dataset used is the Online Retail dataset from the UCI ML Repository, containing transactional data (\~500,000 rows) for a UK-based online store. Columns include `InvoiceNo` (unique invoice), `StockCode` (product ID), `Description` (product name), `Quantity`, `InvoiceDate`, `UnitPrice`, `CustomerID`, and `Country`. To enrich the data for dimensional analysis, synthetic attributes were generated: customer names (hashed IDs), cities (Faker library), genders, ages, product categories, and brands, while store information was derived from countries with synthetic city assignments. Dates were normalized and shifted to simulate current transactions (2024–2025).*

*The ETL pipeline was implemented in a single master function `etl_retail()`, orchestrating Extraction, Transformation, and Loading with logging enabled to track progress.*

1. **Extraction**
   *Loaded CSV files for `FactSales`, `CustomerDim`, `StoreDim`, `ProductDim`, and `TimeDim`. Converted `InvoiceDate` to datetime and filtered invalid rows.*

2. **Transformation**
   *FactSales: filtered negative/zero quantities and prices; computed `TotalSales`. Dimensions: removed duplicates, ensured proper ID types. Products: categorized by keywords and generated synthetic brands. TimeDim: extracted unique dates and created day, month, quarter, year, and week attributes.*

3. **Load**
   *Applied the database schema from `schema_design.sql` and inserted transformed DataFrames into SQLite database `retail_dw.db`. FactSales loaded fully; dimension tables loaded using `INSERT OR IGNORE` to prevent duplicates.*

4. **Verification**
   *Connected to the database and confirmed tables: `TimeDim`, `CustomerDim`, `ProductDim`, `StoreDim`, `FactSales`. Queried sample rows from `FactSales` to ensure correctness.*

*Summary: The ETL process efficiently moves raw and enriched data into a structured data warehouse, producing cleaned, integrated, and analysis-ready tables while logging each step for reproducibility and traceability.*

## *Out-put of loading*

![alt text](Section_1/Task_2_ETL_Process_Implementation/Out_put_Screenshoot/image1.png)

![text](Section_1/Task_2_ETL_Process_Implementation/Out_put_Screenshoot/image.png)
---

## *Task_3 _OLAP _Queries and Analysise*

*The OLAP analysis was performed on the `retail_dw.db` database to demonstrate multidimensional exploration of sales data. A series of operations—Roll-up, Drill-down, and Slice—were executed, followed by visualizing aggregated results.*

---

### *1. Roll-up — Total Sales by Country and Quarter*

* Aggregated total sales from the `FactSales` table by joining `CustomerDim` and `TimeDim`.
* Grouped data by `Country`, `Year`, and `Quarter` to produce quarterly totals per country.
* This summarized data provides insights into high-level trends across countries and time periods.

![alt text](<Section_1/Task_3 _OLAP _Queries and Analysis/Queries_output/image-1.png>)
### *2. Drill-down — Sales Details for a Specific Country*

* Focused on `United Kingdom` to observe monthly sales trends.
* Joined `FactSales`, `CustomerDim`, and `TimeDim` tables.
* Aggregated sales by month (`YearMonth`) to explore detailed temporal patterns within a single country.


![alt text](<Section_1/Task_3 _OLAP _Queries and Analysis/Queries_output/image.png>)

---

### *Monthly Sales Trend for United Kingdom (Drill-down)*

The `YearMonth` column represents each month from December 2024 to April 2025, and `TotalSales` shows the total revenue for that month.

**Interpretation:**

* **2024-12:** \$498,661.85 — December has the highest sales in this period, likely due to holiday shopping.
* **2025-01:** \$442,190.06 — Sales dropped after December, which is typical post-holiday.
* **2025-02:** \$355,655.63 — February sees the lowest sales, suggesting seasonal slowdown.
* **2025-03:** \$467,198.59 — Sales rebound in March, possibly due to promotions or spring demand.
* **2025-04:** \$409,559.14 — Slight dip compared to March, but still higher than February, indicating a recovering trend.

**Insight:**

*Sales fluctuate month to month, peaking in December, dropping in February, and showing a recovery trend in March–April. This pattern can guide inventory planning, marketing campaigns, and sales forecasting for the UK market.*

---

### *3. Slice — Total Sales for Electronics Category*

* Isolated transactions belonging to the `Electronics` category from `ProductDim`.
* Summed `TotalSales` to analyze category-specific performance.
* Provides a focused view of sales contribution from a particular product segment.
![alt text](<Section_1/Task_3 _OLAP _Queries and Analysis/Queries_output/image-2.png>)



---

### *Product Category Overview*

*The `ProductDim` table contains the following categories:*

*1. **Miscellaneous** — Products that don’t fit into specific categories.*

*2. **Toys & Games** — Play items and entertainment products.*

*3. **Clothing** — Apparel items like shirts, dresses, etc.*

*4. **Books** — Printed or digital reading materials.*

*5. **Electronics** — Gadgets, computer accessories, and related devices.*

---

### *Total Sales for Electronics*

*The total sales for the **Electronics** category is **\$33.88**, which is extremely low compared to overall sales.*

*Interpretation:*

* *Electronics contributed negligibly to the total revenue, suggesting low demand, limited inventory, or under-representation in the dataset.*
* *This indicates that marketing or stock adjustments might be needed if Electronics are a strategic product line.*

---


### *4. Visualization — Top 10 Countries by Total Sales*

* Bar chart created using `Seaborn` to show top 10 countries ranked by total sales.
* Y-axis formatted as currency; value labels added on bars for clarity.
* Observations:

![alt text](<Section_1/Task_3 _OLAP _Queries and Analysis/Queries_output/image-3.png>)

---
### *Insights*
### *Top 10 Countries by Total Sales*

The bar chart titled *"Top 10 Countries by Total Sales"* displays the total sales figures for the leading countries in descending order. Here's a breakdown of the key insights:

1. *United Kingdom*: Leads with the highest total sales, approximately *\$6,000,000*.
2. *Netherlands*: Follows with sales around *\$5,000,000*.
3. *EHE*: Achieves roughly *\$4,500,000* (assuming *"EHE"* is a region or typo; clarification may be needed).
4. *Germany*: Close behind with about *\$4,000,000*.
5. *France*: Sales near *\$3,500,000*.
6. *Australia*: Around *\$3,000,000*.
7. *Spain*: Approximately *\$2,500,000*.
8. *Switzerland*: Roughly *\$2,000,000*.
9. *Belgium*: Slightly under *\$1,500,000*.
10. *Sweden*: The lowest in the top 10, just above *\$1,000,000*.

### *Observations*

* *Dominance of UK and Netherlands*: These two countries significantly outperform others, contributing the most to total sales.
* *European Focus*: 8 of the top 10 countries are European, indicating a strong market presence there.
* *Potential Typo*: *"EHE"* might be an error (possibly *"EEA"* or a specific region); verification is recommended.

### *Actionable Insights*

* *Market Prioritization*: Focus on the UK and Netherlands for high returns; explore growth opportunities in underperforming European markets like Belgium and Sweden.
* *Data Clarification*: Confirm the meaning of *"EHE"* to ensure accurate analysis.



---



## *Instructions to Run*

1. Clone the repository:

```bash
git clone https://github.com/<YourUsername>/DSA-2040_Practical_Exam_SnitTeshome552.git
cd DSA-2040_Practical_Exam_SnitTeshome552
````

2. For *Data Warehousing Tasks*:

   * Run the SQL scripts in SQLite or your preferred SQL client.
   * Execute `etl_retail.py` to load the CSV or generated data into `retail_dw.db`.
   * Visualizations are saved in `Visualization/` or as indicated in each task folder.

3. For *Data Mining Tasks*:

   * Run `preprocessing_iris.py` first to preprocess and split the Iris dataset.
   * Execute `clustering_iris.py` for clustering experiments and visualizations.
   * Execute `mining_iris_basket.ipynb` for Decision Tree classification, KNN comparison, and Association Rule Mining with Apriori.

4. Ensure required libraries are installed:

```bash
pip install pandas numpy matplotlib scikit-learn seaborn mlxtend
```

---

## *Notes*

* All synthetic data is reproducible using provided scripts.
* Analysis reports are included in Markdown or Notebook comments.
* Outputs (plots, tables) are saved in designated folders or embedded in notebooks.
* Any missing or partial outputs are included to demonstrate attempted work for partial credit.

---

## *Author*

*Snit Teshome*
*DSA 2040 – USIU-A 2025*




