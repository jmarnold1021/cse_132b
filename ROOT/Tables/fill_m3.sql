insert Into Student(ssn,
                    first_name,
										middle_name,
										last_name,
										start_date,
										end_date) values ('111111111' ,'fname1' ,''  ,'lname1'  ,DATE(NOW())  ,DATE(NOW()) ),       
																		 ('222222222' ,'fname2' ,''  ,'lname2'  ,DATE(NOW())  ,DATE(NOW()) ),
																		 ('333333333' ,'fname3' ,''  ,'lname3'  ,DATE(NOW())  ,DATE(NOW()) ),
																		 ('444444444' ,'fname4' ,''  ,'lname4'  ,DATE(NOW())  ,DATE(NOW()) ),
																		 ('555555555' ,'fname5' ,''  ,'lname5'  ,DATE(NOW())  ,DATE(NOW()) ),
																		 ('666666666' ,'fname6' ,''  ,'lname6'  ,DATE(NOW())  ,DATE(NOW()) ),
																		 ('777777777' ,'fname7' ,''  ,'lname7'  ,DATE(NOW())  ,DATE(NOW()) ),
																		 ('888888888' ,'fname8' ,''  ,'lname8'  ,DATE(NOW())  ,DATE(NOW()) ),
																		 ('999999999' ,'fname9' ,''  ,'lname9'  ,DATE(NOW())  ,DATE(NOW()) );



insert Into Course(num,
                   dept,
									 min_units,
									 max_units,
									 grade_type,
									 labwork_req) values ('cse 1'  ,'cse'   ,2  ,4  ,'O'   ,false ),       
                                       ('cse 2'  ,'cse'   ,2  ,4  ,'O'   ,false ),
                                       ('cse 3'  ,'cse'   ,2  ,4  ,'L'   ,false ),
                                       ('cse 4'  ,'cse'   ,4  ,4  ,'O'   ,false ),
                                       ('cse 5'  ,'cse'   ,2  ,4  ,'L'   ,false ),
                                       ('cse 6'  ,'cse'   ,2  ,4  ,'O'   ,true  ),																																																																																																																																				
                                       ('cse 7'  ,'cse'   ,2  ,4  ,'L'   ,true  ),
                                       ('cse 10' ,'cse'   ,2  ,4  ,'L'   ,false ),																																					
                                       ('cse 11' ,'cse'   ,2  ,4  ,'O'   ,false );


insert Into Categories(num,cat) values ('cse 1'  ,'UD' ), 
                                       ('cse 1'  ,'TE' ),
																			 
                                       ('cse 2'  ,'UD' ),
                                       ('cse 2'  ,'TE' ),
																			 
                                       ('cse 3'  ,'LD' ),
                                       ('cse 4'  ,'UD' ),
																			 
																			 ('cse 5'  ,'LD' ),
                                       ('cse 6'  ,'LD' ),
																			 ('cse 7'  ,'UD' ),
                                       ('cse 10' ,'UD' ),
                                       ('cse 11' ,'UD' );  
																			

insert Into Concentration(num,conc) values ('cse 2'  ,'Theory'        ),
                                           ('cse 3'  ,'Systems'       ),
																			     ('cse 4'  ,'Architecture'  ),
                                           ('cse 5'  ,'Theory'        ),																			 
                                           ('cse 6'  ,'Theory'        ),
                                           ('cse 7'  ,'Databases'     ),
                                           ('cse 10' ,'Databases'     ),
																					 ('cse 11' ,'Databases'     );


insert Into Faculty(name,title,dept) values ('fac1'    ,'P'    ,'cse'  ),       
																						('fac2'    ,'L'    ,'cse'  ),
																						('fac3'    ,'L'    ,'cse'  ),
																						
																						('fac4'    ,'P'    ,'ECE'  ),
																						('fac5'    ,'ASP'  ,'ECE'  ),
																						('fac6'    ,'ACP'  ,'cse'  ),
																						('fac7'    ,'L'    ,'cse'  );
																																											 
insert Into Classes(class_id,num,title,year,qtr,fac) values
                                                     (1  ,'cse 1' ,'DB APPS'      ,2009 ,'S' ,'fac1'),
                                                     (11 ,'cse 1' ,'DB APPS'      ,2009 ,'S' ,'fac2'),                                       
                                                     (2  ,'cse 2' ,'Algorithms2'  ,2009 ,'S' ,'fac3'),                                       
                                                     (22 ,'cse 2' ,'Algorithms2'  ,2009 ,'S' ,'fac4'),                                       
                                                     (3  ,'cse 3' ,'OS1'          ,2009 ,'S' ,'fac6'),                                       
                                                     (33 ,'cse 3' ,'OS1'          ,2009 ,'S' ,'fac2'),
																										 
                                                     (12 ,'cse 4' ,'Architecture' ,2009 ,'W' ,'fac3'),                                       
                                                     (4  ,'cse 5' ,'Maths'        ,2009 ,'W' ,'fac1'),
																										 
                                                     (5  ,'cse 6' ,'Algorithms1'           ,2008,'F','fac4'),                                       
                                                     (6  ,'cse 7' ,'Database applications' ,2008,'F','fac2'), 


                                                     (7  ,'cse 1' ,'DB APPS'     ,2008,'S','fac1'),                                       
                                                     (8  ,'cse 1' ,'DB APPS'     ,2008,'S','fac3'),

																										 
                                                     (9  ,'cse 10','Databases1'  ,2008,'W','fac3'),                                       
                                                     (10 ,'cse 11','Databases2'  ,2008,'W','fac2'); 

																										 
insert Into Section(id,sect_type,rev_date,mand_dis,day1,day2,day3,start_time,end_time,building,room,class_size) 
       values (11  ,'LE'   ,DATE('01-01-0001')  ,false  ,'M'  ,'F'   ,'N/A'  ,'15:50:00'  ,'17:50:00'  ,'Solis'  ,'131b' ,25),
			        (11  ,'DI'   ,DATE('01-01-0001')  ,false  ,'W'  ,'N/A'   ,'N/A'  ,'15:50:00'  ,'17:50:00'  ,'Center' ,'106'  ,25),

							(2   ,'LE'   ,DATE('01-01-0001')  ,false  ,'M'  ,'N/A'   ,'N/A'  ,'14:00:00'  ,'15:30:00'  ,'Pepper' ,'109'  ,25),
			        (2   ,'DI'   ,DATE('01-01-0001')  ,false  ,'TH' ,'N/A'   ,'N/A'  ,'13:00:00'  ,'14:30:00'  ,'COGS'   ,'227'  ,25),
							
							(22  ,'LE'   ,DATE('01-01-0001')  ,false  ,'M'  ,'N/A'   ,'N/A'  ,'14:00:00'  ,'15:30:00'  ,'Pepper' ,'109'  ,25),
			        (22  ,'DI'   ,DATE('01-01-0001')  ,false  ,'W'  ,'N/A'   ,'N/A'  ,'15:00:00'  ,'15:50:00'  ,'COGS'   ,'227'  ,25),
			        (22  ,'LA'   ,DATE('01-01-0001')  ,false  ,'F'  ,'N/A'   ,'N/A'  ,'13:00:00'  ,'13:50:00'  ,'COGS'   ,'225'  ,25),
							
									 																														 
							(3   ,'LE'   ,DATE('01-01-0001')  ,false  ,'M'  ,'N/A'   ,'N/A'  ,'14:00:00'  ,'16:00:00'  ,'Rady'   ,'114'  ,25),
			        (3   ,'DI'   ,DATE('01-01-0001')  ,false  ,'W'  ,'N/A'   ,'N/A'  ,'13:00:00'  ,'14:00:00'  ,'COGS'   ,'227'  ,25),
							

							(33  ,'LE'   ,DATE('01-01-0001')  ,false  ,'M'  ,'N/A'   ,'N/A'  ,'13:00:00'  ,'14:00:00'  ,'Rady'   ,'113'  ,25),
			        (33  ,'DI'   ,DATE('01-01-0001')  ,false  ,'W'  ,'N/A'   ,'N/A'  ,'13:00:00'  ,'14:00:00'  ,'COGS'   ,'227'  ,25),
							

						  (1   ,'LE'   ,DATE('01-01-0001')  ,false  ,'TU' ,'F'   ,'SAT'  ,'13:00:00'  ,'14:00:00'  ,'Rady'   ,'114'  ,25),
			        (1   ,'DI'   ,DATE('01-01-0001')  ,false  ,'TH' ,'N/A'   ,'N/A'  ,'13:00:00'  ,'14:00:00'  ,'COGS'   ,'227'  ,25);																										 
																			   
                                       
			        /*(3   ,'LA'   ,DATE('01-01-0001')  ,false ,'TH' ,'N/A'   ,'N/A'  ,'13:00:00'  ,'14:00:00'  ,'COGS'   ,'227'  ,25),
			        (33  ,'LA'   ,DATE('01-01-0001')  ,false ,'TH' ,'N/A'   ,'N/A'  ,'13:00:00'  ,'14:00:00'  ,'COGS'   ,'227'   ,25);*/	
							/* add to show over lap */
							
                                       
                                       



insert Into graduate(id,dept,status,candidate,advisor,fac1,fac2,fac3,o_fac) values
                                                             (6,'cse','M/S',false,'fac1','fac1','fac2','fac3','fac1'),
                                                             (7,'cse','M/S',false,'fac1','fac1','fac2','fac3','fac1'),
                                                             (8,'cse','M/S',false,'fac1','fac1','fac2','fac3','fac1'),
                                                             (9,'cse','PHD',false,'fac1','fac1','fac2','fac3','fac1');





																						
insert Into Undergraduate(id,college) values
                                            (1 ,'MARSHALL'  ),
                                            (2 ,'REVELLE'   ),
                                            (3 ,'MUIR'      ),
                                            (4 ,'WARREN'    ),
                                            (5 ,'SIXTH'     );



insert Into Enrolled(stu_id,class_id,units,grade_type) values
                                                       (1  ,1  ,2  ,'S/U'  ),
                                                       (1  ,22 ,2  ,'L'    ),

																											 (2  ,1  ,2  ,'S/U'  ),

																											 (5  ,2  ,2  ,'S/U'  ),
																											 (5  ,11 ,4  ,'S/U'  ),

																											 (7  ,22  ,4   ,'L'  ),

																											 (9  ,11  ,4   ,'S/U'   );
																											 
insert Into Academichistory(stu_id,class_id,units,grade_type,grade) values
                                                                         (1  ,12 ,4   ,'L'   ,'C'  ),
                                                                         (1  ,5  ,2   ,'L'   ,'A-' ),
																																				 (1  ,9  ,4   ,'L'   ,'B+' ),

																																				 (2  ,12  ,4  ,'L'   , 'A' ),
																																				 (2  ,10  ,2  ,'L'   ,'B-' ),

																																				 (3  ,12  ,4  ,'S/U' ,'S' ),
																																				 (3  ,4   ,2   ,'L'  ,'B' ),
																																				 (3  ,7   ,4   ,'L'  ,'A' ),

																																				 (4  ,4   ,2   ,'L'  ,'B+' ),
																																				 (4  ,5   ,2   ,'S/U','U'  ),
																																				 (4  ,8   ,2   ,'L'  ,'A'  ),
																																				 (4  ,10  ,2   ,'L'  ,'A'  ),
                                                                         
																																				 (5  ,5  ,4   ,'S/U' ,'U' ),
                  																											 (5  ,6  ,2   ,'L'   ,'A' ),
                  																											 (5  ,9  ,4   ,'L'   ,'B+'),

                  																											 (6  ,8  ,2   ,'L'   ,'A-'),

                  																											 (7  ,4  ,4   ,'L'   ,'A' ),
																																				 (7  ,6  ,4   ,'L'   ,'D' ),

																																				 (8  ,6  ,2   ,'L'   ,'A' ),
																																				 (8  ,7  ,4   ,'L'   ,'A' ),
																																				 (8  ,9  ,4   ,'L'   ,'A' ),
																																				 (8  ,10 ,2   ,'S/U' ,'S' );/* change to U */
 

 insert Into DegreeReqs(name,university,deg_type,dept,avg_uc_gpa,req_conc,total_units) values
                                                                                         ('CS BS','UCSD','B.S.','cse',2.0,'N/A',30),
                                                                                         ('CS MS','UCSD','M.S.','cse',2.0,'N/A',30);
																																												 

insert Into DegreeCategories(name,deg_type,cat_type,req_units,avg_cat_gpa) values
                                                                            ('CS BS','B.S.','UD',12,2.0),
                                                                            ('CS BS','B.S.','TE',12,2.0),
                                                                            ('CS BS','B.S.','LD',12,2.0);
																																						

insert Into DegreeConcentrations(name,deg_type,cat_type,req_units,avg_cat_gpa) values
                                                                            ( 'CS MS' ,'M.S.' ,'Theory',12 ,2.0 ),
                                                                            ( 'CS MS' ,'M.S.' ,'Databases'  ,12 ,2.0 ),
                                                                            ( 'CS MS' ,'M.S.' ,'Systems' ,12 ,2.0 ),
                                                                            ( 'CS MS' ,'M.S.' ,'Architecture' ,12 ,2.0 );

insert into GradDegrees(id,deg,d_type) values
																						(6,'CS MS','M.S.'),
																						(7,'CS MS','M.S.'),                                         
																						(8,'CS MS','M.S.'),
																						(9,'CS MS','M.S.');

insert into Majors(id,major,d_type) values
																						(1,'CS BS','B.S.'),
																						(2,'CS BS','B.S.'),                                         
																						(3,'CS BS','B.S.'),
																						(4,'CS BS','B.S.'),
																						(5,'CS BS','B.S.');
																						

                                       
                                       
                                       
                                       
                                       
                                       
                                       
                                       
                                       
                                       
                                       
                                       
                                       
                                       
																			 
																		   
                                                                    
                                       
                                       
                                       
																			 
																		   
                                                                    
                                       
                                       
