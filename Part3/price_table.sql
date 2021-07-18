CREATE TABLE Price
  AS (SELECT id as listing_id, 
  			           price, 
  			           weekly_price, 
  			           monthly_price, 
  			           security_deposit, 
  			           cleaning_fee,
            	 		 guests_included, 
            	 		 extra_people, 
            	 		 minimum_nights, 
            	 		 maximum_nights,
            	 		 minimum_minimum_nights, 
            	 		 maximum_minimum_nights, 
            	 		 minimum_maximum_nights,
        	  	     maximum_maximum_nights, 
        	  	     minimum_nights_avg_ntm, 
        	  	     maximum_nights_avg_ntm
	FROM Listings);

  


UPDATE price SET price = REPLACE(price, '$', '');
UPDATE price SET price = SPLIT_PART(price, ',', 1);
ALTER TABLE price 
ALTER COLUMN price TYPE numeric USING price::numeric;

UPDATE price SET weekly_price = REPLACE(weekly_price, '$', '');
UPDATE price SET weekly_price = SPLIT_PART(weekly_price, ',', 1);
ALTER TABLE price 
ALTER COLUMN weekly_price TYPE numeric USING weekly_price::numeric;

UPDATE price SET monthly_price = REPLACE(monthly_price, '$', '');
UPDATE price SET monthly_price = SPLIT_PART(monthly_price, ',', 1);
ALTER TABLE price 
ALTER COLUMN monthly_price TYPE numeric USING monthly_price::numeric;

UPDATE price SET security_deposit = REPLACE(security_deposit, '$', '');
UPDATE price SET security_deposit = SPLIT_PART(security_deposit, ',', 1);
ALTER TABLE price 
ALTER COLUMN security_deposit TYPE numeric USING security_deposit::numeric;

UPDATE price SET cleaning_fee = REPLACE(cleaning_fee, '$', '');
UPDATE price SET cleaning_fee = SPLIT_PART(cleaning_fee, ',', 1);
ALTER TABLE price 
ALTER COLUMN cleaning_fee TYPE numeric USING cleaning_fee::numeric;

UPDATE price SET extra_people = REPLACE(extra_people, '$', '');
UPDATE price SET extra_people = SPLIT_PART(extra_people, ',', 1);
ALTER TABLE price 
ALTER COLUMN extra_people TYPE numeric USING extra_people::numeric;


ALTER TABLE price
ALTER COLUMN minimum_nights_avg_ntm TYPE numeric USING minimum_nights_avg_ntm::numeric;

ALTER TABLE price
ALTER COLUMN maximum_nights_avg_ntm TYPE numeric USING maximum_nights_avg_ntm::numeric;




ALTER TABLE Price
ADD FOREIGN  KEY (listing_id) REFERENCES Listings(id);
  


 
/*Use DROP COLUMNM IF EXISTS because some columns have been dropped in room_table.sql*/
ALTER TABLE Listings
DROP COLUMN IF EXISTS price,
DROP COLUMN IF EXISTS weekly_price,
DROP COLUMN IF EXISTS monthly_price,
DROP COLUMN IF EXISTS security_deposit,
DROP COLUMN IF EXISTS cleaning_fee,
DROP COLUMN IF EXISTS guests_included,
DROP COLUMN IF EXISTS extra_people,
DROP COLUMN IF EXISTS maximum_nights,
DROP COLUMN IF EXISTS minimum_nights,
DROP COLUMN IF EXISTS minimum_minimum_nights,
DROP COLUMN IF EXISTS maximum_minimum_nights,
DROP COLUMN IF EXISTS minimum_maximum_nights,
DROP COLUMN IF EXISTS maximum_maximum_nights,
DROP COLUMN IF EXISTS minimum_nights_avg_ntm,
DROP COLUMN IF EXISTS maximum_nights_avg_ntm;