/* The most popular baby names of each decade */
WITH name_by_decade AS (
	SELECT
		FLOOR(Year / 10) * 10 AS Decade,
        Name,
        SUM(Births) AS Total_Births
	FROM names
	GROUP BY Decade, Name
),
rank_names AS (
	SELECT *,
		RANK() OVER (PARTITION BY Decade ORDER BY Total_Births DESC) AS RNK
	FROM name_by_decade
)
SELECT 
	Decade,
    Name,
    Total_Births
FROM rank_names
WHERE RNK = 1;

/* The top 20 biggest jump baby names in popularity */
WITH yearly_totals AS (
  SELECT Year, Name, SUM(Births) AS Total_Births
  FROM names
  GROUP BY Year, Name
),
with_diff AS (
  SELECT *,
         LAG(Total_Births) OVER (PARTITION BY Name ORDER BY Year) AS Prev_Year_Births
  FROM yearly_totals
)
SELECT Year, Name,
       Total_Births - Prev_Year_Births AS Jump_In_Births
FROM with_diff
WHERE Prev_Year_Births IS NOT NULL
AND Total_Births > Prev_Year_Births
ORDER BY Jump_In_Births DESC
LIMIT 20;

/* The top 20 biggest drop baby names in popularity */
WITH yearly_totals AS (
	SELECT Year, Name, SUM(Births) AS Total_Births
    FROM names
    GROUP BY Year, Name
),
with_diff AS (
	SELECT *,
		LAG(Total_Births) OVER (PARTITION BY Name ORDER BY Year) AS Prev_Year_Births
	FROM yearly_totals
)
SELECT Year, Name, Total_Births - Prev_Year_Births AS Drop_In_Births, ABS(Total_Births - Prev_Year_Births) AS Drop_In_Births_Abs
FROM with_diff
WHERE Prev_Year_Births IS NOT NULL
AND Total_Births < Prev_Year_Births
ORDER BY Drop_In_Births ASC
LIMIT 20;

/* Trends in unisex names over decade */
WITH name_gender_year AS (
  SELECT FLOOR(Year / 10) * 10 AS Decade, Name, Gender, SUM(Births) AS Total_Births
  FROM names
  GROUP BY FLOOR(Year / 10) * 10, Name, Gender
),
pivoted AS (
  SELECT Decade, Name,
         SUM(CASE WHEN Gender = 'M' THEN Total_Births ELSE 0 END) AS Male_Births,
         SUM(CASE WHEN Gender = 'F' THEN Total_Births ELSE 0 END) AS Female_Births
  FROM name_gender_year
  GROUP BY Decade, Name
)
SELECT Decade, Name AS Unisex_Name, Male_Births, Female_Births,
       ROUND(Female_births / (Male_births + Female_births), 2) AS Female_Ratio
FROM pivoted
WHERE Male_Births > 0 AND Female_Births > 0
ORDER BY Decade, Name;

/* Trends in girl names over decade */
WITH name_gender_year AS (
	SELECT FLOOR(Year / 10) * 10 AS Decade, Gender, Name, SUM(Births) AS Total_Births
    FROM names
    GROUP BY FLOOR(Year / 10) * 10, Name, Gender
),
pivot AS (
	SELECT Decade, Name, SUM(CASE WHEN Gender = 'F' THEN Total_Births ELSE 0 END) AS Female_Births,
    SUM(CASE WHEN Gender = 'M' THEN Total_Births ELSE 0 END) AS Male_Births
    FROM name_gender_year
    GROUP BY Decade, Name
)
SELECT Decade, Name AS Girl_Name, Female_Births, Male_Births
FROM pivot
WHERE Female_Births > 0 AND (Male_Births IS NULL OR Male_Births <=0)
ORDER BY Decade, Name;

/* Trends in boy names over decade */
WITH name_gender_year AS (
	SELECT FLOOR(Year / 10) * 10 AS Decade, Gender, Name, SUM(Births) AS Total_Births
    FROM names
    GROUP BY FLOOR(Year / 10) * 10, Name, Gender
),
pivot AS (
	SELECT Decade, Name, SUM(CASE WHEN Gender = 'F' THEN Total_Births ELSE 0 END) AS Female_Births,
    SUM(CASE WHEN Gender = 'M' THEN Total_Births ELSE 0 END) AS Male_Births
    FROM name_gender_year
    GROUP BY Decade, Name
)
SELECT Decade, Name AS Boy_Name, Male_Births, Female_Births
FROM pivot
WHERE Male_Births > 0 AND (Female_Births IS NULL OR Female_Births <=0)
ORDER BY Decade, Name;

/* Most popular baby names by gender in different regions */
WITH region_gender_total AS (
	SELECT r.Region, n.Gender, n.Name, SUM(n.Births) AS TotalBirths
    FROM names n
    JOIN regions r
    ON n.State = r.State
    Group By r.Region, n.Name, n.Gender
),
region_gender_rank AS (
	SELECT *,
		RANK() OVER(PARTITION BY Region, Gender ORDER BY TotalBirths DESC) AS RNK
	FROM region_gender_total
)
SELECT Region, Name, Gender, TotalBirths, RNK 
FROM region_gender_rank
WHERE RNK = 1;

/* Baby names with the most popular years by region */
WITH region_gender_year_total AS (
	SELECT n.Year, r.Region, n.Gender, n.Name, SUM(n.Births) AS TotalBiriths
    FROM names n
    JOIN regions r
    ON  n.State = r.State
    GROUP BY r.Region, n.Name, n.Gender, n.Year
)
SELECT Region, Name, COUNT(DISTINCT Year) AS PopularityDuration
FROM region_gender_year_total
GROUP BY Region, Name
Having PopularityDuration > 29
ORDER BY Region, Name ASC;

