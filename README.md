# DSA-2040_Practical_Exam_SnitTeshome552

## *Overview*
This repository contains my submission for the *DSA 2040 End Semester Practical Exam (2025)*. The exam covers *Data Warehousing* and *Data Mining* tasks. All code is implemented in Python, using libraries such as *pandas, numpy, scikit-learn, sqlite3*, and *matplotlib*. SQL queries are executed using *SQLite*.

---

## *Repository Structure*

```

DSA-2040\_Practical\_Exam\_SnitTeshome552/
│
├─ Section\_1/
│  ├─ Task\_1\_DataWarehouse\_Design.sql           # SQL scripts for schema creation
│  ├─ Task\_1\_Star\_Schema\_Diagram.png           # Star schema diagram
│  ├─ Task\_2\_ETL\_Process\_Implementation/
│  │   ├─ etl\_retail.py                        # ETL Python script
│  │   ├─ retail\_dw\.db                          # SQLite database (fact & dimension tables)
│  │   └─ synthetic\_data/                       # CSVs if generated
│  └─ Task\_3\_OLAP\_Queries\_and\_Analysis/
│      ├─ olap\_queries.sql                      # Roll-up, Drill-down, Slice queries
│      ├─ total\_sales\_by\_Country.png            # Example visualization
│      └─ analysis\_report.md                    # Short report of OLAP insights
│
├─ Section\_2/
│  ├─ preprocessing\_iris.py                     # Iris dataset preprocessing
│  ├─ clustering\_iris.py                        # K-Means clustering implementation
│  ├─ mining\_iris\_basket.ipynb                  # Classification + Association Rule Mining
│  ├─ iris.ipynb                                # Original Iris exploration notebook
│  └─ train\_test/                               # Train/test CSV splits
│
├─ Visualization/
│  └─ \*.png                                     # Additional visualizations if any
│
└─ README.md                                   # This file

````

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




