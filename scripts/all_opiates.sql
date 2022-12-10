use opiate

with count as
( SELECT 
	Year, 
    SUM(Value) as total_Benzo
	from scripts
where  Indicator = 'All Benzodiazepines' 
	AND ValueType = "Count" And GeographyType = "County"
    GROUP BY Year)
select 
	c.year, 
    /*c.Geography, 
    c.Indicator,*/
    c.total_Benzo, 
    /*p.total_pop,*/
    LAG(total_Benzo) OVER ( ORDER BY Year ) AS Drugs_Previous_Year,
       total_Benzo - LAG(total_Benzo) OVER ( ORDER BY Year ) AS YOY_Diff, 
		
      	FROM count as c
        
        
        Select * from scripts