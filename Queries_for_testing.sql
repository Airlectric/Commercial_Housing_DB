
1./*A query to retrieve applicant logins*/
 SELECT* 
 FROM applicant_credentials

2    /* A query to retrieve information about
applicants and the rooms they have applied for */

SELECT CONCAT(firstname,' ',lastname) as fullname, category_name,location,description
FROM applicant_room
JOIN applicant ON applicant_room.applicant_id = applicant.applicant_id
JOIN room ON applicant_room.room_id = room.room_id
JOIN category ON room.category_id = category.category_id;

3.    /*SQL query that retrieves information about vendors of 
  the various rooms, the various rooms with discription and price */

SELECT name, category_name, location,description, "price_in_gh₵"
FROM room
JOIN vendor ON room.vendor_id = vendor.vendor_id
JOIN category ON room.category_id = category.category_id;

4.   /*This is a SQL query that retrieves information about payments made by applicants 
and category name(type of room)*/.

SELECT CONCAT(firstname,' ',lastname) as fullname, payment_date,payment_method,category_name,amount_in_GH₵
FROM applicant
JOIN payment ON applicant.applicant_id = payment.applicant_id
JOIN category ON applicant.applicant_id = category.category_id;

5. /*This is a SQL query that retrieves information about the payment made by applicants
indicating the date for the payment, payment mthod, amount, room category and room description */

SELECT CONCAT(firstname,' ',lastname) as fullname, payment_date, payment_method, category_name, description, amount_in_GH₵ 
FROM applicant 
JOIN payment ON applicant.applicant_id = payment.applicant_id 
JOIN room ON payment.room_id = room.room_id 
JOIN category ON room.category_id = category.category_id;
