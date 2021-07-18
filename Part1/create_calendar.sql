create table Calendar(
   listing_id int,
   date_ date,
   available boolean,
   price varchar(10),
   adjusted_price varchar(10),
   minimum_nights int,
   maximum_nights int,
   Primary key(listing_id, date_)
);