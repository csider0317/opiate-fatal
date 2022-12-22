use opiate

select * from dispense_per_100

SELECT distinct(year) from dispense_per_100

SELECT
round(sum(rate)/765, 2) as US_rate
FROM dispense_per_100

-- avg for each state over 15 years per 100 people 
SELECT 
state_abr, 
round(sum(rate)/11, 2) as state_avg
FROM dispense_per_100
WHERE year >=2010 and state_abr = 'TN'
group by state_abr




SELECT
sum(total_pop) as pop
FROM pop_inc

select * from 2010_2020_scripts

select * from scripts 
select distinct(year) from scripts


with patients as (SELECT 
sum(value) as patients_scripts,
Geography as county 
FROM scripts 
where ValueType = 'Patients' and GeographyType = 'County' and Indicator = 'All Opioids for Pain' and year <= 2020
GROUP BY Geography),
count as (SELECT
sum(value) as count,
Geography as county 
FROM scripts 
where ValueType = 'Count' and GeographyType = 'County' and Indicator = 'All Opioids for Pain' and year <= 2020
GROUP BY Geography  ),
per_pt as (SELECT 
p.county, 
ROUND(c.count/p.patients_scripts, 2) as script_per_pt
FROM patients as p
left join count as c
on p.county=c.county
GROUP BY p.county)
SELECT 
county, 
script_per_pt,
ROW_NUMBER() OVER(ORDER BY script_per_pt desc) RowNumber
FROM per_pt





-- sum fatal by county 2017-2020 need to add population to normalize it 
with fatal_od as (SELECT 
Geography as county, 
sum(Value) as total_od 
FROM fatal
WHERE  indicator = 'All Drug Overdose Deaths' and year >= 2017 and GeographyType = 'County'
group by Geography)
SELECT 
county, 
total_od, 
ROW_NUMBER() OVER(ORDER BY total_od desc) RowNumber
from fatal_od 



-- overdose per 1000 scripts written
with ft_od as (SELECT 
Geography as county, 
sum(Value) as total_od 
FROM fatal
WHERE  indicator = 'All Drug Overdose Deaths' and year >= 2017 and GeographyType = 'County'
group by Geography), 
rx_pt as (SELECT 
sum(value) as patients_scripts,
Geography as county 
FROM scripts 
where ValueType = 'Patients' and GeographyType = 'County' and Indicator = 'All Opioids for Pain' and year in (2017, 2020)
GROUP BY Geography),
per_1000 as (SELECT
f.county, 
round(f.total_od/r.patients_scripts*1000,2) as per_1000
FROM ft_od as f
left join rx_pt as r
on f.county=r.county)
SELECT 
county, 
per_1000,
ROW_NUMBER() OVER(ORDER BY per_1000 desc) RowNumber
FROM per_1000




select * from non_fatal_clean1

select 
county, 
sum(total_non_fatal)


