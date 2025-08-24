# Netflix Content Analysis Using SQL

## 📌 Overview
This project explores Netflix's content library using SQL queries. The goal is to analyze the `netflix_titles.csv` dataset and answer key business-related questions, such as content trends, genre distribution, and ratings analysis.

## 📂 Repository Structure
- **`netflix_titles.csv`** — Dataset containing Netflix titles (id, type, title, director, cast, country, release year, rating, genre, etc.).  
- **`business_problems.sql`** — File outlining business questions to be answered.  
- **`solutions.sql`** — SQL queries that solve the business problems.

## ❓ Business Questions
1. Which shows and movies rank in the top 10 and bottom 10 based on IMDb scores?  
2. What is the distribution of titles by decade?  
3. How do age certifications relate to average IMDb and TMDb scores?  
4. Which genres are most common for movies and series?  
5. [More questions included in `business_problems.sql`]

## 🛠️ Approach
1. Import `netflix_titles.csv` into a SQL database (MySQL/PostgreSQL).  
2. Review `business_problems.sql` for the questions.  
3. Run queries from `solutions.sql` to generate insights.  
4. Interpret results to understand Netflix content trends.

## ▶️ Usage
Clone the repository:
```bash
git clone https://github.com/Ashish152003/netflix_content_analysis_using_SQL.git
