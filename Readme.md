#  Airline Data ETL Pipeline

##  Project Overview
This project extracts, transforms, and loads **airline data** into a **MySQL database** for further analysis in **Tableau**. The ETL pipeline is built using **Python (pandas, SQLAlchemy)** and runs inside a **Jupyter Notebook**.

##  Technologies Used
- **Python** (pandas, SQLAlchemy, pymysql)
- **MySQL Database**
- **Jupyter Notebook**
- **Tableau** (for visualizations)
- **MySQL Workbench** (optional, for manual database inspection)
- **GitHub** (for version control)
- **Logging** (to track ETL execution in `etl_monitoring.log`)

##  ETL Process
### **1️ Extract**
- The dataset is imported into Python and stored in a **pandas DataFrame**.
- The data is read from a CSV file and loaded into **MySQL**.

### **2️ Transform**
The following **SQL transformations** were applied:
- **Data Cleaning**: Removing null values and standardizing data formats.
- **Age Categorization**: Grouping passengers into **Adults, Teens, Children, and Seniors**.
- **Time-Based Aggregation**: Aggregating flight data by **month**.
- **Data Normalization**: Ensuring consistency across multiple records.

 **Example SQL Query:**
```sql
SELECT 
    CASE 
        WHEN age >= 60 THEN 'Senior'
        WHEN age >= 18 THEN 'Adult'
        WHEN age >= 13 THEN 'Teen'
        ELSE 'Child'
    END AS age_group,
    COUNT(*) AS num_flights
FROM airline_data_cleaned
GROUP BY age_group;
```

### **3️ Load**
- The transformed data is stored in a **MySQL database table** named `airline_data_cleaned`.
- The data is made available for visualization in **Tableau**.

##  Tableau Dashboard
- Users can explore insights like:
  -  **Number of flights by passenger age groups** (Adults, Teens, Children, Seniors).
  -  **Flights per month** (time-based trends).
  -  **Other key metrics** related to airline performance.

The **Tableau dashboard** will be made **public** soon. 🔗 **(Link coming soon!)**

##  How to Run This Project
### **1️ Prerequisites**
Make sure you have:
- **Python** installed (`pandas`, `sqlalchemy`, `pymysql`)
- **MySQL Server** installed and running
- **Jupyter Notebook** installed
- (Optional) **MySQL Workbench** for database management

### **2️ Steps to Run**
1. Clone this repository:
   ```bash
   git clone https://github.com/gerardcf1/airlinesql.git
   cd airlinesql
   ```
2. Install required Python libraries:
   ```bash
   pip install pandas sqlalchemy pymysql
   ```
3. Start **MySQL Server** and create the database:
   ```sql
   CREATE DATABASE airline_db;
   ```
4. Open **Jupyter Notebook** and run `Final Project Queries.ipynb`
   - This will **extract**, **transform**, and **load** the dataset into MySQL.

##  Monitoring & Logging
- The ETL pipeline **logs every step** in `etl_monitoring.log`.
- This helps track failures, execution time, and status updates.

##  Project Structure
```
 airlinesql
 ┣  Final Project Queries.ipynb   # Jupyter Notebook with ETL code
 ┣  transformations.sql            # SQL queries for transformations
 ┣  README.md                      # Project documentation
 ┣  etl_monitoring.log             # Log file tracking ETL execution
 ┗  design_document.pdf            # Final project design document (coming soon)
---

## Contact
If you have any questions, feel free to reach out!  


---
