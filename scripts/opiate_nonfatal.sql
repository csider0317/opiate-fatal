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
 