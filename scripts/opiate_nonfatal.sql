use opiate
SELECT *
FROM non_fatal_clean1
where year = 2020

select drug_type, 
sum(total_non_fatal) as total_OD, 
year
from non_fatal_clean1
group by drug_type, year 

with non_fatal as (select drug_type, 
sum(total_non_fatal) as total_OD, 
year
from non_fatal_clean1
WHERE NOT drug_type = '  All Drug Overdose'
group by drug_type, year)
select 
total_OD, 
year, 
drug_type,
row_number() over (
    partition by Year(total_od)
    order by total_OD desc
  ) as top_number
  FROM non_fatal
  
  
 select * from non_fatal_clean1 
 -- non fatal per 100 
  SELECT 
  nf.year, 
  nf.county, 
  nf.drug_type,
  nf.total_non_fatal,
  p.total_pop,
  ROUND(nf.total_non_fatal/p.total_pop * 1000,2) as rate_per_1000  
  FROM non_fatal_clean1 as nf
  left join pop_inc as p
  on nf.county=p.county and nf.year=p.year 
  WHERE drug_type NOT LIKE 'All_%' AND p.year >=2017
 
 
 
 
  select * from pop_inc
  
 