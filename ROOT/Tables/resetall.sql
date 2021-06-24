IF EXISTS(SELECT * FROM Student); 
Drop Table Student;
CREATE TABLE student( id serial NOT NULL,  
                      first_name  varchar(30) NOT NULL,
                      middle_name varchar(30), 
										  last_name varchar(30) NOT NULL, 
										  start_date date NOT NULL, 
										  end_date date,
											PRIMARY KEY(id)
										);


IF EXISTS(SELECT * FROM Course); 
Drop Table Course;
CREATE TABLE Course( c_id serial NOT NULL,
                     num varchar(10) NOT NULL,
                     year int NOT NULL,
                     min_units int NOT NULL,
                     max_units int NOT NULL,
										 grade_type varchar(5) NOT NULL,
										 grade_type_choice boolean NOT NULL,
										 labwork_req boolean NOT NULL,
										 CONSTRAINT course_id PRIMARY KEY (c_id,num,year)
                   );

IF EXISTS(SELECT * FROM Consentration); 
Drop Table Concentration;
CREATE TABLE Concentration( c_id serial NOT NULL,
                            num varchar(10) NOT NULL,
                            year int NOT NULL,
										        conc varchar(30) NOT NULL,
										        Constraint course_id FOREIGN KEY (c_id,num,year) REFERENCES Course(c_id,num,year)
                          );



IF EXISTS(SELECT * FROM Prereqs); 
Drop Table Prereqs;
CREATE TABLE Prereqs( c_id serial NOT NULL,
                      c_num varchar(10) NOT NULL,
                      c_year int NOT NULL,
											pre_id serial NOT NULL,
                      pre_num varchar(10) NOT NULL,
                      pre_year int NOT NULL,
										  Constraint course_id FOREIGN KEY (c_id,c_num,c_year) REFERENCES Course(c_id,num,year),
										  Constraint prereq_id FOREIGN KEY (pre_id,pre_num,pre_year) REFERENCES Course(c_id,num,year)
										);
