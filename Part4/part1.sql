CREATE TABLE Amenity(
	amenity_id SERIAL PRIMARY KEY,
	amenity_name VARCHAR(100)
);



INSERT INTO Amenity(amenity_name) 
			SELECT DISTINCT regexp_split_to_table(regexp_replace(amenities, '}|{|"', '', 'g'),  ',' ) AS amentity_name
			 FROM Room;


CREATE TABLE LinkTable AS
(SELECT TempRoom.listing_id, Amenity.amenity_id
 FROM Amenity,
   (SELECT Room.listing_id, regexp_split_to_table(regexp_replace(Room.amenities, '}|{|"', '', 'g'),  ',' ) AS amenity_name
    FROM Room) AS TempRoom
 WHERE TempRoom.amenity_name = Amenity.amenity_name
);

ALTER TABLE LinkTable ADD FOREIGN KEY (amenity_id) REFERENCES Amenity(amenity_id);

ALTER TABLE Room ADD PRIMARY KEY (listing_id);
ALTER TABLE LinkTable ADD FOREIGN KEY (listing_id) REFERENCES Room(listing_id);

ALTER TABLE Room
DROP COLUMN Amenities




