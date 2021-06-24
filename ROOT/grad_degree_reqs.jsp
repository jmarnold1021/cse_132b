<html>

<body>
  <table border="1">
        <tr>
            <td valign="top">
                <%-- -------- Include menu HTML code -------- --%>
                <jsp:include page="index.html" />
            </td>
            <td valign="top">
            <h1>Grad Degree Requirements</h1>
						

            <%-- Set the scripting language to Java and --%>
            <%-- Import the java.sql package --%>
            <%@ page language="java" import="java.sql.*" %>
            <%@ page language="java" import="java.util.*" %>
            <%@ page language="java" import="java.text.*" %>
						
						

    
            <%-- -------- Open Connection Code -------- --%>
            <%!        
						     
                    String jdbcDriver = "org.postgresql.Driver";
                    String jdbcURL    = "jdbc:postgresql:testdb";
                    String user       = "temp_user";
                    String password   = "temp";
					 %>

            <%-- -------- INSERT Code -------- --%>
            <%
						 
						    try {


						        Class.forName(jdbcDriver).newInstance();
                    Connection conn = DriverManager.getConnection(jdbcURL, user, password);

                    String action = request.getParameter("action");
           

                              // Create the statement
                    Statement statement = conn.createStatement();

                    // Use the created statement to SELECT
                    // the student attributes FROM the Student table.
                    ResultSet rs = statement.executeQuery
                        ("Select id,ssn,first_name,middle_name,last_name from student where student.id in (select id from graduate)");
											
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>Select Student</th>
                        <th>Select Degree</th>
                        <th>Action</th>
												
												
										</tr>
                               <%-- -------- Iteration Code -------- --%>
						<tr>
            <form action="grad_degree_reqs.jsp" method="get">
						
						<td>
						<center>
						<select name="SSN" >

						
            <%
                    // Iterate over the ResultSet
        
                    while ( rs.next() ) {
									
        
            %>

                    <option value="<%= rs.getString("ssn") %>">
		                  <%= rs.getInt("id") + " " + rs.getString("ssn") + " " + rs.getString("first_name") + " " + rs.getString("middle_name") + " " + rs.getString("last_name") %>

										</option>
                         

														
                            <%-- Get the COLLEGE --%>

														
    
                            <%-- Button --%>
                                                               
            <%
                    }
                    // Close the ResultSet
                    rs.close();
    
                    // Close the Statement
                    statement.close();


									
            %>
						
						 </select>

						 
						
						
						</center>
            </td>
					
						<td >
						<center>
						<select name="NAME" >

						
            <%
                    // Iterate over the ResultSet
										Statement statement1 = conn.createStatement();

                    // Use the created statement to SELECT
                    // the student attributes FROM the Student table.
                    ResultSet rs1 = statement1.executeQuery
                        ("Select name,deg_type from DegreeReqs where deg_type='M.S.' or deg_type='M.A.'");
        
                    while ( rs1.next() ) {
																			
									
        
            %>

                    <option value="<%= rs1.getString("name") %>">
		                  <%= rs1.getString("name") + " " + rs1.getString("deg_type") %>
										</option>
                         

														
                                                                                   
            <%
                    }
										// Close the ResultSet
                    rs1.close();
    
                    // Close the Statement
                    statement1.close();

            %>
						
						 </select>

						 
						
						
						</center>
            </td>
							<td>
            <input name="view" type="submit" value="view">
						
						</td>



            </form>
						

						 </tr>
						
						 <% 
              if( (request.getParameter("view") != null) && (request.getParameter("view").equals("view")) ){

							  

						    PreparedStatement si_stmt = conn.prepareStatement(
                            "Select id,ssn,first_name,middle_name,last_name from student WHERE ssn =?");
							  si_stmt.setString(1,request.getParameter("SSN"));
                ResultSet si_rs = si_stmt.executeQuery();
             %>
								<%!
                int id=9999999;
                String ssn="";
                String fn="";             
								String mn="";
                String ln="";
								String student_info="";
								String degree_info="";
								String conc_info="";
								String rem_info="";
								
								int print_comp=0;
								int print_rem=0;
								
								
								LinkedHashMap<Integer,String> qtr_con = new LinkedHashMap();
							

								LinkedHashMap<String,String> conc_data = new LinkedHashMap();
								
							
								
								DecimalFormat fmt = new DecimalFormat("0.0'0'");
															
								%>

								<%
								qtr_con.put(0,"S1");
								qtr_con.put(1,"S1");
								qtr_con.put(2,"F");
								qtr_con.put(3,"W");
								qtr_con.put(4,"S");

                while(si_rs.next()){
								
								  id=si_rs.getInt("id");
								  ssn=si_rs.getString("ssn");
                  fn=si_rs.getString("first_name");                
								  mn=si_rs.getString("middle_name");
                  ln=si_rs.getString("last_name");

									 student_info="Student : " +id+"<br>SSN : "+ssn+"<br>"+fn+ " "+mn+ " "+ln;
									 
								}
								



							               
						  	PreparedStatement ci_stmt = conn.prepareStatement(
                            "Select * from DegreeReqs where name=?");
							  ci_stmt.setString(1,request.getParameter("NAME"));
                ResultSet ci_rs = ci_stmt.executeQuery();


								%>





								<%!
								
                String name="";
                String un="";             
                String type="";
                String dept="";
								int units=0;

																
								
															
                %>
								
								<%
								
						
                while(ci_rs.next()){
								  name=ci_rs.getString("name");
                  type=ci_rs.getString("deg_type");                
								  un=ci_rs.getString("university");
									dept=ci_rs.getString("dept");
									units=ci_rs.getInt("total_units");
									degree_info=name+" "+type+"<br>"+un+ " : "+dept+ "<br> Required Units:  "+units;
                 									
                 									 
									
	                     
               }

							 %>

							  <tr>
						<td>
						<center>
						<%= student_info %>
						</center>
						</td>
						<td>
						<center>
						<%= degree_info %>
						</center>
						</td>
            </tr>
							 <%
								 

							   // Iterate over the ResultSet
								Statement statement2 = conn.createStatement();

                 // Use the created statement to SELECT
                 // the student attributes FROM the Student table.
                 int rs2 = statement2.executeUpdate
                        ("Create table temp_class as (select classes.num,grade,NUMBER_GRADE,units "+ 
												                              "from (((academichistory inner join grade_conversion on grade=LETTER_GRADE) "+ 
																											"inner join classes on academichistory.class_id=classes.class_id) " +
																											"inner join course on classes.num=course.num) "+
																											"where stu_id="+id+" and grade!='F' and grade!='U' and grade!='W' and grade!='N/C')");

               


          
							
								
                               

							  ci_stmt = conn.prepareStatement(
                            "Select cat_type,req_units,avg_cat_gpa from DegreeConcentrations where name=?");
							  ci_stmt.setString(1,name);
                ci_rs = ci_stmt.executeQuery();


								while(ci_rs.next()){
               
                 
								si_stmt = conn.prepareStatement(
                 "Select sum(temp_class.units) as cunits from (temp_class inner join concentration on temp_class.num=concentration.num) where conc=?");

							  si_stmt.setString(1,ci_rs.getString("cat_type"));
								
                si_rs = si_stmt.executeQuery();
								while(si_rs.next()){
								int totalu=(ci_rs.getInt("req_units")-si_rs.getInt("cunits"));
								//double tgpa = (si_rs.getFloat("cgpa")-ci_rs.getFloat("avg_cat_gpa"));
							
								
								
								if( totalu<=0){
								
                 
								 
								   conc_info+=ci_rs.getString("cat_type")+" Units: "+si_rs.getInt("cunits")+"/"+ci_rs.getInt("req_units");
								   print_comp=1;
								 

								
								}
								}
							si_stmt = conn.prepareStatement(
                 "select sum(temp_class.units*NUMBER_GRADE)/sum(temp_class.units) as cgpa from (temp_class inner join concentration on temp_class.num=concentration.num) where conc=? and grade!='S'");

							  si_stmt.setString(1,ci_rs.getString("cat_type"));
                si_rs = si_stmt.executeQuery();
								while(si_rs.next()){
								double tgpa = (si_rs.getFloat("cgpa")-ci_rs.getFloat("avg_cat_gpa"));
								if( tgpa>0 && print_comp==1 ){
								conc_info+=", gpa: "+si_rs.getFloat("cgpa") + " needs " + ci_rs.getFloat("avg_cat_gpa")+"<br>";

								  

								}
								
								  
								}
								
								





								 si_stmt = conn.prepareStatement(
                 "select classes.num,min(year) as my,min(qtr_val) as mq "+
								 "from (((classes inner join course on classes.num=course.num) " +
								 "inner join qtr_conversion on qtr=qtrr) "+
								 "inner join concentration on classes.num=concentration.num) "+
								 "where conc=? and classes.num not in "+
								                               "( select c.num from (academichistory a inner join classes c on a.class_id=c.class_id) "+
																							   "where a.stu_id=? and grade!='F' and grade!='U' and grade!='W' and grade!='N/C' "+
																							 ") "+
																								 "group by classes.num "+
																								 "having min(year)>2005 or (min(year)=2005 and (min(qtr_val)=0 or min(qtr_val)=1 or min(qtr_val)=2))");

							  si_stmt.setString(1,ci_rs.getString("cat_type"));
							  si_stmt.setInt(2,id);
								
								
                si_rs = si_stmt.executeQuery();
								while(si_rs.next()){
															
								   
                 
								   
								   print_rem=1;
									 rem_info+=si_rs.getString("num")+" Offered Next in : "+si_rs.getInt("my")+" "+qtr_con.get(si_rs.getInt("mq"))+"<br>";
								 

								
								



								
                
								
                  conc_data.put(ci_rs.getString("cat_type"),rem_info);
               


								}
								rem_info="";
							


								}//each concentration
								if(print_comp==1){
								%>
								<tr>
								<th colspan="2">Completed Concentrations</th>
								</tr>
								<tr>
								<td colspan="2">
								<center>
								<%=conc_info%>
								</center>
								</td>
								</tr>
                

								<%

								}
								if(print_rem==1){
								%>
								 <tr>
                  <th colspan="2">Incomplete Concentration Courses</th>
								 </tr>
								<%
								  for(String conc : conc_data.keySet()){
                %>
								<tr>
								<td>
								<center>
								<%=conc%>
								</center>
								</td>
								<td>
								<center>
								<%=conc_data.get(conc)%>
								</center>
								</td>
								</tr>
               
                 
					      <%
                  }
								
								}
								print_comp=0;
								conc_info="";
								conc_data.clear();

               



              									  



						
					          
					

						
            %>
            


            
            <%-- -------- Close Connection Code -------- --%>
            <%



						       Statement statement3 = conn.createStatement();

                    // Use the created statement to SELECT
                    // the student attributes FROM the Student table.
                    statement3.executeUpdate("Drop table temp_class");

												
									
						}//view pushed
						

                       
                    // Close the Connection
                    conn.close();
                } catch (SQLException sqle) {
                    out.println(sqle.getMessage());
                } catch (Exception e) {
                    out.println(e.getMessage());
                }
            %>
						</table>
            </td>
        </tr>
    </table>
</body>

</html>
