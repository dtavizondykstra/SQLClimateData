/*Getting to know the data */
SELECT state, year, tempf from state_climate;

/*How the average temperature changes over time in each state*/
SELECT 
  state, 
  year, 
  tempf, 
  AVG(tempf) OVER (
     PARTITION BY STATE
     ORDER BY year
     ) AS 'running_avg_temp'
FROM state_climate;

/*Lowest recorded temperature for each state*/
SELECT
  state,
  year,
  min(tempf) AS 'lowest_temp'
FROM state_climate
GROUP BY state
ORDER BY 3;

/*Highest recorded temp for each state*/
SELECT
  state,
  year,
  max(tempf) AS 'highest_temp'
FROM state_climate
GROUP BY state
ORDER BY 3 DESC;

/*How temperature has changed each year in each state
ORDER BY shows which states had the largest changes in temp and also shows a trend in which states have had the largest yearly changes*/
SELECT
  state,
  year,
  tempf,
  tempf - LAG (tempf, 1, tempf) OVER (
      PARTITION BY state
      ORDER BY year
  ) AS 'change_in_temp'
  FROM state_climate
  ORDER BY 4 DESC;

/*Coldest ranked temperatures (any state or year)*/
SELECT
  state,
  year,
  tempf,
  RANK() OVER (
	      ORDER BY tempf
   ) AS 'coldest_rank'
FROM state_climate
ORDER by 4;

/*Warmest ranked temperatures (any state or year)*/
SELECT
  state,
  year,
  tempf,
  RANK() OVER (
	      ORDER BY tempf DESC
   ) AS 'warmest_rank'
FROM state_climate
ORDER by 4;

/*Warmest ranked temperatures (ranked by state)*/
SELECT
  state,
  year,
  tempf,
  RANK() OVER (
          PARTITION BY state
	      ORDER BY tempf DESC
   ) AS 'warmest_rank'
FROM state_climate
ORDER BY 1,4
;

/*This query returns the average yearly temperatures in quartile rankings for each state, ranked from coldest to warmest*/
SELECT
  NTILE(4) OVER (
    PARTITION BY state
    ORDER BY tempf
  ) AS 'quartile',
  state,
  year,
  tempf
FROM state_climate
ORDER BY 2, 1;

/*This query returns the average yearly temperatures in quartile rankings overall (regardless of state), ranked from coldest to warmest*/
SELECT
  NTILE(5) OVER (
    ORDER BY tempf
  ) AS 'quartile',
  state,
  year,
  tempf
FROM state_climate
ORDER BY 1;

