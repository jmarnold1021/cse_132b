
Drop Table NumChanges;
Drop Table Prereqs;
Drop Table Concentration;
Drop Trigger check_enrolled_insert_update on Enrolled;
Drop Table Enrolled;
Drop Trigger check_academichist_insert_update on AcademicHistory
Drop Table AcademicHistory;

Drop Table Section;
Drop Table Classes;
Drop Table Course;

Drop Table DegreeCategories;
Drop Table DegreeReqs;







CREATE TABLE Course( num varchar(10) NOT NULL,
                     min_units int NOT NULL,
                     max_units int NOT NULL,
										 grade_type varchar(5) NOT NULL,
										 labwork_req boolean NOT NULL,
										 CONSTRAINT grade_choice CHECK ( UPPER(grade_type)='O' OR 
										                                 UPPER(grade_type)='L' OR 
																										 UPPER(grade_type)='S/U' OR  
																										 UPPER(grade_type)='P/NP'
																									 ), 
										 PRIMARY KEY (num)
                   );


CREATE TABLE Section( id int NOT NULL,
                      sect_type varchar(5),
											rev_date date NOT NULL,
											mand_dis boolean NOT NULL,
											
											day1 varchar(15) NOT NULL,
											day2 varchar(15) NOT NULL,
											day3 varchar(15) NOT NULL,
											
											
											start_time time NOT NULL,
											end_time time NOT NULL,

											building varchar(20) NOT NULL,
											room varchar(10) NOT NULL,
											class_size int NOT NULL,
											FOREIGN KEY(id) REFERENCES Classes(class_id) ON DELETE CASCADE,
											CONSTRAINT sect_types CHECK ( UPPER(sect_type)='LE' OR 
										                                 UPPER(sect_type)='LA' OR 
																										 UPPER(sect_type)='DI' OR  
																										 UPPER(sect_type)='RE' 
																									),
                      CONSTRAINT day1_name CHECK ( UPPER(day1)='M' OR 
										                                 UPPER(day1)='TU' OR 
																										 UPPER(day1)='W' OR  
																										 UPPER(day1)='TH' OR
																										 UPPER(day1)='F' OR 
																										 UPPER(day1)='SAT' OR
																										 UPPER(day1)='SUN' OR
																										 UPPER(day1)='N/A'
																									),
											CONSTRAINT day2_name CHECK ( UPPER(day2)='M' OR 
										                                 UPPER(day2)='TU' OR 
																										 UPPER(day2)='W' OR  
																										 UPPER(day2)='TH' OR
																										 UPPER(day2)='F' OR 
																										 UPPER(day2)='SAT' OR
																										 UPPER(day2)='SUN'OR
																										 UPPER(day2)='N/A'  
																									),
											CONSTRAINT day3_name CHECK ( UPPER(day3)='M' OR 
										                                 UPPER(day3)='TU' OR 
																										 UPPER(day3)='W' OR  
																										 UPPER(day3)='TH' OR
																										 UPPER(day3)='F' OR 
																										 UPPER(day3)='SAT' OR
																										 UPPER(day3)='SUN' OR
																										 UPPER(day3)='N/A' 
																									)
											);									 

CREATE TABLE Classes( class_id serial NOT NULL,
                      num varchar(10) NOT NULL,
                      year int NOT NULL,
                      qtr varchar(10) NOT NULL,
											fac varchar(30) NOT NULL,
										  PRIMARY KEY (class_id),
											FOREIGN KEY (fac) REFERENCES Faculty(name) ON DELETE CASCADE,
											FOREIGN KEY(num) REFERENCES Course(num) ON DELETE CASCADE,
											CONSTRAINT qtr_value CHECK ( UPPER(qtr)='F' OR 
										                                 UPPER(qtr)='W' OR 
																										 UPPER(qtr)='S' OR  
																										 UPPER(qtr)='S1' OR
																										 UPPER(qtr)='S2'
																										)
																										 
                   );

CREATE TABLE Enrolled( stu_id int NOT NULL,
											 class_id int NOT NULL,
											 units int NOT NULL,
											 grade_type varchar(5) NOT NULL,

										   PRIMARY KEY (stu_id,class_id),
											 FOREIGN KEY (stu_id) REFERENCES Student(id) ON DELETE CASCADE,
											 FOREIGN KEY (class_id) REFERENCES Classes(class_id) ON DELETE CASCADE																					 
											 
                   );

									 
CREATE OR REPLACE FUNCTION enrolled_before_insert_update() RETURNS TRIGGER AS $enrolled_before_insert_update$ 
  BEGIN
   


	  IF( (Select count(*) from classes where class_id=NEW.class_id AND year=2015 AND qtr='W')=1 )
    THEN
		  IF( (select count(*) from course where num in (select num from classes where class_id=NEW.class_id) 
			     Group by num Having (min_units<=NEW.units) AND (max_units>=NEW.units) ) = 1
				)
			THEN	

		    IF( (select grade_type from course where num in 
				                                   (select num from classes where class_id=NEW.class_id)) = 'O' 
					) 
			  THEN
          RETURN NEW;
				END IF;

				IF( (select count(*) from course where num in 
				                                (select num from classes where class_id=NEW.class_id) AND grade_type=NEW.grade_type) = 1  
				  )
			  THEN
          RETURN NEW;
				END IF;

        RAISE EXCEPTION 'Grade Type Does not Match Courses Grade Type';
		    RETURN NULL;
		  END IF;
			RAISE EXCEPTION 'Chosen Units out of range for Course';
		  RETURN NULL;
		END IF;
		
		RAISE EXCEPTION 'Can Only enroll in a class from the Curent year=2015 and qtr=W';
		RETURN NULL;
  END;
$enrolled_before_insert_update$ LANGUAGE plpgsql;
CREATE TRIGGER check_enrolled_insert_update BEFORE INSERT OR UPDATE ON Enrolled 
FOR EACH ROW EXECUTE PROCEDURE enrolled_before_insert_update();									 


/*
CREATE TABLE Waitlisted( stu_id int NOT NULL, 
                         year int NOT NULL,
                         qtr varchar(10) NOT NULL,
											   sect_id int NOT NULL,
												 pos int NOT NULL,
										     PRIMARY KEY (year,qtr,sect_id,stu_id),
											   FOREIGN KEY (year,qtr,sect_id) REFERENCES Classes(year,qtr,sect_id),
											   FOREIGN KEY (stu_id) REFERENCES Student(id),
											   CONSTRAINT qtr_value CHECK ( UPPER(qtr)='F' OR 
										                                 UPPER(qtr)='W' OR 
																										 UPPER(qtr)='S' OR  
																										 UPPER(qtr)='S1' OR
																										 UPPER(qtr)='S2'
																										)
																										 
                     );
*/										 
CREATE TABLE AcademicHistory(stu_id int NOT NULL,
											       class_id int NOT NULL,
														 units int NOT NULL,
														 
														 grade_type varchar(5) NOT NULL,
														 
														 
														 grade varchar(5),
														 
														 
										         PRIMARY KEY (stu_id,class_id),
											       FOREIGN KEY (stu_id) REFERENCES Student(id) ON DELETE CASCADE,
											       FOREIGN KEY (class_id) REFERENCES Classes(id) ON DELETE CASCADE,

                             CONSTRAINT grade_value CHECK ( 
														                                 UPPER(grade)='A+' OR 
														                                 UPPER(grade)='A' OR 
										                                         UPPER(grade)='A-' OR 
																										         UPPER(grade)='B+' OR 
														                                 UPPER(grade)='B' OR 
										                                         UPPER(grade)='B-' OR
																														 UPPER(grade)='C+' OR 
														                                 UPPER(grade)='C' OR 
										                                         UPPER(grade)='C-' OR
																														 UPPER(grade)='D+' OR 
														                                 UPPER(grade)='D' OR 
										                                         UPPER(grade)='D-' OR
										                                         UPPER(grade)='F' OR
										                                         UPPER(grade)='S' OR
										                                         UPPER(grade)='U' OR
																														 UPPER(grade)='W' 
																														 
																													 ),																											 

                             CONSTRAINT grade_assignment CHECK (  (UPPER(grade_type)='S/U' AND (UPPER(grade)='S' OR UPPER(grade)='U' OR UPPER(grade)='W' OR UPPER(grade)='N/C'))  OR  
										                                              (UPPER(grade_type)='L' AND (UPPER(grade)!='S' AND UPPER(grade)!='U'))
																										         	 )
																										 
                   );
CREATE OR REPLACE FUNCTION academichist_before_insert_update() RETURNS TRIGGER AS $academichist_before_insert_update$ 
  BEGIN
    IF( (Select count(*) from classes where class_id=NEW.class_id AND year=2015 AND qtr='W')=0 )
    THEN

		  IF( (select count(*) from course where num in (select num from classes where class_id=NEW.class_id) 
			     Group by num Having (min_units<=NEW.units) AND (max_units>=NEW.units) ) = 1
			  )
		  THEN	

		    IF( (select grade_type from course where num in 
				                                   (select num from classes where class_id=NEW.class_id)) = 'O' 
				  ) 
			  THEN
          RETURN NEW;
			  END IF;

			  IF( (select count(*) from course where num in 
				                                (select num from classes where class_id=NEW.class_id) AND grade_type=NEW.grade_type) = 1  
				  )
			  THEN
          RETURN NEW;
			  END IF;

        RAISE EXCEPTION 'Grade Type Does not Match Courses Grade Type';
		    RETURN NULL;
		  END IF;
	    RAISE EXCEPTION 'Chosen Units out of range for Course';
		  RETURN NULL;
		END IF;
		RAISE EXCEPTION 'Can only add previous courses to academic history';
		RETURN NULL;
  END;
$academichist_before_insert_update$ LANGUAGE plpgsql;
CREATE TRIGGER check_academichist_insert_update BEFORE INSERT OR UPDATE ON academichistory 
FOR EACH ROW EXECUTE PROCEDURE academichist_before_insert_update();									 
									 
									 
									 
CREATE TABLE Concentration( num varchar(10) NOT NULL,
										        conc varchar(30) NOT NULL,
										        FOREIGN KEY (num) REFERENCES Course(num) ON DELETE CASCADE,
														PRIMARY KEY(num,conc)
                          );

CREATE TABLE DegreeReqs( name varchar(40) NOT NULL,
										     deg_type varchar(10) NOT NULL,
												 dept varchar(15),
												 avg_uc_gpa float NOT NULL,
												 req_conc varchar(30) NOT NULL,
												 total_units int NOT NULL,
												 PRIMARY KEY(name,deg_type),
												 CONSTRAINT deg_type_val CHECK ( UPPER(deg_type)='B.A.' OR
												                                 UPPER(deg_type)='B.S.' OR
												                                 UPPER(deg_type)='M.A.' OR
																												 
												                                 UPPER(deg_type)='M.S.' OR
												                                 UPPER(deg_type)='PH.D.' OR
												                                 UPPER(deg_type)='M.D.' OR
																												 
												                                 UPPER(deg_type)='A.A.' OR
												                                 UPPER(deg_type)='A.S.' 
																											 ),

												 CONSTRAINT Only_Masters_require_concentration CHECK ( req_conc='N/A' OR
												                                                      (req_conc!='N/A' AND (UPPER(deg_type)='M.S.' OR UPPER(deg_type)='M.A.'))
																												                     )
											 );
CREATE Table DegreeCategories( name varchar(40) NOT NULL,
                               deg_type varchar(10) NOT NULL,
                               cat_type varchar(20) NOT NULL,
															 req_units int NOT NULL,
															 avg_cat_gpa float NOT NULL,
															 PRIMARY KEY(name,deg_type,cat_type),
															 FOREIGN KEY(name,deg_type) REFERENCES DegreeReqs(name,deg_type) ON DELETE CASCADE
														);																															
												                           


CREATE TABLE Prereqs( num varchar(10) NOT NULL,
										  pre_num varchar(10) NOT NULL,
										  FOREIGN KEY (num) REFERENCES Course(num) ON DELETE CASCADE,
										  FOREIGN KEY (pre_num) REFERENCES Course(num) ON DELETE CASCADE,
											PRIMARY KEY(num,pre_num)
										);
/*
CREATE TABLE Corereqs( num varchar(10) NOT NULL,
										  core_num varchar(10) NOT NULL,
										  FOREIGN KEY (num) REFERENCES Course(num),
										  FOREIGN KEY (core_num) REFERENCES Course(num),
											PRIMARY KEY(num,pre_num)
										);										
*/

CREATE TABLE NumChanges( num_from varchar(10) NOT NULL,
										  num_to varchar(10) NOT NULL,
											year_changed int NOT NULL,
										  FOREIGN KEY (num_to) REFERENCES Course(num) ON DELETE CASCADE,
											PRIMARY KEY(num_from,num_to)
										);										



