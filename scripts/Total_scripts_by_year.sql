use opiate

-- total scripts by year 

select * from 2010_2020_scripts

select
distinct(year)
FROM 2010_2020_scripts

SELECT
year, 
SUM(total_drugs) as opiate_scripts
from 2010_2020_scripts
GROUP BY year 

-- non fatal OD by year
select * from non_fatal_clean1

select 
year, 
sum(total_non_fatal) as non_fatal_overdose
FROM non_fatal_clean1
where drug_type LIKE '%All Drug Overdose%'
group by year
order by year

-- fatal od by year 

select * from fatal 

select 
year, 
sum(value) as deaths
FROM fatal
where drug_type LIKE 'All Drug Overdose Deaths'
group by year
order by year

  
 --  worst county per year (needs to be charted) 
  SELECT w.county, w.year, w.opiates_per_100 
FROM (
  SELECT *, ROW_NUMBER() OVER (PARTITION BY year ORDER BY opiates_per_100 DESC) rn 
  FROM 2010_2020_scripts
) w
WHERE w.rn = 1

-- best county per year 
 SELECT b.county, b.year, b.opiates_per_100 
FROM (
  SELECT *, ROW_NUMBER() OVER (PARTITION BY year ORDER BY opiates_per_100 ASC) rn 
  FROM 2010_2020_scripts
) b
WHERE b.rn = 1







