Drop Table Student;
CREATE TABLE student (id serial,  
                     first_name  varchar(30) NOT NULL,
                     middle_name varchar(30), 
										 last_name varchar(30) NOT NULL, 
										 start_date date NOT NULL, 
										 end_date date);
