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

  
