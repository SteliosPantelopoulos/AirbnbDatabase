CREATE INDEX Listing_host_id_indx ON Listing(host_id);
DROP INDEX Listing_host_id_indx;

/*no index for 2nd query*/

CREATE INDEX index1ergasia5 ON listing(host_id);
DROP INDEX index1ergasia5;

CREATE INDEX index2ergasia5 ON LinkTable(listing_id);
DROP INDEX index2ergasia5;

CREATE INDEX index2ergasia5 ON Listing(number_of_reviews );
DROP INDEX index2ergasia5;

CREATE INDEX index4ergasia5 ON ROOM(price, accommodates);
DROP INDEX index4ergasia5;

CREATE INDEX index5ergasia5 ON location(neighbourhood_cleansed);
DROP INDEX index5ergasia5;