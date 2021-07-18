/* Inner Join between Listing, Host, Location
   Displays all the listings of a certain host_id and their location
   
   -Rows: 40 */

SELECT Host.id as Host_id, Host.name as Host_name, Listing.id as Listing_id, Location.neighbourhood_cleansed as Neighbourhood_of_listing
FROM Host, Listing
INNER JOIN Location ON Listing.id = Location.listing_id
WHERE Host.id = '1167063' AND Host.id = Listing.host_id




/* Inner Join between LinkTable and Room
   Displays the rooms that have more than 20 amenities, the number of amenities and their price
   
   Rows: 7590 */

SELECT LinkTable.listing_id, COUNT(LinkTable.amenity_id) AS number_of_amenities , Room.price
FROM LinkTable
INNER JOIN Room ON LinkTable.listing_id = Room.listing_id
GROUP BY(LinkTable.listing_id, Room.price)
HAVING COUNT(LinkTable.amenity_id) >'20' 



/* Left Outer Join between Listing and Price 
   Displays all the listings with more than 20 reviews and their price info if the price per night is less
   than 150
   
   Rows: 4399 */

SELECT Listing.id, Price.price, Price.security_deposit, Price.extra_people
FROM Listing
LEFT OUTER JOIN Price ON Listing.id = Price.listing_id AND Price.price < 150
WHERE Listing.number_of_reviews > 20


/* Inner Join Between Review and Room
   Displays the rooms that have more than 50 reviews and their price
   
   Rows: 770 */

SELECT Room.listing_id, COUNT(Review.id) AS number_of_reviews, Room.price
FROM Review
INNER JOIN Room ON Review.listing_id = Room.listing_id AND Room.accommodates = 4
GROUP BY (Room.listing_id, Room.price)
HAVING COUNT(Review.id) > 50


/* Outer Join between Geolocation and Location
   Displays all the neighbourhoods and the apartment's details that are located in ΑΓΙΟΣ ΝΙΚΟΛΑΟΣ or ΑΜΠΕΛΟΚΗΠΟΙ
	
   Rows: 490 */

SELECT Geolocation.properties_neighbourhood, Location.*
FROM Geolocation
LEFT OUTER JOIN Location ON Geolocation.properties_neighbourhood = Location.neighbourhood_cleansed AND (Location.neighbourhood_cleansed = 'ΑΓΙΟΣ ΝΙΚΟΛΑΟΣ' OR Location.neighbourhood_cleansed = 'ΑΜΠΕΛΟΚΗΠΟΙ')
