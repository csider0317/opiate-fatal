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
                     
   -- add income 
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
                    rnk.year,
                    rnk.county, 
                    rnk.drug_type, 
                    rnk.rate_per_1000,
                    rnk.rnk, 
                    m.value
                    FROM rnk
                    left join medianhouseholdincome as m 
                    on rnk.county=m.county and rnk.year=m.year
                     where Rnk <= 5
             



select *  from medianhouseholdincome
select distinct(value_type) from fatal


with rate as (SELECT 
   -- f.year, 
   f.Geography as county, 
   f.drug_type,
   f.value,
	p.total_pop,
  ROUND(f.value/p.total_pop * 1000,2) as rate_per_1000  
  FROM fatal as f
  left join pop_inc as p
  on f.Geography=p.county and f.year=p.year 
  WHERE drug_type = 'All Drug Overdose Deaths' AND p.year >=2017 and value_type= 'Count'),
		rnk as (select 
            year, 
            county, 
            drug_type,
            rate_per_1000,
             RANK() OVER(PARTITION BY County ORDER BY rate_per_1000 DESC) AS Rnk
             FROM rate)
					SELECT
                    rnk.year,
                    rnk.county, 
                    rnk.drug_type, 
                    rnk.rate_per_1000,
                    rnk.rnk, 
                    m.value as 
                    FROM rnk
                    left join medianhouseholdincome as m 
                    on rnk.county=m.county and rnk.year=m.year
                     where Rnk <= 5
                     

with fatal_od as(SELECT 
   -- f.year, 
   f.Geography as county, 
   f.drug_type as opiates,
   sum(f.value) as total_od,
	p.total_pop,
  ROUND(f.value/p.total_pop * 1000,0) as rate_per_1000  
  FROM fatal as f
  left join pop_inc as p
  on f.Geography=p.county and f.year=p.year 
  WHERE drug_type IN (' Fentanyl', ' Heroin', ' Prescription Opioids') AND p.year >=2013 and value_type = 'Count'
  GROUP BY County)
  select 
  county, 
  rate_per_1000,
             RANK() OVER(PARTITION BY County ORDER BY rate_per_1000 DESC) AS Rnk
             FROM fatal_od
           
            
  
  
  
  
  
  
  
  
  select
  Geography, 
  -- year, 
  SUM(value) as value, 
  drug_type
  FROM fatal
  WHERE Geography = 'Anderson' and drug_type = ' Fentanyl'

select distinct(year) from fatal