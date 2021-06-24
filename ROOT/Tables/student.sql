

Drop MATERIALIZED View CPGQ;
Drop MATERIALIZED View CPG;

Drop Table rev_times;
Drop Table Grade_Conversion;
Drop Table qtr_conversion;
Drop Table day_conversion;

Drop Table Minors;
Drop Table Majors;
Drop Table GradDegrees;
Drop Trigger check_grad_dept on graduate;
Drop Table Graduate;
Drop Table Undergraduate;
Drop Table PrivateInfo;
Drop Table AttendanceInfo;




Drop Table NumChanges;
Drop Table Prereqs;
Drop Table Categories;
Drop Table Concentration;
Drop Trigger check_enrolled_insert_update on Enrolled;
Drop Table Enrolled;
Drop Trigger check_academichist_insert_update on AcademicHistory;
Drop Trigger check_academichist_insert_update_after on AcademicHistory;
Drop Table AcademicHistory;


Drop Trigger check_section_insert_update on Section;
Drop Table Section;

Drop Trigger check_class_start_insert_update on classes;
Drop Table Classes;
Drop Table Course;
Drop Table Student;
Drop Table Faculty;


Drop Table DegreeConcentrations;
Drop Table DegreeCategories;
Drop Table DegreeReqs;







CREATE TABLE Course( num varchar(10) NOT NULL,
                     dept varchar(10) NOT NULL,
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

									 
CREATE TABLE Faculty( name varchar(30) NOT NULL,
                      title varchar(30) NOT NULL,
											dept varchar(30) NOT NULL,
											PRIMARY KEY(name),
											CONSTRAINT fact_titles CHECK ( UPPER(title)='L' OR 
										                                 UPPER(title)='ASP' OR 
																										 UPPER(title)='ACP' OR  
																										 UPPER(title)='P' 
																									)
										);





CREATE TABLE Student( id serial NOT NULL,
                      ssn varchar(15) NOT NULL,
                      first_name  varchar(30) NOT NULL,
                      middle_name varchar(30), 
										  last_name varchar(30) NOT NULL, 
										  start_date date NOT NULL, 
										  end_date date,
											PRIMARY KEY(id)
										);
										
 

									 

CREATE TABLE Classes( class_id int NOT NULL,
                      num varchar(10) NOT NULL,
                      title varchar(50) NOT NULL,
											year int NOT NULL,
                      qtr varchar(10) NOT NULL,
											s_date date NOT NULL,
											e_date date NOT NULL,
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
CREATE OR REPLACE FUNCTION class_start_insert_update() RETURNS TRIGGER AS $class_start_insert_update$ 
  BEGIN
  
	  IF (NEW.qtr='F')
		THEN

     	NEW.s_date= (select CURRENT_DATE + i as dt                                                                                                                                                  
                  from (generate_series(DATE(NEW.year||'-10-01')- CURRENT_DATE,                                                                                                                                  
                  DATE(NEW.year||'-10-08') - CURRENT_DATE ) i inner join day_conversion on Extract(DOW from (CURRENT_DATE+(i-1)))=day_val) where dayy='M');
			NEW.e_date= (select (NEW.s_date + 69));	
			RETURN NEW;  
		
		
    END IF;
		IF(NEW.qtr='W')
		THEN

			NEW.s_date= (select CURRENT_DATE + i as dt                                                                                                                                                  
                  from (generate_series(DATE(NEW.year||'-01-01')- CURRENT_DATE,                                                                                                                                  
                  DATE(NEW.year||'-01-08') - CURRENT_DATE ) i inner join day_conversion on Extract(DOW from (CURRENT_DATE+(i-1)))=day_val) where dayy='M');
			NEW.e_date= (select (NEW.s_date + 69));	
			RETURN NEW;

		END IF;

		IF(NEW.qtr='S')
	  THEN
			NEW.s_date= (select CURRENT_DATE + i as dt                                                                                                                                                  
                  from (generate_series(DATE(NEW.year||'-03-26')- CURRENT_DATE,                                                                                                                                  
                  DATE(NEW.year||'-04-02') - CURRENT_DATE ) i inner join day_conversion on Extract(DOW from (CURRENT_DATE+(i-1)))=day_val) where dayy='M');
			NEW.e_date= (select (NEW.s_date + 69));	
			RETURN NEW;

		END IF;
	  
		RAISE EXCEPTION 'Not working';
    
		RETURN NULL;
   
	END;
$class_start_insert_update$ LANGUAGE plpgsql;
CREATE TRIGGER check_class_start_insert_update BEFORE INSERT OR UPDATE ON classes 
FOR EACH ROW EXECUTE PROCEDURE class_start_insert_update();


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
											CONSTRAINT meeting_needs_day CHECK ( UPPER(day1)!='N/A' OR 
										                                       UPPER(day2)!='N/A' OR 
																										       UPPER(day3)!='N/A'   																										  
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
																									),
                      CONSTRAINT datt_val CHECK( (sect_type  = 'RE' and rev_date!=date('01-01-0001')) or
											                           (sect_type != 'RE' and rev_date=date('01-01-0001'))
											                          )																									
											);
CREATE OR REPLACE FUNCTION section_before_insert_update() RETURNS TRIGGER AS $section_before_insert_update$ 
  BEGIN

        
		    IF( NEW.sect_type='RE' )
		    THEN
      
			    IF( (select count(*) from classes 
				       where classes.class_id=NEW.id and 
						         NEW.rev_date between classes.s_date and classes.e_date)
				    )
				                                      
			    THEN
				   NEW.day1=(Select dayy from Extract(DOW from NEW.rev_date) as p join day_conversion on p=day_val);
			     RETURN NEW;
			    ELSE
			      RAISE EXCEPTION 'Review Date not in classes time period';
		        RETURN NULL;
          END IF;
        END IF;
			  IF(NEW.sect_type='LE' or NEW.sect_type='LA' or NEW.sect_type='DI')
			  THEN
          
					IF( (select count(*)
               from section a
               where a.id=NEW.id and ( ( NEW.day1!='N/A' and (a.day1=NEW.day1 or a.day2=NEW.day1 or a.day3=NEW.day1) ) or 
                                       ( NEW.day2!='N/A' and (a.day1=NEW.day2 or a.day2=NEW.day2 or a.day3=NEW.day2) ) or											
                                       ( NEW.day3!='N/A' and (a.day1=NEW.day3 or a.day2=NEW.day3 or a.day3=NEW.day3) ) 											
									            	     )	
						                     and (SELECT (a.start_time,a.end_time) OVERLAPS ( NEW.start_time ,NEW.end_time ) ) = true
							) = 0							
					  )
					THEN
            IF( (select count(*) 
						     from section a
                 where a.id in (select c.class_id 
                               from classes c 
                               where (c.fac,c.year,c.qtr) = (select fac,year,qtr 
                                                             from classes 
																						                 where class_id=NEW.id ) 
	 	                           and c.class_id!=NEW.id) 
			                and ( ( NEW.day1!='N/A' and (a.day1=NEW.day1 or a.day2=NEW.day1 or a.day3=NEW.day1) ) or  
                            ( NEW.day2!='N/A' and (a.day1=NEW.day2 or a.day2=NEW.day2 or a.day3=NEW.day2) ) or											
                            ( NEW.day3!='N/A' and (a.day1=NEW.day3 or a.day2=NEW.day3 or a.day3=NEW.day3) ) 												
					                )
                			and	(SELECT (a.start_time,a.end_time) OVERLAPS ( NEW.start_time ,NEW.end_time ) ) = true
						    ) = 0
						  )
				  	THEN

              RETURN NEW;
						
				  	END IF;


						RAISE EXCEPTION 'Faculty already has a Regular meeting scheduled at this time';
		        RETURN NULL;

			    END IF;
          RAISE EXCEPTION 'New Regular Meeting Overlaps an Existing Regular Meeting in this Section';
		      RETURN NULL;
          
        END IF;
	      RAISE EXCEPTION 'Review Date not in classes time period';
		    RETURN NULL;
	END;
$section_before_insert_update$ LANGUAGE plpgsql;
CREATE TRIGGER check_section_insert_update BEFORE INSERT OR UPDATE ON section 
FOR EACH ROW EXECUTE PROCEDURE section_before_insert_update();	





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
   
    

    IF ( (select count(*) from section 
          where id=NEW.class_id and section.class_size > (select count(*) 
				                                                  from enrolled 
																							  	        where class_id=NEW.class_id
																							           )
				 ) != 0
			 )	
		THEN
		  
	    IF( (Select count(*) from classes where class_id=NEW.class_id AND year=2009 AND qtr='S')=1 )
      THEN
		    IF( (select count(*) from course where num in (select num from classes where class_id=NEW.class_id) 
			       Group by num Having (min_units<=NEW.units) AND (max_units>=NEW.units) ) = 1
				  )
			  THEN	

		      IF( (select grade_type from course where num in 
				                                   (select num from classes where class_id=NEW.class_id)) = 'O' 
					  ) 
			    THEN
					  
	           insert into AcademicHistory values(NEW.stu_id,NEW.class_id,NEW.units,NEW.grade_type,'N/C');
						

            RETURN NEW;
				  END IF;

				  IF( (select count(*) from course where num in 
				                                (select num from classes where class_id=NEW.class_id) AND grade_type=NEW.grade_type) = 1  
				    )
			    THEN
	          insert into AcademicHistory values(NEW.stu_id,NEW.class_id,NEW.units,NEW.grade_type,'N/C');
					  
            RETURN NEW;
				  END IF;

          RAISE EXCEPTION 'Grade Type Does not Match Courses Grade Type';
		      RETURN NULL;
		    END IF;
			  RAISE EXCEPTION 'Chosen Units out of range for Course';
		    RETURN NULL;
		  END IF;
		
		  RAISE EXCEPTION 'Can Only enroll in a class from the Curent year=2009 and qtr=S';
		  RETURN NULL;

    END IF;

	  RAISE EXCEPTION 'Enrollment limit reached student added(in dev!!) to waitlist';
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
											       FOREIGN KEY (class_id) REFERENCES Classes(class_id) ON DELETE CASCADE,

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
																														 UPPER(grade)='N/C' OR
																														 UPPER(grade)='W' 
																														 
																													 ),																											 

                             CONSTRAINT grade_assignment CHECK (  (UPPER(grade_type)='S/U' AND (UPPER(grade)='S' OR UPPER(grade)='U' OR UPPER(grade)='W' OR UPPER(grade)='N/C'))  OR  
										                                              (UPPER(grade_type)='L' AND (UPPER(grade)!='S' AND UPPER(grade)!='U'))
																										         	 )
																										 
                   );
CREATE OR REPLACE FUNCTION academichist_before_insert_update() RETURNS TRIGGER AS $academichist_before_insert_update$ 
  BEGIN
   
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

	END;
$academichist_before_insert_update$ LANGUAGE plpgsql;
CREATE TRIGGER check_academichist_insert_update BEFORE INSERT OR UPDATE ON academichistory 
FOR EACH ROW EXECUTE PROCEDURE academichist_before_insert_update();									 



CREATE TABLE Concentration( num varchar(10) NOT NULL,
										        conc varchar(30) NOT NULL,
										        FOREIGN KEY (num) REFERENCES Course(num) ON DELETE CASCADE,
														PRIMARY KEY(num,conc)
                          );
CREATE TABLE Categories( num varchar(10) NOT NULL,
										     cat varchar(30) NOT NULL,
										     FOREIGN KEY (num) REFERENCES Course(num) ON DELETE CASCADE,
												 PRIMARY KEY(num,cat),
												 CONSTRAINT category_value CHECK( cat='TE' OR
															                            cat='LD' OR
															                            cat='UD' OR
																													cat='C'  )
											);													

CREATE TABLE DegreeReqs( name varchar(40) NOT NULL,
                         university varchar(40) NOT NULL,
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
															 FOREIGN KEY(name,deg_type) REFERENCES DegreeReqs(name,deg_type) ON DELETE CASCADE,
															                                 
															 CONSTRAINT category_value CHECK( cat_type='TE' OR
															                                  cat_type='LD' OR
															                                  cat_type='UD' OR
																																cat_type='C' 
																															)
																																
														);

CREATE Table DegreeConcentrations( name varchar(40) NOT NULL,
                                   deg_type varchar(10) NOT NULL,
                                   cat_type varchar(20) NOT NULL,
															     req_units int NOT NULL,
															     avg_cat_gpa float NOT NULL,
															     PRIMARY KEY(name,deg_type,cat_type),
															     FOREIGN KEY(name,deg_type) REFERENCES DegreeReqs(name,deg_type) ON DELETE CASCADE,
															     CONSTRAINT ctype_dtype_value CHECK( deg_type='M.S.'OR deg_type='M.A.')
															                                        																																
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







CREATE TABLE AttendanceInfo( id int NOT NULL,
                            att_year int NOT NULL,
												    att_qtr varchar(10),
                            status varchar(15),
												   	reason varchar(30),
														PRIMARY KEY(id,att_year,att_qtr),
														FOREIGN KEY(id) REFERENCES Student(id) ON DELETE CASCADE,
														CONSTRAINT avademic_status_value CHECK ( UPPER(status)='GOOD' OR (UPPER(status)='PROBATION' AND UPPER(reason)!='N/A'))
		 		 																					                         

													);



CREATE TABLE PrivateInfo( id int NOT NULL,  
                      ssn varchar(30) NOT NULL,
											res varchar(20) NOT NULL,
                      address varchar(30) NOT NULL, 
										  city varchar(30) NOT NULL, 
										  state varchar(30)NOT NULL, 
										  zip int NOT NULL,
											dob date NOT NULL,
											email varchar(50) NOT NULL,
											phn_num varchar(50) NOT NULL,
											gender varchar(10) NOT NULL,
											PRIMARY KEY(id),
											FOREIGN KEY(id) REFERENCES Student(id) ON DELETE CASCADE,
											CONSTRAINT residency_value CHECK( UPPER(res)='CA' OR UPPER(res)='NCA' OR UPPER(res)='FS' )
										);
										
CREATE TABLE Graduate( id int NOT NULL,
                            dept varchar(15) NOT NULL,
														status varchar(5) NOT NULL,
														candidate boolean NOT NULL,
													  advisor varchar(30) NOT NULL,
														fac1 varchar(30) NOT NULL,
													  fac2 varchar(30) NOT NULL,
													  fac3 varchar(30) NOT NULL,
    											  o_fac varchar(30) NOT NULL,
                     			  PRIMARY KEY(id),
											      FOREIGN KEY(id) REFERENCES Student(id) ON DELETE CASCADE,
														FOREIGN KEY (fac1) REFERENCES Faculty(name),
														FOREIGN KEY (fac2) REFERENCES Faculty(name),
														FOREIGN KEY (fac3) REFERENCES Faculty(name),
														FOREIGN KEY (advisor) REFERENCES Faculty(name),
														
														FOREIGN KEY (o_fac) REFERENCES Faculty(name),


														
														
														
														

														CONSTRAINT Candidacy_Requires_PHD_Status CHECK ( (UPPER(status)='M/S' AND candidate = false ) OR 
																										                          UPPER(status)='PHD'
		 		 																					                         ),
													  CONSTRAINT unique_committee CHECK ( (candidate=false AND fac1!=fac2 AND fac1!=fac3 AND fac2!=fac3 AND advisor=fac1 AND o_fac=fac1) OR
														                                    (candidate=true AND  fac1!=fac2 AND fac1!=fac3 AND fac1!=advisor AND fac1!=o_fac AND 
																																										 fac2!=fac3 AND fac2!=advisor AND fac2!=o_fac AND 
																																									   fac3!=advisor AND fac3!= o_fac AND
																																										 advisor!=o_fac)
														                                  )
                   );
CREATE OR REPLACE FUNCTION check_dept() RETURNS TRIGGER AS $check_dept$ 
  BEGIN
	  IF( NEW.candidate = true ) 
		THEN

		  IF( NEW.dept IN (SELECT dept FROM Faculty Where name=NEW.fac1) AND
		      NEW.dept IN (SELECT dept FROM Faculty Where name=NEW.fac2) AND
			  	NEW.dept IN (SELECT dept FROM Faculty Where name=NEW.fac3) AND
			  	NEW.dept IN (SELECT dept FROM Faculty Where name=NEW.advisor)  AND
			  	NEW.dept NOT IN (SELECT dept FROM Faculty Where name=NEW.o_fac)
				)
			THEN
		    RETURN NEW;
		END IF;
		

		ELSIF( NEW.candidate = false ) 
		THEN

		  IF( NEW.dept IN (SELECT dept FROM Faculty Where name=NEW.fac1) AND
		      NEW.dept IN (SELECT dept FROM Faculty Where name=NEW.fac2) AND
			  	NEW.dept IN (SELECT dept FROM Faculty Where name=NEW.fac3)
				)
			THEN
		    RETURN NEW;
			END IF;

    END IF;
		
		RAISE EXCEPTION 'Fac 1,2,3 and Advisor Must be from the Graduates Dept Ouside Fac Must Be From a Different Dept';
		RETURN NULL;
  END;
$check_dept$ LANGUAGE plpgsql;
CREATE TRIGGER check_grad_dept BEFORE INSERT OR UPDATE ON graduate 
FOR EACH ROW EXECUTE PROCEDURE check_dept();									 

							 
										 
CREATE TABLE Undergraduate( id int NOT NULL,
                            college varchar(30) NOT NULL,
                     			  PRIMARY KEY(id),
											      FOREIGN KEY(id) REFERENCES Student(id) ON DELETE CASCADE,
														CONSTRAINT college_value CHECK( UPPER(college)='MUIR' OR
														                                UPPER(college)='MARSHALL' OR
														                                UPPER(college)='WARREN' OR
														                                UPPER(college)='ROOSEVELT' OR
														                                UPPER(college)='SIXTH' OR
														                                UPPER(college)='REVELLE'
																													 )
										      );
CREATE TABLE GradDegrees( id int NOT NULL,
                     deg varchar(30) NOT NULL,
										 d_type varchar(7) NOT NULL,
                     PRIMARY KEY(id,deg,d_type),
										 Foreign KEY(deg,d_type) REFERENCES DegreeReqs(name,deg_type) ON DELETE CASCADE,
										 FOREIGN KEY(id) REFERENCES Graduate(id) ON DELETE CASCADE
									 );													

CREATE TABLE Majors( id int NOT NULL,
                     major varchar(30) NOT NULL,
										 d_type varchar(7) NOT NULL,
                     PRIMARY KEY(id,major,d_type),
										 FOREIGN KEY(major,d_type) REFERENCES DegreeReqs(name,deg_type) ON DELETE CASCADE,
										 FOREIGN KEY(id) REFERENCES Undergraduate(id) ON DELETE CASCADE
									 );	
									 
CREATE TABLE Minors( id int NOT NULL,
                     minor varchar(30) NOT NULL,
                     PRIMARY KEY(id,minor),
										 FOREIGN KEY(id) REFERENCES Undergraduate(id) ON DELETE CASCADE
									 );
										 
create table GRADE_CONVERSION
( LETTER_GRADE varchar(5) NOT NULL,
NUMBER_GRADE float NOT NULL,
CAT varchar(5) NOT NULL
);
create table qtr_conversion
( qtrr varchar(5) NOT NULL,
  qtr_val int NOT NULL
);
create table day_conversion
( dayy varchar(5) NOT NULL,
  day_val int NOT NULL
);

create table rev_times(rtime time NOT NULL,
                       etime time NOT NULL);


insert into grade_conversion values('A+', 4.3 ,'A');
insert into grade_conversion values('A' , 4.0 ,'A');
insert into grade_conversion values('A-', 3.7 ,'A');
insert into grade_conversion values('B+', 3.4 ,'B');
insert into grade_conversion values('B' , 3.1 ,'B');
insert into grade_conversion values('B-', 2.8 ,'B');
insert into grade_conversion values('C+', 2.5 ,'C');
insert into grade_conversion values('C' , 2.2 ,'C');
insert into grade_conversion values('C-', 1.9 ,'C');
insert into grade_conversion values('D+', 1.6 ,'D');
insert into grade_conversion values('D' , 1.6 ,'D');
insert into grade_conversion values('D-', 1.0 ,'D');
insert into grade_conversion values('F' , 0.0 ,'F');

insert into grade_conversion values('S' , 0.0 ,'S/U');
insert into grade_conversion values('U' , 0.0 ,'S/U');


insert into qtr_conversion values('S1' ,0);
insert into qtr_conversion values('S2' ,1);
insert into qtr_conversion values('F'  ,2);
insert into qtr_conversion values('W'  ,3);
insert into qtr_conversion values('S'  ,4);

insert into day_conversion values('M'    ,0);
insert into day_conversion values('TU'   ,1);
insert into day_conversion values('W'    ,2);
insert into day_conversion values('TH'   ,3);
insert into day_conversion values('F'    ,4);
insert into day_conversion values('SAT'  ,5);
insert into day_conversion values('SUN'  ,6);


insert into rev_times values(time '08:00:00',time '09:00:00');
insert into rev_times values(time '09:00:00',time '10:00:00');
insert into rev_times values(time '10:00:00',time '11:00:00');
insert into rev_times values(time '11:00:00',time '12:00:00');
insert into rev_times values(time '12:00:00',time '13:00:00');
insert into rev_times values(time '13:00:00',time '14:00:00');
insert into rev_times values(time '14:00:00',time '15:00:00');
insert into rev_times values(time '15:00:00',time '16:00:00');
insert into rev_times values(time '16:00:00',time '17:00:00');
insert into rev_times values(time '17:00:00',time '18:00:00');
insert into rev_times values(time '18:00:00',time '19:00:00');
insert into rev_times values(time '19:00:00',time '20:00:00');											 


CREATE MATERIALIZED VIEW CPGQ(cnum,cyr,cqtr,cfac,cgd,ccnt) AS select c.n as cnum,c.yr as cyr,c.q as cqtr,c.f as cfac,CAT as gd,count(c.grd) as cnt 
                                from grade_conversion left outer join 
                                (select classes.class_id as cid,num as n,year as yr,qtr as q,fac as f,grade as grd 
                                 from classes join academichistory on classes.class_id=academichistory.class_id  ) as c on (LETTER_GRADE=grd) 
						
                                group by c.n,c.yr,c.q,c.f,CAT 
                                Having 
																(CAT='A' or 
                                CAT='B' or 
                                CAT='C' or 												    
                                CAT='D' or 
                                CAT='F' or 
                                CAT='S/U') and count(c.grd)!=0 
                                ORDER BY CAT ASC
										           ;
															 
														 

CREATE MATERIALIZED VIEW CPG(cnum,cfac,cgd,ccnt) AS select c.n as cnum,c.f as cfac,CAT as gd,count(c.grd) as cnt 
                                     from grade_conversion left outer join 
                                          (select classes.class_id as cid,num as n,fac as f,grade as grd 
                                           from classes join academichistory on classes.class_id=academichistory.class_id  ) as c on (LETTER_GRADE=grd) 
                                           group by c.n,c.f,CAT 
                                           Having 
																					 (CAT='A' or 
                                           CAT='B' or 
                                           CAT='C' or 												    
                                           CAT='D' or 
                                           CAT='F' or 
                                           CAT='S/U') and count(c.grd)!=0 
                                           ORDER BY CAT ASC										           
																					 ;



CREATE OR REPLACE FUNCTION academichist_after_insert_update() RETURNS TRIGGER AS $academichist_after_insert_update$ 
  BEGIN

	  
	  REFRESH MATERIALIZED VIEW CPG;
	  REFRESH MATERIALIZED VIEW CPGQ;
		RETURN NULL;
  END;
$academichist_after_insert_update$ LANGUAGE plpgsql;
CREATE TRIGGER check_academichist_insert_update_after AFTER INSERT OR UPDATE OR DELETE ON academichistory 
FOR EACH ROW EXECUTE PROCEDURE academichist_after_insert_update();


/*Select  * from ((students INNER JOIN AcademicHistory on (student.id=AcademicHistory.stu_id)) where academichistory.class_id=1;*/
   /*INNER JOIN student on (AcademicHistory.stu_id=student.id)) where classes.class_id=1; */
																						 /*INNER JOIN section on (classes.class_id=section.id));*/



/*select sum(temp_class.units) as sum from ((temp_class inner join course on (temp_class.num=course.num)) inner join categories on (categories.num=course.num)) where cat=?;*/																						 
/*select sum(academichistory.units*NUMBER_GRADE)/sum(academichistory.units) from (((( academichistory inner join Grade_Conversion on grade=LETTER_GRADE) inner join Classes on (academichistory.class_id=classes.class_id)) inner join course on (classes.num=course.num)) inner join concentration on (course.num=concentration.num)) where conc='digital' and stu_id=1;*/
/*select * from ((academichistory inner join classes on academichistory.class_id=classes.class_id) inner join Grade_Conversion on grade=LETTER_GRADE) where stu_id=1 and grade!='F' and grade!='U' and grade!='W' and grade!='N/C'; */
/*select classes.num,academichistory.units,LETTER_GRADE from (((( academichistory inner join Grade_Conversion on grade=LETTER_GRADE) inner join Classes on (academichistory.class_id=classes.class_id)) inner join course on (classes.num=course.num)) inner join concentration on (course.num=concentration.num)) where conc='digital' and stu_id=1;*/

/*Create table temp_class as select classes.num,grade,NUMBER_GRADE,units  from (((academichistory inner join grade_conversion on grade=LETTER_GRADE) inner join classes on academichistory.class_id=classes.class_id) inner join course on classes.num=course.num) where stu_id=1 and grade!='F' and grade!='U' and grade!='W' and grade!='N/C';*/


/*select classes.num,min(year),min(qtr_val) from (((classes inner join course on classes.num=course.num)
                                            inner join qtr_conversion on qtr=qtrr)
																						inner join concentration on classes.num=concentration.num)
                                            where conc='databases' and classes.num not in 
				                                                                         ( select c.num from (academichistory a inner join classes c on a.class_id=c.class_id) 
																				                                           where a.stu_id=1 and grade!='F' and grade!='U' and grade!='W' and grade!='N/C'
																			                                         	 )
																				    group by classes.num
																				    having min(year)>2005 or (min(year)=2005 and (min(qtr_val)=0 or min(qtr_val)=1 or min(qtr_val)=2));*/
																				 


/*select classes.num,min(year),min(qtr_val) from (((classes inner join course on classes.num=course.num) inner join qtr_conversion on qtr=qtrr) inner join concentration on classes.num=concentration.num) where conc='databases' and classes.num not in ( select c.num from (academichistory a inner join classes c on a.class_id=c.class_id) where a.stu_id=1 and grade!='F' and grade!='U' and grade!='W' and grade!='N/C') group by classes.num having min(year)>2005 or (min(year)=2005 and (min(qtr_val)=0 or min(qtr_val)=1 or min(qtr_val)=2));*/

																			                                         	 
																				    /*group by classes.num*/

/*reviews*/
/*
 

Select * from
(select CURRENT_DATE+i as dt,dayy as dayy2,rtime as rrtime,etime as eetime
 from (generate_series((DATE('03-30-2009'))- CURRENT_DATE,(DATE('2009-04-06') - CURRENT_DATE) ) i 
			 join day_conversion on day_val=Extract(DOW from CURRENT_DATE+(i-1)) ),
       rev_times) as all_ints
where all_ints.dayy2 not in (select distinct(dayy) from (((section join day_conversion on (section.day1=dayy or section.day2=dayy or section.day3=dayy))
														                                      join enrolled on section.id=enrolled.class_id)
                                                                  join student on student.id=stu_id)
																																	where student.id in (select ccc.stu_id from (((section join day_conversion on (section.day1=dayy or section.day2=dayy or section.day3=dayy))
														                                                                                     join enrolled on section.id=enrolled.class_id)
                                                                                                                 join student on student.id=stu_id) as ccc
																																																								 where ccc.class_id=13
																																											)
                            )
or
		  (Select count(*) from (((section join day_conversion on (section.day1=dayy or section.day2=dayy or section.day3=dayy))
														           join enrolled on enrolled.class_id=section.id)
                                       join student on student.id=stu_id)
			 where ((sect_type!='RE' and dayy=all_ints.dayy2 and (SELECT (start_time,end_time) OVERLAPS (all_ints.rrtime,all_ints.eetime) )=true) or
						 (sect_type='RE' and rev_date=all_ints.dt and (SELECT (start_time,end_time) OVERLAPS (all_ints.rrtime,all_ints.eetime) )=true)) and
						 student.id in (select distinct(ccc.stu_id) from (((section join day_conversion on (section.day1=dayy or section.day2=dayy or section.day3=dayy))
                                                                        join enrolled on section.id=enrolled.class_id)
                                                                        join student on student.id=stu_id) as ccc
																																			  where ccc.class_id=13
													 )
			)=0
order by all_ints.dt,all_ints.rrtime,all_ints.eetime			

*/


/*
select CAT,count(c.grd) from
grade_conversion left outer join 
(select classes.class_id as cid,num as n,grade as grd
from classes join academichistory on classes.class_id=academichistory.class_id  
where num='cse 1') as c on (LETTER_GRADE=grd) or (grd=NULL)
group by CAT
Having 
CAT='A' or 
CAT='B' or
CAT='C' or
CAT='D'  or
CAT='O'
ORDER BY CAT ASC;


select num,year,qtr,fac,count(*)
from classes   
where fac='Diba' and num='cse 140' and year='2008' and qtr='W'
group by num,year,qtr,fac
;


																																									
select c.n,c.f,SUM(cunits*NUMBER_GRADE)/SUM(cunits) from
grade_conversion join 
(select units as cunits,num as n,fac as f,grade as grd
from classes join academichistory on classes.class_id=academichistory.class_id  
where fac='Diba' and num='cse 140' ) as c on (LETTER_GRADE=grd)
group by c.n,c.f





group by c.n,c.f,LETTER_GRADE,NUMBER_GRADE
Having LETTER_GRADE='A+' or
LETTER_GRADE='A'  or
LETTER_GRADE='A-' or
LETTER_GRADE='B+' or
LETTER_GRADE='B'  or
LETTER_GRADE='B-' or
LETTER_GRADE='C+' or
LETTER_GRADE='C'  or
LETTER_GRADE='C-' or
LETTER_GRADE='D+' or
LETTER_GRADE='D'  or
LETTER_GRADE='D-' or
LETTER_GRADE='S'
ORDER BY NUMBER_GRADE DESC;																																									
																													

*/

/*
 select all_overs.num as cnum,all_overs.title as ctitle,count(*) as ccount 
                            from( select nc.id,nc.num,nc.title,oc.id from 																			 
                                               (select * from enrolled inner join section on enrolled.class_id=section.id where stu_id=9 and sect_type!='RE') as oc, 
                                               (select * from classes inner join section on classes.class_id=section.id 
                                                where year=2009 and qtr='S' and sect_type!='RE' and classes.num not in 
					                                                               ( select c.num from (enrolled inner join classes on classes.class_id=enrolled.class_id) as c 
																																				   where c.stu_id=9) 
																	             ) as nc 
                                   where ( (oc.day1=nc.day1 and oc.day1!='N/A') or (oc.day2=nc.day2 and oc.day2!='N/A') or (oc.day3=nc.day3 and oc.day3!='N/A')) 
                                         and 
		                                     (SELECT (oc.start_time,oc.end_time) OVERLAPS (nc.start_time,nc.end_time) )=true 
		                               group by nc.id,nc.num,nc.title 
		
		                               ) as all_overs 
                            group by all_overs.num,all_overs.title 
                            having count(*) = (select count(*) from 
														                   classes cl where cl.num=all_overs.num and 
																							                  cl.title=all_overs.title and 
																																cl.year=2009 and 
																																cl.qtr='S')

*/
/*
select nc.num,nc.title from 																			 
								(select * from enrolled inner join section on enrolled.class_id=section.id where stu_id=1 and sect_type!='RE') as oc, 
								(select * from classes inner join section on classes.class_id=section.id 
							  	where year=2009 and qtr='S' and sect_type!='RE' and classes.num not in 
																                                              ( select c.num from (enrolled inner join classes on classes.class_id=enrolled.class_id) as c 
								                                                                where c.stu_id=1) 
                 ) as nc 
where ( (oc.day1=nc.day1 and oc.day1!='N/A') or (oc.day2=nc.day2 and oc.day2!='N/A') or (oc.day3=nc.day3 and oc.day3!='N/A')) 
and 
(SELECT (oc.start_time,oc.end_time) OVERLAPS (nc.start_time,nc.end_time) )=true
group by nc.num,nc.title 
having count(*) = (select count(*) from 
													classes cl where cl.num=nc.num and 
													cl.title=nc.title and 
													cl.year=2009 and 
													cl.qtr='S')


																				 

*/



/*


<script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-60338842-1', 'auto');
  ga('send', 'pageview');

</script>



*/

/*
select a.day1,a.day2,a.day3,a.start_time,a.end_time,
       b.day1,b.day2,b.day3,b.start_time,b.end_time
from section a,section b
where a.id=b.id and ( ( a.day1!=b.day1 and a.day1!='N/A' and b.day1!='N/A') or 
                      ( a.day2!=b.day2 and a.day2!='N/A' and b.day2!='N/A') or 
											( a.day3!=b.day3 and a.day3!='N/A' and b.day3!='N/A')
										)
								and a.id=1;
*/

/*select a.day1,a.day2,a.day3,a.start_time,a.end_time
from section a
where a.id=1 and ( a.day1='TU' or a.day2='TU' or a.day3='TU' or 
                   a.day1='M' or a.day2='M' or a.day3='M' or											
                   a.day1='TH' or a.day2='TH' or a.day3='TH' 											
										)	
						 and (SELECT (a.start_time,a.end_time) OVERLAPS ( time '13:00:00' ,time '15:00:00' ) )=true	*/


/*
select * from section a
where a.id in (select c.class_id 
               from classes c 
               where (c.fac,c.year,c.qtr) = (select fac,year,qtr 
                                             from classes 
																						 where class_id=11 ) 
		                  and c.class_id!=11) 
			and ( a.day1='SUN' or a.day2='SUN' or a.day3='SUN' or 
            a.day1='TH' or a.day2='TH' or a.day3='TH' or											
            a.day1='SAT' or a.day2='SAT' or a.day3='SAT' 											
					)
			and	(SELECT (a.start_time,a.end_time) OVERLAPS ( time '12:00:00' ,time '13:00:00' ) )=true

			;		

*/	



/*
select c.n as cnum,c.f as cfac,CAT as gd,count(c.grd) as cnt 
from grade_conversion left outer join 
     (select classes.class_id as cid,num as n,fac as f,grade as grd 
      from classes join academichistory on classes.class_id=academichistory.class_id  ) as c on ((LETTER_GRADE=grd) or (n=NULL and f=NULL and grd=NULL))
group by c.n,c.f,CAT 
Having CAT='A' or 
CAT='B' or 
CAT='C' or 												    
CAT='D' or 
CAT='F' or 
CAT='S/U'

select ccnt from CPG where cnum='cse 1' and cfac='fac1' and cgd='F')



*/



