
Drop Trigger check_grad_dept on graduate;
Drop Trigger check_enrolled_insert_update on Enrolled;
Drop Trigger check_academichist_insert_update on AcademicHistory;



/* Student triggers */

/* before insert/update Graduate */

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


/* Classes Triggers */


/* before insert/update enrolled */

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

/* before insert/update academic history */

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

