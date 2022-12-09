use opiate

with count as( SELECT *
from scripts
where  Indicator  NOT like 'All_%' 
	AND ValueType = "Count"and GeographyType = "County")
select 
	year, 
    Geography, 
    Indicator, 
	Value, 
    RANK() OVER(PARTITION BY Year, Indicator ORDER BY Value DESC) AS Rnk
    FROM count 
    
       
    
   
    
   
    