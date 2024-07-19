CREATE DATABASE POPULATION ;
-- TOTAL NO OF ROWS
SELECT count(*) FROM population.dataset1;
-- DATA SET  = 541 ROWS

-- HOW MUCH DATA COLLECTED FROM MADHYA PRADESH 
SELECT COUNT(*) data FROM population.dataset1
WHERE STATE = "Madhya Pradesh"

-- CALCULATE THE TOTAL POPULATION OF INDIA 

SELECT 
    SUM(Population)
    as total_population
FROM
    population.dataset2 ;
    
-- FIND THE AVG POPULATION GROWTH OF COUNTRY

SELECT 
    AVG(Growth) * 100 AS growthrate
FROM
    population.dataset1;
    
-- Find avg growthrate of top 5 states.

SELECT 
    State, AVG(Growth) * 100 AS growthrate
FROM
    population.dataset1
GROUP BY State
ORDER BY growthrate DESC
LIMIT 5;

-- FIND THE AVG LITERACY RATE MORE THAN 85.

SELECT 
    State, ROUND(AVG(Literacy), 2) AS avgrate
FROM
    population.dataset1
GROUP BY State
HAVING ROUND(AVG(Literacy), 2) > 85
ORDER BY avgrate DESC;

-- show the sates which letter starts from M

select distinct State from population.dataset1
where lower(State) like 'M%';

-- show the most populated Districts whose area is less than 5000 km.

SELECT 
    District, Population, Area_km2
FROM
    population.dataset2
HAVING Area_km2 < 5000
ORDER BY Population DESC
LIMIT 5;

-- calulate genders from sex ratio with group by state

select d.State , sum(d.males) total_males , sum(d.females) total_females from
(select c.District,c.State,round(c.population/(c.Sex_Ratio+1),0) 
males,round((c.population*c.Sex_Ratio)/(c.Sex_Ratio+1),0) females from
 (select a.District,a.State,a.Sex_Ratio/1000 Sex_Ratio,b.Population 
 from population.dataset1  a 
 join population.dataset2  b on 
 a.District = b.District)c)d 
 group by d.State ;
 
 -- how many males are more than females


SELECT 
    e.total_males,
    e.total_females,
    (e.total_males - e.total_females) diff
FROM
    (SELECT 
        SUM(d.males) total_males, SUM(d.females) total_females
    FROM
        (SELECT 
        c.District,
            c.State,
            ROUND(c.population / (c.Sex_Ratio + 1), 0) males,
            ROUND((c.population * c.Sex_Ratio) / (c.Sex_Ratio + 1), 0) females
    FROM
        (SELECT 
        a.District,
            a.State,
            a.Sex_Ratio / 1000 Sex_Ratio,
            b.Population
    FROM
        population.dataset1 a
    JOIN population.dataset2 b ON a.District = b.District) c) d) e;