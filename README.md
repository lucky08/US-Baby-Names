# 📊 Baby Names Analysis (U.S. Social Security Data)

## 📌 Project Overview

This project analyzes **U.S. baby name data from Social Security card applications** spanning **three decades**.  
The goal is to uncover **naming trends over time**, identify **rising and declining baby names**, and explore **regional and gender-based patterns** using **MySQL and Excel dashboards**.

This project demonstrates skills in:

- Data cleaning and aggregation
- SQL analytics (MySQL)
- Excel dashboarding and pivot table analysis
- Trend and regional analysis

---

## 📂 Dataset Description

The raw dataset contains baby name records collected from the **U.S. Social Security Administration**, with the following fields:

- **State** – U.S. state where the name was registered
- **Gender** – Male (M) or Female (F)
- **Year of Birth**
- **Name** – Baby name
- **Count** – Number of babies given that name in that year and state

📈 The dataset covers **30 years** of baby naming data across all U.S. states.

---

## 🛠 Tools & Technologies

- **MySQL** – Data querying, aggregation, and trend analysis
- **Microsoft Excel** – Data visualization, pivot tables, dashboards
- **GitHub** – Project documentation and version control

---

## 🔍 SQL Analysis (MySQL)

Using MySQL, the following analyses were performed:

- Most popular baby names by decade
- Top 20 biggest jumps in name popularity
- Top 20 biggest drops in name popularity
- Trends in unisex names by decade
- Trends in girl names by decade
- Trends in boy names by decade
- Most popular baby names by gender across U.S. regions
- Baby names with peak popularity years by region

All queries focus on uncovering **long-term trends**, **year-over-year changes**, and **regional differences**.

---

## 📊 Excel Dashboard & Visualization

The MySQL database was connected directly to **Excel** to build an interactive dashboard.

### 📌 Pivot Tables

Three main pivot tables were created:

1. **Top Rising Baby Names by Year**
2. **Top Declining Baby Names by Year**
3. **Top Baby Names by Gender & Unisex Name Counts by Decade**

### 📈 Charts & Visualizations

- **2-D Column Chart**  
  _Baby Name Popularity Counts Over Time by Region_
- **2-D Pie Chart**  
  _Top Names per Decade by Total Births_

These visuals allow users to quickly explore naming trends, regional popularity, and gender distribution.

---

## 📁 Project Structure

```
US-BABY-NAMES/
├── data/
│   └── Raw US Baby Names MySQL Dataset
├── sql/
│   └── US Baby Name Analysis.sql
├── excel_dashboard/
│   └── US Baby Name Analysis.xlsx
└── README.md
```

---

## 🎯 Key Insights

- Baby name popularity changes significantly across decades
- Certain names experience sharp rises or drops due to cultural and social trends
- Unisex names have become more common over time
- Regional preferences strongly influence baby name popularity
- Naming trends differ noticeably between boys and girls

---

## 🚀 Future Improvements

- Add data cleaning automation using Python
- Build an interactive dashboard using Power BI or Tableau
- Include predictive modeling for future baby name trends

---

## 📬 Contact

If you have any questions or feedback, feel free to connect!
