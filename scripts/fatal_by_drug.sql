use opiate

SELECT * FROM fatal
-- fatal od by drugs and year 
select 
drug_type, 
sum(value) as total_deaths,
year
FROM fatal
WHERE drug_type NOT LIKE '%All%' and value_type = 'Count'
group by year, drug_type
order by total_deaths DESC

-- non fatal od by drugs and year 
select * from non_fatal_clean1

select 
drug_type, 
sum(total_non_fatal) as total_od,
year
FROM non_fatal_clean1
WHERE drug_type NOT LIKE '%All%' and value_type = 'Count' 
group by year, drug_type
order by total_od DESC

-- fatal od by county and drug 
select 
Geography,
drug_type, 
sum(value) as total_deaths,
year
FROM fatal
WHERE drug_type NOT LIKE '%All%' AND GeographyType = 'County' AND value_type = 'Count'
group by year, drug_type, Geography
order by total_deaths DESC

-- TOP 5 counties fatal 
  with rate as (SELECT 
   f.year, 
   f.Geography as county, 
   f.drug_type,
   f.value,
	p.total_pop,
  ROUND(f.value/p.total_pop * 1000,2) as rate_per_1000  
  FROM fatal as f
  left join pop_inc as p
  on f.Geography=p.county and f.year=p.year 
  WHERE drug_type NOT LIKE '%All_%' AND p.year >=2017 and value_type= 'Count'),
		rnk as (select 
            year, 
            county, 
            drug_type,
            rate_per_1000,
             RANK() OVER(PARTITION BY Year ORDER BY rate_per_1000 DESC) AS Rnk
             FROM rate)
					SELECT
                    year,
                    county, 
                    drug_type, 
                    rate_per_1000,
                    rnk
                    FROM rnk
                     where Rnk <= 5
             
