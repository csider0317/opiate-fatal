use opiate

with fatal1 as (select drug_type, 
sum(Value) as total_OD, 
year
from fatal
WHERE  drug_type NOT LIKE '%All_%' AND value_type = 'Count'
group by drug_type, year)
select 
total_OD, 
year, 
drug_type,
row_number() over (
    partition by Year(total_od)
    order by total_OD desc
  ) as top_number
  FROM fatal1


  
select * from fatal 