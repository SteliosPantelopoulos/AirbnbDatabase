/* 1)NO JOINS
   Displays apartments that have minimum night greater than 4 (DISTICT)

   -Rows: 1 */

SELECT COUNT(DISTINCT Calendar.listing_id) 
FROM Calendar
WHERE Calendar.minimum_nights>4;


/* 2)NO JOINS
   Displays which neighbourhoods start with A

   -Rows: 8 */

SELECT 	Neighbourhood
FROM Neighbourhoods
WHERE Neighbourhood LIKE 'Α%';



/* 3)NO JOINS
   Displays apartments which have been characteraised as clean and how many times
   
   -Rows: 7323 */
SELECT Count(Reviews.comments), Reviews.listing_id
FROM Reviews
WHERE comments LIKE '%clean%' 
GROUP BY (Reviews.listing_id)
ORDER BY Count(Reviews.comments) Desc;






/* 1)OUTER JOIN between: Listings and Calendar
   Dislays the data in chronological order
   If an apartment is available at a specific date displays its main info
   Else it doesn't display any info of the apartment just the date
   
   -Rows: 10.000
   -Rows without limits: 422.076*/

SELECT Listings.id, Listings.price, Listings.accommodates, Listings.neighbourhood, Calendar.date_
FROM Listings
RIGHT OUTER JOIN Calendar ON Calendar.listing_id = Listings.id AND Calendar.date_ = '2020-03-17' AND Calendar.available = 't'

ORDER BY Calendar.date_
LIMIT 10000;




/* 2)OUTER JOIN between: Neighbourhoods and Listings
   Displays the number of neighbourhoods that don't have any listings
   
   -Rows: 1 */
   
SELECT COUNT(*) AS Number_of_neighbourhoods_without_listings
FROM( SELECT Neighbourhoods.neighbourhood, Listings.id
      FROM Neighbourhoods LEFT OUTER JOIN Listings on Neighbourhoods.neighbourhood = Listings.neighbourhood_cleansed) AS NewTable
      WHERE NewTable.id = null;






/* 1)INNER JOIN between: Listings and Calendar
	Finds which listings are available at 4/4/2020

	-Rows: 100
	-Rows without limit: 7698 */

SELECT Listings.id
FROM Listings
INNER JOIN Calendar ON Listings.id = Calendar.listing_id AND Calendar.available = 't' AND Calendar.date_ = '2020-04-04'
LIMIT 100;




/* 2)INNER JOIN between: Listings and Reviews
	Shows reviews details order by the date of the review about a specific listing
	
	-Rows: 85 */

SELECT  Reviews.date, Reviews.reviewer_name, Reviews.comments
FROM Listings
INNER JOIN Reviews ON Listings.id = Reviews.listing_id
WHERE Listings.id = '23572074'
ORDER BY Reviews.date;



/* 3)INNER JOIN between: Listings and Reviews
   Shows all the reviews details about the listings located in "Ambelokipi" and have price<150 
   Order by the price 

   -Rows: 146 */

SELECT Reviews.*, Listings.price
FROM Listings
INNER JOIN Reviews ON Listings.id = Reviews.listing_id
WHERE Listings.neighbourhood = 'Ambelokipi' AND Listings.price < '150'
ORDER BY SUBSTRING(Listings.price, 2)::numeric;



/* 4)INNER JOIN between: Calendar and Listings
   Finds average, max and min price for renting an apartment for 24/12/2020  that can accomodate 4 people and is available

   -Rows: 1 */
  
SELECT ROUND(AVG(SUBSTRING(Listings.price, 2)::numeric),2) AS Average_price, MAX(SUBSTRING(Listings.price, 2)::numeric) AS Maximum_price, MIN(SUBSTRING(Listings.price, 2)::numeric) AS Minmum_price
FROM Listings
INNER JOIN Calendar ON Calendar.listing_id = Listings.id AND Calendar.date_ = '2020-12-24' AND Calendar.available = 't'
WHERE Listings.accommodates = 4 ;




/* 5)INNER JOIN between: Geolocation and Listings
   Displays all the neighbourhoods with the number of airbnbs in each one and the average price
   
   -Rows: 45 */

SELECT Geolocation.properties_neighbourhood , COUNT(Listings.id) AS number_of_airbnbs, ROUND(AVG(Listings.price::money::numeric),2) AS average_price
FROM Geolocation
INNER JOIN Listings ON Listings.neighbourhood_cleansed = Geolocation.properties_neighbourhood
GROUP BY Geolocation.properties_neighbourhood
ORDER BY ROUND(AVG(Listings.price::money::numeric),2);



/* 6)INNER JOIN between: Listings_Summary and Calendar
   Finds the top 50 listings with the most booked days during the summer of 2020 and display their basic info
 
   -Rows: 50 
   -Rows without limit: 7559 */

SELECT TOP50.days_booked, Listings_Summary.* 
FROM Listings_Summary
INNER JOIN(
			SELECT COUNT(*) AS days_booked, listing_id
			FROM Calendar
			WHERE Calendar.available = 'f' AND Calendar.date_ between '2020-06-01' and '2020-08-31'
			GROUP BY listing_id
			ORDER BY days_booked DESC
			LIMIT 50
		  ) AS TOP50
ON Listings_Summary.id = TOP50.listing_id;



/* 7)INNER JOIN between: Reviews and Reviews_Summary
   Returns number of listing_ids that are included in Reviews and not Reviews_Summary
   
   -Rows: 1 */

SELECT Count(Reviews.listing_id)
FROM (
   SELECT Reviews.listing_id
   FROM Reviews
EXCEPT
   SELECT Reviews.listing_id 
   FROM Reviews
   INNER JOIN Reviews_summary ON Reviews.listing_id = Reviews_summary.listing_id  ) AS Reviews;