UPDATE calendar SET price = REPLACE(price, '$', '');
UPDATE calendar SET price = SPLIT_PART(price, ',', 1);
UPDATE calendar SET adjusted_price = REPLACE(adjusted_price, '$', '');
UPDATE calendar SET adjusted_price = SPLIT_PART(adjusted_price, ',', 1);

ALTER TABLE Calendar 
ALTER COLUMN price TYPE numeric USING price::numeric,
ALTER COLUMN adjusted_price TYPE numeric USING adjusted_price::numeric;

/*To pedio available htan apo prin boolean h entolh gia na ginei apo char -> boolean: ALTER COLLUMN available TYPE boolean */