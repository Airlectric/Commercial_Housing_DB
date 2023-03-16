create table category(
	category_id bigserial primary key,
	category_name varchar(100) not null,
	description varchar(10000) not null
);

insert into category(category_name,description)
values ('4 in a room', 'balcony and a kitchenette'),
	   ('3 in a room', 'balcony and a kitchenette'),
	   ('2 in a room', 'balcony, kitchenette, washroom'),
	   ('1 in a room', 'balcony, kitchenette, washroom');


Create table applicant 
(applicant_id bigserial primary key,
 firstname varchar (500) not null,
 lastname varchar(100) not null,
 age numeric (5) not null, 
 school varchar (100) not null,
 level varchar (50) not null,
 school_id numeric(10) not null, 
 tel_number varchar (20) not null, 
 email varchar (100) not null,
 username varchar(100) NOT NULL UNIQUE,
 applicant_password VARCHAR(100) NOT NULL);
 

CREATE TABLE Applicant_credentials (
    applicant_id BIGINT primary key REFERENCES applicant(applicant_id),
    username VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL
);


CREATE OR REPLACE FUNCTION insert_applicant_credentials()
RETURNS trigger
LANGUAGE 'plpgsql'
AS $$

BEGIN
    INSERT INTO applicant_credentials (applicant_id, username, password)
    VALUES (NEW.applicant_id, NEW.username, NEW.applicant_password);
RETURN NEW;
END;
$$ ;

CREATE TRIGGER insert_applicant_credentials_trigger
AFTER INSERT OR UPDATE ON applicant
FOR EACH ROW
EXECUTE PROCEDURE insert_applicant_credentials();

Create table applicant_audit
(id bigserial,
 applicant_id numeric,
 firstname varchar (500),
 lastname varchar(100),
 age numeric (5), 
 school varchar (100),
 level varchar (50),
 school_id numeric(10), 
 tel_number varchar (20), 
 email varchar (100),
 username varchar(100) UNIQUE,
 applicant_password VARCHAR(100) NOT NULL,
 time_modified timestamp);
 
 CREATE OR REPLACE FUNCTION update_trail_on_applicant()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    
AS $$
 DECLARE 
			
BEGIN
       
	  
      INSERT INTO applicant_audit(applicant_id,firstname,lastname,age,school,level,school_id,tel_number,email,username,applicant_password,time_modified) 
	  VALUES(NEW.applicant_id,NEW.firstname,NEW.lastname,NEW.age,NEW.school,NEW.level,NEW.school_id,NEW.tel_number,NEW.email,NEW.username,NEW.applicant_password,current_date);

      INSERT INTO applicant_audit(applicant_id,firstname,lastname,age,school,level,school_id,tel_number,email,username,applicant_password,time_modified) 
	  VALUES(OLD.applicant_id,OLD.firstname,OLD.lastname,OLD.age,OLD.school,OLD.level,OLD.school_id,OLD.tel_number,OLD.email,OLD.username,OLD.applicant_password,current_date);

	  	   
RETURN NEW;
END;
$$;

CREATE TRIGGER update_trail_on_applicant_trigger
    AFTER UPDATE OR DELETE
    ON applicant
    FOR EACH ROW
    EXECUTE PROCEDURE update_trail_on_applicant();
	
Insert into applicant (firstname,lastname, age, school, level, school_id, tel_number, email,username,applicant_password) 
VALUES ('Valeria', 'Baidoo', 37, 'University of Professional Studies', 'Masters', 12345, 0269004001, 'valbaidoo14222@gmail.com', 'valbaidoo', 'password1'),
       ('James', 'Charles', 26, 'University of Ghana, Legon', 300, 25134, 0553400400, 'Charlames.J@gmail.com', 'jcharles', 'password2'),
       ('Kilwah', 'Brown', 24, 'University of Ghana, Legon', 400, 31524, 0508164185, 'kbrownie@gmail.com', 'kbrown', 'password3'),
       ('Marionne', 'Wilson', 18, 'University of Ghana, Legon', 100, 42512, 0558064181, 'm.wilson@gmail.com', 'mwilson', 'password4'),
       ('Philip', 'Donkor', 24, 'GCTU', 200, 21534, 020145632, 'phildonkor@gmail.com', 'pdonkor', 'password5'),
       ('Doreen', 'Otabil', 22, 'University of Ghana, Legon', 'Masters', 32154, 0542441954, 'angeloswoman@gmail.com', 'doreenot', 'password6'),
       ('Charway', 'Okpoti', 20, 'University of Professional Studies', 400, 13524, 054632632, 'theophilusokpoti@gmail.com', 'cokpoti', 'password7'),
       ('Kwame','Boakye',24,'University of Ghana','Undergraduate',45678,'0241234567','kwameboakye@gmail.com','kboakye','password8'),
       ('Emefa','Doe',30,'University of Cape Coast','Postgraduate',12345,'0209876543','emefadoe@yahoo.com','edoe','password9'),
       ('Yaw','Kumi',28,'Kwame Nkrumah University of Science and Technology','Masters',23456,'0275432198','yawkumi@gmail.com','ykumi','password10'),
       ('Akua','Mensah',22,'University of Ghana','Undergraduate',78901,'0549876543','akuamensah@hotmail.com','amensah','password11'),
       ('Felix','Addo',35,'University of Education, Winneba','PhD',67890,'0245678901','felixaddo@yahoo.com','faddo','password12'),
       ('Ama','Bonsu',26,'University of Ghana','Masters',34567,'0207654321','amabonsu@gmail.com','abonsu','password13'),
       ('John','Doe',31,'Kwame Nkrumah University of Science and Technology','Masters',45678,'0242345678','johndoe@hotmail.com','jdoe','password14'),
       ('Grace','Amissah',29,'University of Cape Coast','Masters',56789,'0541234567','graceamissah@yahoo.com','gamissah','password15'),
       ('Kofi','Owusu',27,'University of Ghana','Masters',89012,'0267890123','kofiowusu@gmail.com','kofiowusu','password1'),
       ('Esi','Asare',23,'Kwame Nkrumah University of Science and Technology','Undergraduate',90123,'0509876543','esiasare@hotmail.com','esiasare','password2'),
       ('Yaw','Addo',34,'University of Education, Winneba','PhD',34567,'0241234567','yawaddo@yahoo.com','yawaddo','password3'),
       ('Adjoa','Mensah',25,'University of Ghana','Masters',45678,'0205432198','adjoamensah@gmail.com','adjoamensah','password4'),
       ('Kwame','Boateng',33,'University of Cape Coast','Masters',56789,'0249876543','kwameboateng@yahoo.com','kwameboateng','password5'),
       ('Gifty','Amissah',28,'Kwame Nkrumah University of Science and Technology','Masters',67890,'0275678901','giftyamissah@hotmail.com','giftyamissah','password6'),
       ('Kofi','Asante',26,'University of Ghana','Masters',78901,'0501234567','kofiasante@gmail.com','kofiasante','password7'),
       ('Efua','Osei',24,'University of Education, Winneba','Undergraduate',89012,'0269876543','efuaosei@yahoo.com','efuaosei','password8'),
       ('Yaw','Kwakye',29,'University of Ghana','Masters',90123,'0247890123','yawkwakye@gmail.com','yawkwakye','password9'),
       ('Akosua','Agyemang',27,'Kwame Nkrumah University of Science and Technology','Masters',23456,'0549876543','akosuaagyemang@hotmail.com','akosuaagyemang','password10');



CREATE TABLE vendor(vendor_id bigserial PRIMARY KEY,
					name VARCHAR(100) not null, 
					tel_number VARCHAR(20) not null, 
					email VARCHAR(100) not null,
				    username varchar(100) NOT NULL UNIQUE,
                    vendor_password VARCHAR(100) NOT NULL);

					
CREATE TABLE vendor_credentials (
	vendor_id BIGINT primary key REFERENCES vendor(vendor_id),
    username VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL
);	

CREATE OR REPLACE FUNCTION insert_vendor_credentials()
RETURNS trigger
LANGUAGE 'plpgsql'
AS $$

BEGIN
    INSERT INTO vendor_credentials (vendor_id, username, password)
    VALUES (NEW.vendor_id, NEW.username, NEW.vendor_password);
RETURN NEW;
END;
$$ ;

CREATE TRIGGER insert_applicant_credentials_trigger
AFTER INSERT OR UPDATE ON vendor
FOR EACH ROW
EXECUTE PROCEDURE insert_vendor_credentials();


CREATE TABLE vendor_audit(
	                id bigserial,
	                vendor_id numeric,
					name VARCHAR(100), 
					tel_number varchar(20), 
					email VARCHAR(100),
	                username varchar(100),
                    vendor_password VARCHAR(100) ,
                    time_modified timestamp);
					
CREATE OR REPLACE FUNCTION update_trail_on_vendor()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    
AS $$
 DECLARE 
			
BEGIN
       
	  
      INSERT INTO vendor_audit(vendor_id,name,tel_number,email,username,vendor_password,time_modified) 
	  VALUES(NEW.vendor_id,NEW.name,NEW.tel_number,NEW.email,NEW.username,NEW.vendor_password,current_date);
    
	  INSERT INTO vendor_audit(vendor_id,name,tel_number,email,username,vendor_password,time_modified) 
	  VALUES(OLD.vendor_id,OLD.name,OLD.tel_number,OLD.email,OLD.username,OLD.vendor_password,current_date);
    
   
RETURN NEW;
END;
$$;


CREATE TRIGGER update_trail_on_vendor_trigger
    AFTER UPDATE OR DELETE 
    ON vendor
    FOR EACH ROW
    EXECUTE PROCEDURE update_trail_on_vendor();
	
INSERT INTO vendor(name, tel_number, email,username,vendor_password)
VALUES('Kwame Mensah','0241234567','kwamemensah@gmail.com','kwamemensah123','password123'),
      ('Abena Agyemang','0509876543','abenaagyemang@hotmail.com','abenaagyemang456','password456'),
      ('Yaw Boateng','0245678901','yawboateng@yahoo.com','yawboateng789','password789'),
      ('Ghana Hostels Limited','0205432198','ghl56@gmail.com','ghasante012','password012'),
      ('Kofi Ansah','0249876543','kofiansah@yahoo.com','kofiansah345','password345'),
      ('Adjoa Amoah','0275678901','adjoaamoah@hotmail.com','adjoaamoah678','password678'),
      ('Yaw Osei','0501234567','yawosei@gmail.com','yawosei901','password901'),
      ('Evandy Hostels','0269876543','akosuamensah@yahoo.com','akosuamensah234','password234'),
      ('Kwabena Appiah','0247890123','kwabenaappiah@gmail.com','kwabenaappiah567','password567'),
      ('Efua Ampofo','0549876543','efuaampofo@hotmail.com','efuaampofo890','password890'),
      ('Gifty Mensah','0276543210','gifty.mensah@companya.com','gifty', 'password123'),
      ('Yaw Amoako','0241112233','yaw.amoako@companyb.com','yawn', 'password456'),
      ('TF','0509876543','tf789@companyc.com','tfcompany', 'password789'),
      ('Grace Ankomah','0263334445','grace.ankomah@companyd.com','grace', 'password1011'),
      ('Kofi Adu','0247778889','kofi.adu@companye.com','kofi', 'password1213'),
      ('Akua Yeboah','0501112223','akua.yeboah@companyf.com','akua', 'password1415'),
      ('Yaw Asare','0244445556','yaw.asare@companyg.com','yaw', 'password1617'),
      ('Felicia Dankwa','0276667778','felicia.dankwa@companyh.com','felicia', 'password1819'),
      ('Kwame Ofori','0249990001','kwame.ofori@companyi.com','kwame', 'password2021'),
      ('Abigail Darko','0262223334','abigail.darko@companyj.com','abigail', 'password2223');
					
	

Create table room (room_id bigserial primary key,
				   category_id numeric(10),
				   vendor_id numeric(10), 
				   location varchar (20),
				   price_in_GH₵ numeric(100));
		 
Insert into room (category_id, vendor_id, location, price_in_GH₵)
VALUES
(1, 1,  'Madina', 5000),
(4, 2,  'Adenta', 3500),
(3, 5,  'East Legon', 6000),
(5, 7,  'Labone', 4500),
(8, 1,  'Kaneshie', 4000),
(3, 9,  'Airport Residential', 7000),
(1, 2,  'Dansoman', 5500),
(5, 1,  'Teshie', 3000),
(4, 3,  'Osu', 6500),
(2, 7,  'Spintex', 4800),
(4, 2,   'North Legon', 3800),
(3, 9,   'Cantonments', 7500),
(1, 7,   'Adabraka', 4200),
(2, 1,   'Sakumono', 3200),
(3, 3,   'Achimota', 5800),
(1, 1,   'Haatso', 5300),
(2, 2,   'Kwabenya', 4200),
(3, 3,  'Dzorwulu', 6700),
(1, 2,   'Kokomlemle', 4900),
(2, 1,   'Abeka', 3600),
(7, 3,   'Roman Ridge', 8000),
(1, 1,   'Ashongman', 5200),
(2, 6,  'Ofankor', 4000),
(3, 3,   'Abelemkpe', 7200),
(1, 2,   'Mallam', 4400),
(8, 1,   'Gbawe', 2900),
(3, 5,   'Adjiringanor', 6900),
(1, 1,   'Dansoman', 5000),
(9, 2, 'Teshie-Nungua', 3700),
(3, 4,   'Labadi', 6200);







Create table room_audit (room_id bigserial primary key,
				   category_id numeric(10),
				   vendor_id numeric(10), 
				   location varchar (20),
				   price_in_cedis numeric(100),
				   time_modified timestamp);

				   
CREATE OR REPLACE FUNCTION update_trail_on_room()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    
AS $$
 DECLARE 
			
BEGIN
       
	  
      INSERT INTO room_audit(category_id,vendor_id,location,price_in_cedis,time_modified) 
	  VALUES(NEW.category_id,NEW.vendor_id,NEW.location,NEW."price_in_gh₵",current_date);

	  INSERT INTO room_audit(category_id,vendor_id,location,price_in_cedis,time_modified)
	  VALUES(OLD.category_id,OLD.vendor_id,OLD.location,OLD."price_in_gh₵" ,current_date);
	   
RETURN NEW;
END;
$$;


CREATE TRIGGER update_trail_on_room_trigger
    AFTER UPDATE OR DELETE OR INSERT
    ON room
    FOR EACH ROW
    EXECUTE PROCEDURE update_trail_on_room();


create  table payment(
applicant_id numeric(100),
room_id numeric(20),
payment_date date not null,
payment_method varchar(15) not null,
transaction_id serial primary key,
amount_in_GH₵ decimal(10,2)null);


create table payment_audit(
id bigserial,
applicant_id numeric(100),
room_id numeric(20),	
payment_date varchar(50),
payment_method varchar(15),
transaction_id serial,
amount_in_GH₵ decimal(10,2)null,
time_modified timestamp);

CREATE OR REPLACE FUNCTION update_trail_on_payment()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    
AS $$
 DECLARE 
			
BEGIN
       
	  
      INSERT INTO payment_audit(applicant_id,room_id,payment_date,payment_method,transaction_id,"amount_in_gh₵",time_modified) 
	  VALUES(NEW.applicant_id,NEW.room_id,NEW.payment_date,NEW.payment_method,NEW.transaction_id,NEW."amount_in_gh₵",current_date);
    
	  INSERT INTO payment_audit(applicant_id,room_id,payment_date,payment_method,transaction_id,"amount_in_gh₵",time_modified) 
	  VALUES(OLD.applicant_id,OLD.room_id,OLD.payment_date,OLD.payment_method,OLD.transaction_id,OLD."amount_in_gh₵",current_date);
   
RETURN NEW;
END;
$$;


CREATE TRIGGER update_trail_on_payment_trigger
    AFTER UPDATE OR DELETE 
    ON payment
    FOR EACH ROW
    EXECUTE PROCEDURE update_trail_on_payment();
	

CREATE TABLE applicant_room (applicant_id numeric(100),
	                         room_id numeric(100));

CREATE OR REPLACE FUNCTION insert_applicantRoom_details()
RETURNS trigger
LANGUAGE 'plpgsql'
AS $$

BEGIN
    INSERT INTO applicant_room(applicant_id, room_id)
    VALUES (NEW.applicant_id, NEW.room_id);
RETURN NEW;
END;
$$ ;

CREATE TRIGGER insert_applicantRoom_details_trigger
AFTER INSERT OR UPDATE ON payment
FOR EACH ROW
EXECUTE PROCEDURE insert_applicantRoom_details();     
			 
CREATE TABLE applicant_room_audit ( id bigserial,
	                            applicant_id numeric(100),
		                        room_id numeric(100),
	                            time_modified timestamp);
								
					
CREATE OR REPLACE FUNCTION update_trail_on_applicant_room()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    
AS $$
 DECLARE 
			
BEGIN
       
	  
      INSERT INTO applicant_room_audit(applicant_id,room_id,time_modified) 
	  VALUES(NEW.applicant_id,NEW.room_id,current_date);
      
	  INSERT INTO applicant_room_audit(applicant_id,room_id,time_modified) 
	  VALUES(OLD.applicant_id,OLD.room_id,current_date);
    
	 
   
RETURN NEW;
END;
$$;


CREATE TRIGGER update_trail_on_applicant_room_trigger
    AFTER UPDATE OR DELETE 
    ON applicant_room
    FOR EACH ROW
    EXECUTE PROCEDURE update_trail_on_applicant_room();	
								   
			 

insert into payment(applicant_id,room_id,payment_date,payment_method,amount_in_GH₵ )
values(1, 1, '2022-09-01', 'Credit Card', 5000.00),
(2, 2, '2022-09-02', 'Bank Transfer', 3500.00),
(3, 3, '2022-09-03', 'Mobile Money', 6000.00),
(4, 4, '2022-09-04', 'Cash', 4500.00),
(5, 5, '2022-09-05', 'Credit Card', 4000.00),
(6, 6, '2022-09-06', 'Bank Transfer', 7000.00),
(7, 7, '2022-09-07', 'Mobile Money', 5500.00),
(8, 8, '2022-09-08', 'Cash', 3000.00),
(9, 9, '2022-09-09', 'Credit Card', 6500.00),
(10, 10, '2022-09-10', 'Bank Transfer', 4800.00),
(11, 11, '2022-09-11', 'Mobile Money', 3800.00),
(12, 12, '2022-09-12', 'Cash', 7500.00),
(13, 13, '2022-09-13', 'Credit Card', 4200.00),
(14, 14, '2022-09-14', 'Bank Transfer', 3200.00),
(15, 15, '2022-09-15', 'Mobile Money', 5800.00),
(16, 16, '2022-09-16', 'Cash', 5300.00),
(17, 17, '2022-09-17', 'Credit Card', 4200.00),
(18, 8, '2022-09-18', 'Bank Transfer', 8000.00),
(109, 19, '2022-09-19', 'Mobile Money', 5200.00),
(20, 2, '2022-09-20', 'Cash', 4000.00),
(21, 21, '2022-09-21', 'Credit Card', 7200.00),
(22, 22, '2022-09-22', 'Bank Transfer', 4400.00),
(23, 23, '2022-09-23', 'Mobile Money', 2900.00);




		     
			
			




	  
	  