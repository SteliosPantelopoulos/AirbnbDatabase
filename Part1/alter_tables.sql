BEGIN;
alter table Calendar
add foreign key (listing_id) references Listings(id);

alter table Listings
add foreign key (neighbourhood_cleansed) references Neighbourhoods(neighbourhood);

alter table Listings_Summary
add foreign key (id) references Listings(id);

alter table Reviews
add foreign key (listing_id) references Listings(id);

alter table Reviews_Summary
add foreign key (listing_id) references Listings(id);

--alter table Neighbourhoods

alter table Geolocation
add foreign key (properties_neighbourhood) references Neighbourhoods(neighbourhood);

COMMIT;