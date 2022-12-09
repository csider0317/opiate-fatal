use opiate
SELECT* from scripts

with count as( SELECT *
from scripts
where  Indicator like 'All_%' 
	AND ValueType = "Count"and GeographyType = "County")
select 
	year, 
    Geography, 
    Indicator, 
    Value, 
    RANK() OVER(PARTITION BY Year, Indicator ORDER BY Value DESC) AS Rnk
    FROM count
    


 
