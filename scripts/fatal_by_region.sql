use opiates

SELECT * from fatal 

-- fatal by region 
with regions as (SELECT
year, 
Geography as Region, 
sum(Value) as total_OD,
Indicator as Drug_OD_Deaths
FROM fatal
WHERE Geography IN ('Chattanooga and Hamilton Metro', 'East Tennessee', 'Jackson and Madison Metro', 'Knoxville and Knox Metro',
					'Memphis and Shelby Metro', 'Mid-Cumberland',
'Nashville and Davidson Metro',
'Northeast Tennessee',
'South Central Tennessee',
'Southeast Tennessee',
'Sullivan Metro',
'Upper Cumberland',
'West Tennessee') and Indicator = 'All Drug Overdose Deaths'
GROUP BY Geography, year), 
 r as (SELECT           
			year, 
			sum(total_pop) as pop,
			CASE WHEN County IN ('Macon', 'Clay', 'Pickett', 'Smith', 'Jackson', 'Overton', 'Fentress'
									, 'Putnam', 'Dekalb', 'White', 'Cumberland', 'Cannon', 'Warren', 'Van Buren') THEN 'Upper Cumberland'
                  WHEN County = 'Sullivan' THEN 'Sullivan Metro'              
				  WHEN County = 'Hamilton' THEN 'Chattanooga and Hamilton Metro'
                  WHEN County = 'Knox' THEN 'Knoxville and Knox Metro'
                  WHEN County = 'Davidson' THEN 'Nashville and Davidson Metro'
                  WHEN County = 'Madison' THEN 'Jackson and Madison Metro'
                  WHEN County = 'Shelby' THEN 'Memphis and Shelby Metro'
                  WHEN County IN ('Hancock', 'Hawkins', 'Greene', 'Washington', 'Unicoi', 'Carter', 'Johnson'
									) THEN 'Northeast Tennessee'
				  WHEN County IN ('Scott', 'Campbell', 'Claiborne', 'Morgan', 'Anderson', 'Union', 'Grainger'
									, 'Roans', 'Jefferson', 'Hamblen', 'Loudon', 'Blount', 'Sevier', 'Cocke') THEN 'East Tennessee'
				  WHEN County IN ('Grundy', 'Franklin', 'Marion', 'Bradley', 'Polk', 'McMinn', 'Meigs'
									, 'Bledsoe', 'Rhea', 'Sequatchie') THEN 'Southeast Tennessee'
                  WHEN County IN ('Wayne', 'Perry', 'Hickamn', 'Lewis', 'Lawrence', 'Maury', 'Giles'
									, 'Marshall', 'Bedford', 'Lincoln', 'Moore', 'Coffee') THEN 'South Central Tennessee'
				  WHEN County IN ('Stewart', 'Houston', 'Humphreys', 'Dickson', 'Cheatham', 'Williamson', 'Rutherford'
									, 'Wilson', 'Trousdale', 'Sumner', 'Robertson', 'Montgomery') THEN 'Mid-Cumberland'
				  WHEN County IN ('Fayette', 'Hardeman', 'McNairy', 'Hardin', 'Chester', 'Tipton', 'Haywood'
									, 'Henderson', 'Decatur', 'Lauderdale', 'Crockett', 'Gibson', 'Carroll', 'Benton',
                                     'Dyer', 'Lake', 'Obion', 'Weekly', 'Henry') THEN 'West Tennessee'
				 ELSE 'Other'
                 END AS Region
				 FROM pop_inc
                 group by Region, year)
                 SELECT 
                 r1.*, 
                 r.pop,
                 ROUND(r1.total_OD/r.pop * 1000,2) as rate_per_1000
                 FROM regions as r1
                 LEFT JOIN r
                 ON r1.Region=r.Region and r1.year=r.year
	
   
                 
                
               
                                    
                                   
                                    