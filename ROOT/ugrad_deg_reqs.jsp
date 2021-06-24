<html>

<body>
  <table border="1">
        <tr>
            <td valign="top">
                <%-- -------- Include menu HTML code -------- --%>
                <jsp:include page="index.html" />
            </td>
            <td valign="top">
            <h1>Undergraduate Degree Requirements</h1>
						

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
                        ("Select id,ssn,first_name,middle_name,last_name from student where student.id in (select id from undergraduate)");
											
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
            <form action="ugrad_deg_reqs.jsp" method="get">
						
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
                        ("Select name,deg_type from DegreeReqs where deg_type='B.S.' or deg_type='B.A.'");
        
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
								
								LinkedHashMap<String,Integer> req_info = new LinkedHashMap();
							
								
								DecimalFormat fmt = new DecimalFormat("0.0'0'");
															
								%>

								<%
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
                        ("Create table temp_class as (select stu_id,classes.class_id,units,grade_type,grade,num,title,year,qtr,fac "+ 
												                             "from Academichistory INNER JOIN Classes on (academichistory.class_id=classes.class_id) "+ 
																										 "where stu_id="+id+" and grade!='F' and grade!='W' and grade!='N/C' and grade!='U')");

               


                //total here
								ci_rs=statement2.executeQuery("select sum(units) as sum from temp_class inner join course on(temp_class.num=course.num)");
								while(ci_rs.next()){
								int totalu=(units-ci_rs.getInt("sum"));
								if(totalu<=0){totalu=0;}
								%>
                 <tr>
                 <td colspan="2">
								 <center>
								 <%= "Total Units Remaining<br>"+ci_rs.getInt("sum")+"/"+units+"<br>Still Need: "+totalu+" units" %>
								 </td>
								 </center>
                <tr>
               <%
								}
							
								
                               


							  ci_stmt = conn.prepareStatement(
                            "Select cat_type,req_units from DegreeCategories where name=?");
							  ci_stmt.setString(1,request.getParameter("NAME"));
                ci_rs = ci_stmt.executeQuery();
								while(ci_rs.next()){
                 req_info.put(ci_rs.getString("cat_type"),ci_rs.getInt("req_units"));

                 
								 si_stmt = conn.prepareStatement(
                 "select sum(temp_class.units) as sum from ((temp_class inner join course on (temp_class.num=course.num)) inner join categories on (categories.num=course.num)) where cat=?");

							  si_stmt.setString(1,ci_rs.getString("cat_type"));
                si_rs = si_stmt.executeQuery();
								while(si_rs.next()){
								int totalu=(ci_rs.getInt("req_units")-si_rs.getInt("sum"));
								if(totalu<=0){totalu=0;}
								%>
                 <tr>
                 <td colspan="2">
								 <center>
								 <%= ci_rs.getString("cat_type")+" Units Remaining<br>"+si_rs.getInt("sum")+"/"+ci_rs.getInt("req_units")+"<br>Still Need: "+totalu+" units" %>
								 </td>
								 </center>
                <tr>
								
               <%


								}
								}

               



              									  



						
					          
					

						
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
