/*FUNCTION(A) */
CREATE FUNCTION host_listings_count_change()
	RETURNS trigger AS
$BODY$
BEGIN
	/*INSERT*/
	IF TG_OP = 'INSERT' THEN
		UPDATE Host
		SET listings_count = listings_count + 1
		WHERE Host.id = NEW.host_id;
	END IF;

	/*DELETE*/
	IF TG_OP = 'DELETE' THEN
		UPDATE Host
		SET listings_count = listings_count - 1
		WHERE Host.id = OLD.host_id;
	END IF;
	
RETURN NEW;
END;
$BODY$

LANGUAGE plpgsql VOLATILE 
COST 100;


/*TRIGGER(A)*/
CREATE TRIGGER host_listings_count_change
AFTER INSERT OR DELETE
ON Listing FOR EACH ROW
EXECUTE PROCEDURE host_listings_count_change();




/*If a there is a new review in Review Table this function increases the number_of_reviews in Listing Table
  Delete is not necessary because a review can't be deleted */


/*FUNCTION(B)*/
CREATE FUNCTION listing_number_of_reviews_change()
	RETURNS trigger AS
$BODY$
BEGIN
	
	UPDATE Listing
	SET number_of_reviews = number_of_reviews + 1
	WHERE Listing.id = NEW.listing_id;
	
RETURN NEW;
END;
$BODY$

LANGUAGE plpgsql VOLATILE 
COST 100;


/*TRIGGER(B)*/
CREATE TRIGGER listing_number_of_reviews_change
AFTER INSERT
ON Review FOR EACH ROW
EXECUTE PROCEDURE listing_number_of_reviews_change();