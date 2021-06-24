



insert Into Student(ssn,first_name,middle_name,last_name,start_date,end_date) values ('123477789' ,'Jared'   ,''        ,'Arnold'    ,DATE(NOW()) ,DATE(NOW())),       
                                                                                     ('128856788' ,'Jay'     ,'Middle'  ,'Smith'     ,DATE(NOW()) ,DATE(NOW())),
                                                                                     ('129956787' ,'John'    ,''        ,'Crow'      ,DATE(NOW()) ,DATE(NOW())),
                                                                                     ('123656786' ,'Mike'    ,'West'    ,'White'     ,DATE(NOW()) ,DATE(NOW())),
                                                                                     ('123456785' ,'Charles' ,''        ,'Xavier'    ,DATE(NOW()) ,DATE(NOW())),
                                                                                     ('124656784' ,'Henry'   ,'John'    ,'George'    ,DATE(NOW()) ,DATE(NOW())),
                                                                                     ('123456783' ,'Bill'    ,''        ,'Cosby'     ,DATE(NOW()) ,DATE(NOW())),
                                                                                     ('123456782' ,'Joe'     ,'Jack'    ,'Johnson'   ,DATE(NOW()) ,DATE(NOW())),
                                                                                     ('123126781' ,'Beth'    ,'English' ,'Middletown',DATE(NOW()) ,DATE(NOW())),
                                                                                     ('123456780' ,'Jim'     ,''        ,'Rivers'    ,DATE(NOW()) ,DATE(NOW())),
                                                                                     ('123443789' ,'Caswell' ,''        ,'Berry'     ,DATE(NOW()) ,DATE(NOW()));


insert Into Undergraduate(id,college) values(1,'MARSHALL');
insert Into Majors(id,major) values(1,'CS BS');







insert Into Course(num,dept,min_units,max_units,grade_type,labwork_req) values ('cse 132a'  ,'cse'   ,4  ,4 ,'L'   ,false ),       
                                                                               ('cse 132b'  ,'cse'   ,4  ,4 ,'L'   ,false ),
                                                                               ('cse 134b'  ,'cse'   ,4  ,4 ,'L'   ,false ),
                                                                               ('cse 140'   ,'cse'   ,4  ,4 ,'L'   ,false ),
                                                                               ('cse 141'   ,'cse'   ,4  ,4 ,'L'   ,false ),
                                                                               ('cse 140L'  ,'cse'   ,2  ,2 ,'L'   ,true  ),																																																																																																																																				
                                                                               ('cse 110'   ,'cse'   ,4  ,4 ,'L'   ,true  ),
                                                                               ('cse 105'   ,'cse'   ,4  ,4 ,'L'   ,false ),																																					
                                                                               ('cse 100'   ,'cse'   ,4  ,4 ,'L'   ,false ),
                                                                               ('cse 101'   ,'cse'   ,4  ,4 ,'L'   ,false ),
																																					     ('cse 120'   ,'cse'   ,4  ,4 ,'L'   ,false ),                                                                         
																																					     ('cse 130'   ,'cse'   ,4  ,4 ,'L'   ,false ),
                                                                               ('cse 131'   ,'cse'   ,4  ,4 ,'L'   ,false ),
                                                                               ('cse 123'   ,'cse'   ,4  ,4 ,'L'   ,false ),                                                                         
																																					     ('cse 30'    ,'cse'   ,4  ,4 ,'L'   ,false ),
																																					     ('cse 12'    ,'cse'   ,4  ,4 ,'L'   ,false ),
																																					     ('cse 20'    ,'cse'   ,4  ,4 ,'L'   ,false ),
																																					     ('cse 21'    ,'cse'   ,4  ,4 ,'L'   ,false ),
																																					     ('cse 8'     ,'cse'   ,4  ,4 ,'L'   ,false ),
																																					     ('cse 15L'   ,'cse'   ,2  ,2 ,'L'   ,true  ),
																																					     ('math 12'   ,'math'  ,4  ,4 ,'O'   ,false ),
                                                                               ('math 13'   ,'math'  ,4  ,4 ,'O'   ,false ),
																																					     ('poli 132k' ,'poli'  ,4  ,4 ,'S/U' ,false ),
                                                                               ('poli 136'  ,'poli'  ,4  ,4 ,'S/U' ,false ),
                                                                               ('poli 109'  ,'poli'  ,4  ,4 ,'S/U' ,true  ),
                                                                               ('poli 167'  ,'poli'  ,4  ,4 ,'S/U' ,false );
																																					
																																					
																																					
																																					
																																					



insert Into Categories(num,cat) values ('cse 140'  ,'C'  ), 
                                       ('cse 140'  ,'UD' ),
                                       ('cse 141'  ,'C'  ),
                                       ('cse 141'  ,'UD' ),
																			 ('cse 105'  ,'C'  ),
                                       ('cse 105'  ,'UD' ),
																			 ('cse 140L' ,'UD' ),
                                       ('cse 140L' ,'C'  ),
                                       ('cse 132a' ,'UD' ),  
                                       ('cse 132a' ,'TE' ),
																			 ('cse 134b' ,'UD' ),  
                                       ('cse 134b' ,'TE' ),
                                       ('cse 132b' ,'TE' ),
                                       ('cse 132b' ,'UD' ),
                                       ('cse 110'  ,'C'  ),
                                       ('cse 110'  ,'UD' ),
                                       ('cse 100'  ,'C'  ),
                                       ('cse 100'  ,'UD' ),
                                       ('cse 101'  ,'UD' ),
                                       ('cse 101'  ,'C'  ),
                                       ('cse 120'  ,'UD' ),
                                       ('cse 120'  ,'C'  ),
                                       ('cse 130'  ,'UD' ),
                                       ('cse 130'  ,'C'  ),
                                       ('cse 131'  ,'C'  ),
                                       ('cse 131'  ,'UD' ),
                                       ('cse 123'  ,'TE' ),
                                       ('cse 123'  ,'UD' ),
                                       ('cse 30'   ,'C'  ),
																			 ('cse 12'   ,'C'  ),
																		   ('cse 20'   ,'C'  ),
                                       ('cse 21'   ,'C'  ),                             
                                       ('cse 8'    ,'C'  ),
                                       ('cse 15L'  ,'C'  ),
                                       ('cse 30'   ,'LD' ),
																			 ('cse 12'   ,'LD' ),
																		   ('cse 20'   ,'LD' ),
                                       ('cse 21'   ,'LD' ),                             
                                       ('cse 8'    ,'LD' ),
                                       ('cse 15L'  ,'LD' );


insert Into Concentration(num,conc) values ('cse 140'   ,'digital'     ), 
                                           ('cse 141'   ,'digital'     ),
                                           ('cse 140L'  ,'digital'     ),
																			     ('cse 132a'  ,'databases'   ),
                                           ('cse 132b'  ,'databases'   ),																			 
                                           ('cse 134b'  ,'databases'   ),
                                           ('poli 132k' ,'databases'   ),
                                           ('poli 136'  ,'mix'         ),
																					 ('poli 109'  ,'mix'         ),
																					 ('math 12'   ,'mix'         ),
																					 ('math 13'   ,'mix'         );
																					 
																					 


insert Into Faculty(name,title,dept) values ('Rick Ord'       ,'P'    ,'cse'  ),       
																						('Gary G'         ,'L'    ,'cse'  ),
																						('Diba'           ,'L'    ,'cse'  ),
																						
																						('J. Pasquale'    ,'P'    ,'cse'  ),
																						('Victor Vianu'   ,'ASP'  ,'cse'  ),
																						('Snoop DODubG'   ,'ACP'  ,'poli' ),
																						('Alan Deutch'    ,'L'    ,'cse'  ),
																						('Susan Marx'     ,'P'    ,'cse'  ),
																						('Ice Tea'        ,'P'    ,'poli' ),
																						('Taylor Fah'     ,'L'    ,'math' ),
																						('Snape'          ,'ASP'  ,'math' ),
																					  ('Jeff Sturges'   ,'P'    ,'poli' ),
																						('jennifer jones' ,'L'    ,'math' ),
																						('Mary Xmas'      ,'ASP'  ,'math' ),
									                          ('Sean Malto'     ,'P'    ,'poli' );







insert Into graduate(id,dept,status,candidate,advisor,fac1,fac2,fac3,o_fac) values
                                                             (1,'cse','M/S',false,'Rick Ord','Rick Ord','Susan Marx','Gary G','Rick Ord');



/*18*/
																																 
insert Into Classes(num,title,year,qtr,fac) values 

																									 ('cse 140'   ,'DIG CIR I'        ,2009   ,'S'   ,'Diba'           ),
																									 ('cse 141'   ,'DIG CIR II'       ,2009   ,'S'   ,'Diba'           ),																									 
																									 ('cse 105'   ,'Comp Theory'      ,2009   ,'S'   ,'Rick Ord'       ),
																									 ('cse 140L'  ,'CIR LAB'          ,2009   ,'S'   ,'Gary G'         ),                                                   
																									 ('cse 132a'  ,'databases I'      ,2009   ,'S'   ,'Victor Vianu'   ),
																									 ('cse 132b'  ,'databases II'     ,2009   ,'S'   ,'Diba'           ),
																									 ('cse 134b'  ,'databases III'    ,2009   ,'S'   ,'Diba'           ),																									 
																									 ('cse 110'   ,'Software Eng.'    ,2009   ,'S'   ,'Gary G'         ),
																									 ('cse 100'   ,'Data Structures'  ,2009   ,'S'   ,'Susan Marx'     ),
																									 ('cse 101'   ,'Algotithms'       ,2009   ,'S'   ,'Susan Marx'     ),
																									 ('cse 100'   ,'Data Structures'  ,2009   ,'S'   ,'Gary G'         ),
																									 ('cse 120'   ,'Operating System' ,2009   ,'S'   ,'J. Pasquale'    ),																									
																									 ('cse 130'   ,'Languages'        ,2009   ,'S'   ,'Rick Ord'       ),
																									 ('cse 131'   ,'Compilers'        ,2009   ,'S'   ,'Rick Ord'       ),
																									 ('cse 123'   ,'Networks'         ,2009   ,'S'   ,'Diba'           ),																									
																									 ('cse 30'    ,'Systems'          ,2009   ,'S'   ,'Rick Ord'       ),
																									 ('cse 30'    ,'Systems'          ,2009   ,'S'   ,'Susan Marx'     ),																									 	
                                                   ('cse 12'   ,'Basic Data Structs',2009   ,'S'   ,'Diba'           ),
                                                   ('cse 20'   ,'Seqences'          ,2009   ,'S'   ,'Susan Marx'     ),
                                                   ('cse 21'   ,'Counting'          ,2009   ,'S'   ,'Rick Ord'       ),
                                                   ('cse 8'    ,'Basic Java'        ,2009   ,'S'   ,'Rick Ord'       ),
                                                   ('cse 15L'  ,'Software Tools Lab',2009   ,'S'   ,'Diba'           ),


                                                   ('cse 140'   ,'DIG CIR I'        ,2008   ,'W'   ,'Diba'           ),
																									 ('cse 141'   ,'DIG CIR II'       ,2008   ,'W'   ,'Diba'           ),																									 
																									 ('cse 105'   ,'Comp Theory'      ,2008   ,'W'   ,'Rick Ord'       ),
																									 ('cse 140L'  ,'CIR LAB'          ,2008   ,'W'   ,'Gary G'         ),
																									 ('cse 132a'  ,'databases I'      ,2008   ,'W'   ,'Victor Vianu'   ),       
																									 ('cse 132b'  ,'databases II'     ,2008   ,'W'   ,'Alan Deutch'    ),
																									 ('cse 134b'  ,'databases III'    ,2008   ,'W'   ,'Alan Deutch'    ),																									 
																									 ('cse 110'   ,'Software Eng.'    ,2008   ,'W'   ,'Gary G'         ),
																									 ('cse 100'   ,'Data Structures'  ,2008   ,'W'   ,'Susan Marx'     ),
																								   ('cse 100'   ,'Data Structures'  ,2008   ,'W'   ,'Gary G'         ),
																							   	 ('cse 101'   ,'Algorithms'       ,2008   ,'W'   ,'Gary G'         ),
																						  		 ('cse 120'   ,'Operating System' ,2008   ,'W'   ,'J. Pasquale'    ),																					  			
																		  						 ('cse 130'   ,'Languages'        ,2008   ,'W'   ,'Diba'           ),
																	  							 ('cse 131'   ,'Compilers'        ,2008   ,'W'   ,'Rick Ord'       ),
																  								 ('cse 123'   ,'Networks'         ,2008   ,'W'   ,'Gary G'         ),															  									
																					  			 ('cse 30'    ,'Systems'          ,2008   ,'W'   ,'Rick Ord'       ),
																				  				 ('cse 30'    ,'Systems'          ,2008   ,'W'   ,'Diba'           ),
																									 ('cse 12'   ,'Basic Data Structs',2008   ,'W'   ,'Gary G'         ),
                                                   ('cse 20'   ,'Seqences'          ,2008   ,'W'   ,'Rick Ord'       ),
                                                   ('cse 21'   ,'Counting'          ,2008   ,'W'   ,'Diba'           ),
                                                   ('cse 8'    ,'Basic Java'        ,2008   ,'W'   ,'Gary G'         ),
                                                   ('cse 15L'  ,'Software Tools Lab',2008   ,'W'   ,'Diba'           ),
																										 
																									
                                                   ('cse 140'   ,'DIG CIR I'        ,2008   ,'F'   ,'Diba'           ),
																									 ('cse 141'   ,'DIG CIR II'       ,2008   ,'F'   ,'Diba'           ),																									 
																									 ('cse 105'   ,'Comp Theory'      ,2008   ,'F'   ,'Rick Ord'       ),
																									 ('cse 140L'  ,'CIR LAB'          ,2008   ,'F'   ,'Gary G'         ),																									
																									 ('cse 132a'  ,'databases I'      ,2008   ,'F'   ,'Victor Vianu'   ),       
																									 ('cse 132b'  ,'databases II'     ,2008   ,'F'   ,'Alan Deutch'    ),
																									 ('cse 134b'  ,'databases III'    ,2008   ,'F'   ,'Alan Deutch'    ),
																									 ('cse 110'   ,'Software Eng.'    ,2008   ,'F'   ,'J. Pasquale'    ),
																	 								 ('cse 100'   ,'Data Structures'  ,2008   ,'F'   ,'Susan Marx'     ),
																									 ('cse 100'   ,'Data Structures'  ,2008   ,'F'   ,'Gary G'         ),
															 										 ('cse 101'   ,'Algorithms'       ,2008   ,'F'   ,'Susan Marx'     ),
																									 ('cse 120'   ,'Operating System' ,2008   ,'F'   ,'J. Pasquale'    ),
																									 ('cse 130'   ,'Languages'        ,2008   ,'F'   ,'Gary G'         ),
																									 ('cse 131'   ,'Compilers'        ,2008   ,'F'   ,'Rick Ord'       ),
																									 ('cse 123'   ,'Networks'         ,2008   ,'F'   ,'Gary G'         ),
																									 ('cse 30'    ,'Systems'          ,2008   ,'F'   ,'Rick Ord'       ),
																									 ('cse 30'    ,'Systems'          ,2008   ,'F'   ,'Susan Marx'     ),
                                                   ('cse 12'   ,'Basic Data Structs',2008   ,'F'   ,'Rick Ord'       ),
                                                   ('cse 20'   ,'Seqences'          ,2008   ,'F'   ,'Rick Ord'       ),
                                                   ('cse 21'   ,'Counting'          ,2008   ,'F'   ,'Gary G'         ),
                                                   ('cse 8'    ,'Basic Java'        ,2008   ,'F'   ,'Gary G'         ),
                                                   ('cse 15L'  ,'Software Tools Lab',2008   ,'F'   ,'Susan Marx'     ),



																									 ('math 12'   ,'Algebra I'        ,2009   ,'W'   ,'jennifer jones' ),
																								   ('math 13'   ,'Algebra II'       ,2009   ,'W'   ,'Mary Xmas'      ),
																									 ('math 12'   ,'Algebra I'        ,2008   ,'W'   ,'jennifer jones' ),
														  										 ('math 13'   ,'Algebra II'       ,2008   ,'W'   ,'Mary Xmas'      ),
																									 ('math 12'   ,'Algebra I'        ,2008   ,'F'   ,'Snape'          ),
																									 ('math 13'   ,'Algebra II'       ,2008   ,'F'   ,'Taylor Fah'     ),


																									 ('poli 132k' ,'War'              ,2009   ,'S'   ,'Snoop DODubG'   ),
																									 ('poli 136'  ,'Religion'         ,2009   ,'S'   ,'Jeff Sturges'   ),
																									 ('poli 109'  ,'Poli fun'         ,2009   ,'S'   ,'Ice Tea'        ),
																								   ('poli 167'  ,'Poli fun II'      ,2009   ,'S'   ,'Sean Malto'     ),
																									 ('poli 132k' ,'War'              ,2008   ,'W'   ,'Snoop DODubG'   ),
																				  				 ('poli 136'  ,'Religion'         ,2008   ,'W'   ,'Jeff Sturges'   ),
																			  					 ('poli 109'  ,'Poli fun'         ,2008   ,'W'   ,'Ice Tea'        ),
													  											 ('poli 167'  ,'Poli fun II'      ,2008   ,'W'   ,'Sean Malto'     ),
																									 ('poli 132k' ,'War'              ,2008   ,'F'   ,'Snoop DODubG'   ),
																									 ('poli 136'  ,'Religion'         ,2008   ,'F'   ,'Jeff Sturges'   ),
																									 ('poli 109'  ,'Poli fun'         ,2008   ,'F'   ,'Ice Tea'        ),
																									 ('poli 167'  ,'Poli fun II'      ,2008   ,'F'   ,'Jeff Sturges'   ),
                                                   ('cse 140'   ,'DIG CIR I'        ,2008   ,'W'   ,'Diba'           ),
                                                   ('cse 140'   ,'DIG CIR I'        ,2008   ,'W'   ,'Rick Ord'       );
																									 
																									 
																									 
																																									 


                                                                                 
																																								 
insert Into Section(id,sect_type,rev_date,mand_dis,day1,day2,day3,start_time,end_time,building,room,class_size) 
       values (1  ,'LE'   ,DATE('01-01-0001')  ,false  ,'M'   ,'W'     ,'N/A'  ,'10:00:00'  ,'10:50:00'  ,'Solis'   ,'131b' ,25),
			        (1  ,'DI'   ,DATE('01-01-0001')  ,false  ,'TU'  ,'N/A'   ,'N/A'  ,'12:00:00'  ,'12:50:00'  ,'Center'  ,'109'  ,25),

							(2  ,'LE'   ,DATE('01-01-0001')  ,false  ,'M'   ,'W'     ,'N/A'  ,'09:00:00'  ,'09:50:00'  ,'Pepper'  ,'109'  ,25),
			        (2  ,'DI'   ,DATE('01-01-0001')  ,false  ,'TU'  ,'N/A'   ,'N/A'  ,'11:00:00'  ,'11:50:00'  ,'COGS'    ,'227'  ,25),
							
							(3  ,'LE'   ,DATE('01-01-0001')  ,false  ,'TU'   ,'TH'   ,'N/A'  ,'11:00:00'  ,'11:50:00'  ,'Pepper'  ,'109'  ,25),
			        (3  ,'DI'   ,DATE('01-01-0001')  ,false  ,'M'   ,'N/A'   ,'N/A'  ,'15:00:00'  ,'15:50:00'  ,'COGS'    ,'227'  ,25),
			        (3  ,'LA'   ,DATE('01-01-0001')  ,false  ,'W'   ,'N/A'   ,'N/A'  ,'12:00:00'  ,'12:50:00'  ,'COGS'    ,'225'  ,25),
			        (3  ,'RE'   ,DATE('03-30-2009')  ,false  ,'M'   ,'N/A'   ,'N/A'  ,'11:00:00'  ,'11:50:00'  ,'COGS'    ,'225'  ,25),
							
									 																														 
							(4  ,'LE'   ,DATE('01-01-0001')  ,false  ,'TU'  ,'TH'    ,'N/A'  ,'09:00:00'  ,'10:20:00'  ,'Rady'    ,'114'  ,25),
			        (4  ,'DI'   ,DATE('01-01-0001')  ,true   ,'TH'  ,'N/A'   ,'N/A'  ,'13:00:00'  ,'13:50:00'  ,'COGS'    ,'227'  ,25),

							(5  ,'LE'   ,DATE('01-01-0001')  ,false  ,'TU'  ,'TH'    ,'N/A'  ,'09:00:00'  ,'10:20:00'  ,'Rady'    ,'114'  ,25),
			        (5  ,'DI'   ,DATE('01-01-0001')  ,true   ,'TH'  ,'N/A'   ,'N/A'  ,'13:00:00'  ,'13:50:00'  ,'COGS'    ,'227'  ,25),

						  (6  ,'LE'   ,DATE('01-01-0001')  ,false  ,'TU'  ,'TH'    ,'N/A'  ,'09:00:00'  ,'10:20:00'  ,'Rady'    ,'114'  ,25),
			        (6  ,'DI'   ,DATE('01-01-0001')  ,false  ,'TH'  ,'N/A'   ,'N/A'  ,'13:00:00'  ,'13:50:00'  ,'COGS'    ,'227'  ,25),

							(7  ,'LE'   ,DATE('01-01-0001')  ,false  ,'TU'  ,'TH'    ,'N/A'  ,'09:00:00'  ,'10:20:00'  ,'Rady'    ,'114'  ,25),
			        (7  ,'DI'   ,DATE('01-01-0001')  ,false  ,'TH'  ,'N/A'   ,'N/A'  ,'13:00:00'  ,'13:50:00'  ,'COGS'    ,'227'  ,25),

							(8  ,'LE'   ,DATE('01-01-0001')  ,false  ,'TU'  ,'TH'    ,'N/A'  ,'09:00:00'  ,'10:20:00'  ,'Rady'    ,'114'  ,25),
			        (8  ,'DI'   ,DATE('01-01-0001')  ,false  ,'TH'  ,'N/A'   ,'N/A'  ,'13:00:00'  ,'13:50:00'  ,'COGS'    ,'227'  ,25),

							(9  ,'LE'   ,DATE('01-01-0001')  ,false  ,'Tu'  ,'TH'    ,'N/A'  ,'09:00:00'  ,'10:20:00'  ,'Rady'    ,'114'  ,25),
			        (9  ,'DI'   ,DATE('01-01-0001')  ,true   ,'TH'  ,'N/A'   ,'N/A'  ,'13:00:00'  ,'13:50:00'  ,'COGS'    ,'227'  ,25),

							(10 ,'LE'   ,DATE('01-01-0001')  ,false  ,'TU'  ,'TH'    ,'N/A'  ,'09:00:00'  ,'10:20:00'  ,'Rady'    ,'114'  ,25),
			        (10 ,'DI'   ,DATE('01-01-0001')  ,false  ,'TH'  ,'N/A'   ,'N/A'  ,'13:00:00'  ,'13:50:00'  ,'COGS'    ,'227'  ,25),

							(11 ,'LE'   ,DATE('01-01-0001')  ,false  ,'TU'  ,'TH'    ,'N/A'  ,'09:00:00'  ,'10:20:00'  ,'Rady'    ,'114'  ,25),
			        (11 ,'DI'   ,DATE('01-01-0001')  ,false  ,'TH'  ,'N/A'   ,'N/A'  ,'13:00:00'  ,'13:50:00'  ,'COGS'    ,'227'  ,25),

							(12 ,'LE'   ,DATE('01-01-0001')  ,false  ,'TU'  ,'TH'    ,'N/A'  ,'10:00:00'  ,'10:50:00'  ,'Rady'    ,'114'  ,25),
			        (12 ,'DI'   ,DATE('01-01-0001')  ,false  ,'TH'  ,'N/A'   ,'N/A'  ,'14:00:00'  ,'14:50:00'  ,'COGS'    ,'227'  ,25),

							(13 ,'LE'   ,DATE('01-01-0001')  ,false  ,'M'   ,'W'     ,'N/A'  ,'09:00:00'  ,'10:20:00'  ,'Rady'    ,'114'  ,25),
			        (13 ,'DI'   ,DATE('01-01-0001')  ,false  ,'TH'  ,'N/A'   ,'N/A'  ,'13:00:00'  ,'13:50:00'  ,'COGS'    ,'227'  ,25),

							(14 ,'LE'   ,DATE('01-01-0001')  ,false  ,'TU'  ,'TH'    ,'N/A'  ,'09:00:00'  ,'10:20:00'  ,'Rady'    ,'114'  ,25),
			        (14 ,'DI'   ,DATE('01-01-0001')  ,false  ,'TH'  ,'N/A'   ,'N/A'  ,'11:00:00'  ,'11:50:00'  ,'COGS'    ,'227'  ,25),

							(15 ,'LE'   ,DATE('01-01-0001')  ,false  ,'TU'  ,'TH'    ,'N/A'  ,'09:00:00'  ,'10:20:00'  ,'Rady'    ,'114'  ,25),
			        (15 ,'DI'   ,DATE('01-01-0001')  ,false  ,'TH'  ,'N/A'   ,'N/A'  ,'13:00:00'  ,'13:50:00'  ,'COGS'    ,'227'  ,25),

							(16 ,'LE'   ,DATE('01-01-0001')  ,false  ,'TU'  ,'TH'    ,'N/A'  ,'09:00:00'  ,'10:20:00'  ,'Rady'    ,'114'  ,25),
			        (16 ,'DI'   ,DATE('01-01-0001')  ,false  ,'TH'  ,'N/A'   ,'N/A'  ,'19:00:00'  ,'19:50:00'  ,'COGS'    ,'227'  ,25),

							(17 ,'LE'   ,DATE('01-01-0001')  ,false  ,'M'   ,'W'     ,'F'    ,'13:00:00'  ,'13:50:00'  ,'Center'  ,'226'  ,25),
			        (17 ,'DI'   ,DATE('01-01-0001')  ,false  ,'TU'  ,'N/A'   ,'N/A'  ,'13:00:00'  ,'13:50:00'  ,'Pepper'  ,'106'  ,25),

							(18 ,'LE'   ,DATE('01-01-0001')  ,false  ,'TU'  ,'TH'    ,'N/A'  ,'09:00:00'  ,'10:20:00'  ,'Rady'    ,'114'  ,25),
			        (18 ,'DI'   ,DATE('01-01-0001')  ,false  ,'TH'  ,'N/A'   ,'N/A'  ,'13:00:00'  ,'13:50:00'  ,'COGS'    ,'227'  ,25),

							(19 ,'LE'   ,DATE('01-01-0001')  ,false  ,'TU'  ,'TH'    ,'N/A'  ,'09:00:00'  ,'10:20:00'  ,'Rady'    ,'114'  ,25),
			        (19 ,'DI'   ,DATE('01-01-0001')  ,false  ,'TH'  ,'N/A'   ,'N/A'  ,'13:00:00'  ,'13:50:00'  ,'COGS'    ,'227'  ,25),

							(20 ,'LE'   ,DATE('01-01-0001')  ,false  ,'TU'  ,'TH'    ,'N/A'  ,'09:00:00'  ,'10:20:00'  ,'Rady'    ,'114'  ,25),
			        (20 ,'DI'   ,DATE('01-01-0001')  ,false  ,'TH'  ,'N/A'   ,'N/A'  ,'13:00:00'  ,'13:50:00'  ,'COGS'    ,'227'  ,25),

							(21 ,'LE'   ,DATE('01-01-0001')  ,false  ,'TU'  ,'TH'    ,'N/A'  ,'09:00:00'  ,'10:20:00'  ,'Rady'    ,'114'  ,25),
			        (21 ,'DI'   ,DATE('01-01-0001')  ,false  ,'TH'  ,'N/A'   ,'N/A'  ,'13:00:00'  ,'13:50:00'  ,'COGS'    ,'227'  ,25),

							(22 ,'LE'   ,DATE('01-01-0001')  ,false  ,'TU'  ,'TH'    ,'N/A'  ,'09:00:00'  ,'10:20:00'  ,'Rady'    ,'114'  ,25),
			        (22 ,'DI'   ,DATE('01-01-0001')  ,false  ,'TH'  ,'N/A'   ,'N/A'  ,'13:00:00'  ,'13:50:00'  ,'COGS'    ,'227'  ,25),

							(23 ,'LE'   ,DATE('01-01-0001')  ,false  ,'TU'  ,'TH'    ,'N/A'  ,'09:00:00'  ,'10:20:00'  ,'Rady'    ,'114'  ,25),
			        (23 ,'DI'   ,DATE('01-01-0001')  ,false  ,'TH'  ,'N/A'   ,'N/A'  ,'13:00:00'  ,'13:50:00'  ,'COGS'    ,'227'  ,25),

							(24 ,'LE'   ,DATE('01-01-0001')  ,false  ,'TU'  ,'TH'    ,'N/A'  ,'09:00:00'  ,'10:20:00'  ,'Rady'    ,'114'  ,25),
			        (24 ,'DI'   ,DATE('01-01-0001')  ,false  ,'TH'  ,'N/A'   ,'N/A'  ,'13:00:00'  ,'13:50:00'  ,'COGS'    ,'227'  ,25),

							(25 ,'LE'   ,DATE('01-01-0001')  ,false  ,'TU'  ,'TH'    ,'N/A'  ,'09:00:00'  ,'10:20:00'  ,'Rady'    ,'114'  ,25),
			        (25 ,'DI'   ,DATE('01-01-0001')  ,false  ,'TH'  ,'N/A'   ,'N/A'  ,'13:00:00'  ,'13:50:00'  ,'COGS'    ,'227'  ,25),

							(26 ,'LE'   ,DATE('01-01-0001')  ,false  ,'TU'  ,'TH'    ,'N/A'  ,'09:00:00'  ,'10:20:00'  ,'Rady'    ,'114'  ,25),
			        (26 ,'DI'   ,DATE('01-01-0001')  ,false  ,'TH'  ,'N/A'   ,'N/A'  ,'13:00:00'  ,'13:50:00'  ,'COGS'    ,'227'  ,25);

																																								 





insert Into DegreeReqs(name,university,deg_type,dept,avg_uc_gpa,req_conc,total_units) values
                                                                                         ('CS BS','UCSD','B.S.','cse',2.0,'N/A',70),
                                                                                         ('CS MS','UCSD','M.S.','cse',2.0,'N/A',70);
																																												 

insert Into DegreeCategories(name,deg_type,cat_type,req_units,avg_cat_gpa) values
                                                                            ('CS BS','B.S.','UD',30,2.0),
                                                                            ('CS BS','B.S.','TE',12,2.0);

insert Into DegreeConcentrations(name,deg_type,cat_type,req_units,avg_cat_gpa) values
                                                                            ( 'CS MS' ,'M.S.' ,'databases',10 ,2.0 ),
                                                                            ( 'CS MS' ,'M.S.' ,'digital'  ,10 ,2.0 ),
                                                                            ( 'CS MS' ,'M.S.' ,'mix' ,10 ,2.0 );
																																						


insert Into Enrolled(stu_id,class_id,units,grade_type) values(1  ,3  ,4   ,'L'    ),
                                                             (1  ,12  ,4   ,'L'   ),
                                                             (1  ,13  ,4   ,'L'   ),
																														 (2  ,3  ,4   ,'L'    ),
                                                             (2  ,16  ,4   ,'L'   ),
                                                             (2  ,13  ,4   ,'L'   ),
																														 (3  ,16 ,4   ,'L'    ),
                                                             (3  ,17  ,4   ,'L'   ),
                                                             (3  ,18  ,4   ,'L'   );
																														 /*
																														  (2  ,1  ,4   ,'L'   ),
                                                             (2  ,5  ,4   ,'L'   ),
                                                             (2  ,12 ,4  ,'L'    ),

																														 (3  ,13 ,4   ,'L'  ),
                                                             (3  ,17 ,4   ,'L'  ),
                                                             (3  ,7  ,4   ,'L'  ),

																													
                                                             (11 ,9  ,4   ,'S/U'   ),
                                                             (11 ,15 ,4   ,'S/U' ),

																														 (10 ,14  ,4  ,'L'  ),
                                                             (10 ,15  ,4  ,'L'  );
*/
insert Into Academichistory(stu_id,class_id,units,grade_type,grade) values
                                                                          (1  ,66  ,2   ,'L'  ,'C'  ),
																																					(1  ,65  ,4   ,'L'  ,'B'  ),
																																					(1  ,64  ,4   ,'L'  ,'A'  ),
																																					(1  ,63  ,4   ,'L'  ,'C'  ),
																																					(1  ,62  ,4   ,'L'  ,'B'  ),
                                                                                  
																																					(1  ,38  ,4   ,'L'  ,'B'  ),
																																					(1  ,37  ,4   ,'L'  ,'C'  ),
																																					(1  ,36  ,4   ,'L'  ,'B'  ),
																																					(1  ,35  ,4   ,'L'  ,'B'  ),
																																					(1  ,34  ,4   ,'L'  ,'C'  ),
																																					(1  ,33  ,4   ,'L'  ,'A'  ),
																																					(1  ,32  ,4   ,'L'  ,'B'  ),
																																					(1  ,30  ,4   ,'L'  ,'C'  ),
																																					(1  ,27  ,4   ,'L'  ,'A'  ),
																																					(1  ,28  ,4   ,'L'  ,'A'  ),
																																					(1  ,48  ,2   ,'L'  ,'C'  ),
																																					(1  ,45  ,4   ,'L'  ,'A'  ),
																																					(1  ,46  ,4   ,'L'  ,'A'  ),
																																					(1  ,29  ,4   ,'L'  ,'B'  ),
																																					(1  ,79  ,4   ,'S/U','S'  ),
																																					(1  ,69  ,4   ,'L'  ,'B'  ),


																																					(2  ,66  ,2   ,'L'  ,'A'  ),
																																					(2  ,65  ,4   ,'L'  ,'C'  ),
																																					(2  ,64  ,4   ,'L'  ,'B'  ),
																																					(2  ,63  ,4   ,'L'  ,'C'  ),
																																					(2  ,62  ,4   ,'L'  ,'A'  ),
                                                                                  
																																					(2  ,38  ,4   ,'L'  ,'C'  ),
																																					(2  ,37  ,4   ,'L'  ,'C'  ),
																																					(2  ,36  ,4   ,'L'  ,'B'  ),
																																					(2  ,35  ,4   ,'L'  ,'A'  ),
																																					(2  ,34  ,4   ,'L'  ,'C'  ),
																																					(2  ,33  ,4   ,'L'  ,'A'  ),
																																					(2  ,32  ,4   ,'L'  ,'B'  ),
																																					(2  ,30  ,4   ,'L'  ,'C+'  ),
																																					(2  ,27  ,4   ,'L'  ,'A'  ),
																																					(2  ,28  ,4   ,'L'  ,'A-'  ),
																																					(2  ,48  ,2   ,'L'  ,'C'  ),
																																					(2  ,45  ,4   ,'L'  ,'A+'  ),
																																					(2  ,46  ,4   ,'L'  ,'A'  ),
																																					(2  ,29  ,4   ,'L'  ,'B'  ),
																																					(2  ,79  ,4   ,'S/U','S'  ),
																																					(2  ,69  ,4   ,'L'  ,'B'  ),



																																					(3  ,66  ,2   ,'L'  ,'B'  ),
																																					(3  ,65  ,4   ,'L'  ,'C'  ),
																																					(3  ,64  ,4   ,'L'  ,'B-'  ),
																																					(3  ,63  ,4   ,'L'  ,'C'  ),
																																					(3  ,62  ,4   ,'L'  ,'A'  ),
                                                                                 
																																					(3  ,38  ,4   ,'L'  ,'C+'  ),
																																					(3  ,37  ,4   ,'L'  ,'C'  ),
																																					(3  ,36  ,4   ,'L'  ,'B'  ),
																																					(3  ,35  ,4   ,'L'  ,'A'  ),
																																					(3  ,34  ,4   ,'L'  ,'C'  ),
																																					(3  ,33  ,4   ,'L'  ,'A-'  ),
																																					(3  ,32  ,4   ,'L'  ,'B'  ),
																																					(3  ,30  ,4   ,'L'  ,'C'  ),
																																					(3  ,27  ,4   ,'L'  ,'A'  ),
																																					(3  ,28  ,4   ,'L'  ,'A'  ),
																																					(3  ,48  ,2   ,'L'  ,'C+'  ),
																																					(3  ,45  ,4   ,'L'  ,'A+'  ),
																																					(3  ,46  ,4   ,'L'  ,'A'  ),
																																					(3  ,29  ,4   ,'L'  ,'B-'  ),
																																					(3  ,79  ,4   ,'S/U','S'  ),
																																					(3  ,69  ,4   ,'L'  ,'B'  ),




																																					(4  ,23  ,4   ,'L'  ,'B-'  ),
																																					(5  ,23  ,4   ,'L'  ,'B-'  ),
																																					(6  ,85  ,4   ,'L'  ,'B-'  ),
																																					(7  ,45  ,4   ,'L'  ,'B-'  ),
																																					(8  ,86  ,4   ,'L'  ,'D'  )
																																					
																																					
																																					
																																					;
																																					
																																					
																																					
																																					

                                                                         																																					
																														 

																														 








/*create table temp_class as (select stu_id,classes.class_id,units,grade_type,grade,num,title,year,qtr,fac 
                        from Academichistory INNER JOIN Classes on (academichistory.class_id=classes.class_id) 
										    where stu_id=1 and grade!='F' and grade!='W' and grade!='N/C' and grade!='U');
select * from ((temp_class inner join course on (temp_class.num=course.num)) inner join categories on (categories.num=course.num)) where cat_type='TE';*/

