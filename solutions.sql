--netflix analysis

DROP TABLE IF EXISTS netflix;

CREATE TABLE netflix(
	show_id	VARCHAR(5),
	type VARCHAR(10),
	title VARCHAR(150),
	director VARCHAR(250),
	casts	VARCHAR(1000),
	country	VARCHAR(150),
	date_added	VARCHAR(50),
	release_year INT,
	rating	VARCHAR(10),
	duration VARCHAR(15),
	listed_in VARCHAR(100),
	description VARCHAR(250)
);

SELECT * FROM netflix;

SELECT DISTINCT type FROM netflix;

-- 15 business problems --

--1. Count the Number of Movies vs TV Shows

SELECT
	type , 
	COUNT(*) AS total_number 
FROM netflix 
GROUP BY type;

--2. Find the Most Common Rating for Movies and TV Shows

SELECT 
	type,
	rating
FROM
	(SELECT 
		type,
		rating,
		count(*),
		RANK() OVER (PARTITION BY type ORDER BY COUNT(*) DESC) AS ranking
	FROM netflix
	GROUP BY 1,2
	--ORDER BY 1,3 DESC
	) AS t1
WHERE 
	ranking = 1

--3.List All Movies Released in a Specific Year (e.g., 2020)


SELECT 
	*
FROM netflix 
WHERE type = 'Movie' and release_year = 2020

--4. Find the Top 5 Countries with the Most Content on Netflix

SELECT 
	all_countries,
	total_content
FROM 
	(
	SELECT 
		INITCAP(TRIM(UNNEST(STRING_TO_ARRAY(country,',')))) as all_countries,
		count(*) as total_content
	FROM netflix
	GROUP BY 1
	) AS t1
WHERE 
	all_countries IS NOT NULL
ORDER BY 2 DESC
LIMIT 5;

--5. Identify the Longest Movie

SELECT *
FROM netflix 
WHERE 
	type = 'Movie'
	AND
	duration = (SELECT MAX(duration) FROM netflix);

--6. Find Content Added in the Last 5 Years

SELECT *
FROM netflix
WHERE 
	TO_DATE(date_added,'Month DD, YYYY') >= CURRENT_DATE - INTERVAL '5 years'

--7. Find All Movies/TV Shows by Director 'Rajiv Chilaka'

SELECT *
FROM netflix
WHERE director ILIKE '%Rajiv Chilaka%'

-- 8. List All TV Shows with More Than 5 Seasons


SELECT *
FROM netflix
WHERE 
	type = 'TV Show'
	AND
	SPLIT_PART(duration,' ',1)::numeric > 5;

-- 9. Count the Number of Content Items in Each Genre

SELECT 
	TRIM(UNNEST(STRING_TO_ARRAY(listed_in,','))) AS genre,
	COUNT(*) AS contents
FROM netflix
GROUP BY 1
ORDER BY contents DESC;

--10.Find each year and the average numbers of content release in India on netflix.
-- return top 5 year with highest avg content release!

SELECT
	EXTRACT(YEAR FROM TO_DATE(date_added,'Month DD, YYYY')) AS year,
	COUNT(*) AS yearly_content,
	ROUNd(
		COUNt(*)::numeric/(SELECT COUNT(*) FROM netflix WHERE country = 'India')::numeric
	,2)*100 AS avg_content_per_year
FROM netflix 
WHERE country = 'India'
GROUP BY 1
ORDER BY avg_content_per_year DESC
LIMIT 5;

-- 11. List All Movies that are Documentaries

SELECT * 
FROM netflix
WHERE listed_in LIKE '%Documentaries';

-- 12. Find All Content Without a Director

SELECT * 
FROM netflix
WHERE director IS NULL;

-- 13. Find How Many Movies Actor 'Salman Khan' Appeared in the Last 10 Years

SELECT *
FROM netflix 
WHERE 
	casts ILIKE '%Salman Khan%'
	AND
	release_year > EXTRACT(YEAR FROM CURRENT_DATE) - 10

-- 14. Find the Top 10 Actors Who Have Appeared in the Highest Number of Movies Produced in India	

SELECT 
	TRIM(UNNEST(STRING_TO_ARRAY(casts,','))) AS actors,
	COUNT(*) AS total_movies
FROM netflix
WHERE country ILIKE '%india'
GROUP BY actors
ORDER BY total_movies DESC
LIMIT 10;

--15. Categorize Content Based on the Presence of 'Kill' and 'Violence' Keywords

WITH category_content AS (
SELECT * ,
	CASE
	WHEN 
		description ILIKE '%kill%' OR
		description ILIKE '%violence%' THEN 'bad content'
		ELSE 'good content'
	END AS category
FROM netflix
)
SELECT 
	category,
	COUNT(*) AS total
FROM category_content
GROUP BY 1


	

	

