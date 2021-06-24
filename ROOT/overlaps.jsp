<html>

<body>
  <table border="1">
        <tr>
            <td valign="top">
                <%-- -------- Include menu HTML code -------- --%>
                <jsp:include page="index.html" />
            </td>
            <td valign="top">
            <h1>View Overlaps</h1>
						

            <%-- Set the scripting language to Java and --%>
            <%-- Import the java.sql package --%>
            <%@ page language="java" import="java.sql.*" %>
    
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
                    // Check if an insertion is requested
                    if (action != null && action.equals("insert")) {

                        // Begin transaction
                        conn.setAutoCommit(false);
                        
                        // Create the prepared statement and use it to
                        // INSERT the student attributes INTO the Student table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "INSERT INTO Student VALUES (DEFAULT,?, ?, ?, ?, DATE(NOW()),DATE(NOW()) )");

                        pstmt.setString(1, request.getParameter("SSN"));
                        pstmt.setString(2, request.getParameter("FIRSTNAME"));
												pstmt.setString(3, request.getParameter("MIDDLENAME"));
                        pstmt.setString(4, request.getParameter("LASTNAME"));
                        /*pstmt.setString(5, request.getParameter("STARTDATE"));
                        pstmt.setString(6, request.getParameter("ENDDATE"));*/
												
                        int rowCount = pstmt.executeUpdate();

                        // Commit transaction
                        conn.commit();
                        conn.setAutoCommit(true);
                    }
            %>

            <%-- -------- UPDATE Code -------- --%>
            <%
                    // Check if an update is requested
                    if (action != null && action.equals("update")) {

                        // Begin transaction
                        conn.setAutoCommit(false);
                        
                        // Create the prepared statement and use it to
                        // UPDATE the student attributes in the Student table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "UPDATE Student SET first_name = ?, middle_name = ?, " +
                            "last_name = ?, start_date = DATE(?),  end_Date=DATE(?) WHERE id = ?");

                        pstmt.setInt(6, Integer.parseInt(request.getParameter("ID")));
                        pstmt.setString(1, request.getParameter("FIRSTNAME"));
												pstmt.setString(2, request.getParameter("MIDDLENAME"));
                        pstmt.setString(3, request.getParameter("LASTNAME"));
                        pstmt.setString(4, request.getParameter("STARTDATE"));
                        pstmt.setString(5, request.getParameter("ENDDATE"));

                        int rowCount = pstmt.executeUpdate();

                        // Commit transaction
                         conn.commit();
                        conn.setAutoCommit(true);
                    }
            %>

            <%-- -------- DELETE Code -------- --%>
            <%
                    // Check if a delete is requested
                    if (action != null && action.equals("delete")) {

                        // Begin transaction
                        conn.setAutoCommit(false);
                        
                        // Create the prepared statement and use it to
                        // DELETE the student FROM the Student table.


                     /*   PreparedStatement pstmt = conn.prepareStatement(
                            "DELETE FROM Majors WHERE id = ?");

                        pstmt.setInt(
                            1, Integer.parseInt(request.getParameter("ID")));
                        int rowCount = pstmt.executeUpdate();

											  pstmt = conn.prepareStatement(
                            "DELETE FROM Minors WHERE id = ?");

                        pstmt.setInt(
                            1, Integer.parseInt(request.getParameter("ID")));
                        rowCount = pstmt.executeUpdate();

												pstmt = conn.prepareStatement(
                            "DELETE FROM Graduate WHERE id = ?");

                        pstmt.setInt(
                            1, Integer.parseInt(request.getParameter("ID")));
                        rowCount = pstmt.executeUpdate();


												pstmt = conn.prepareStatement(
                            "DELETE FROM Undergraduate WHERE id = ?");

                        pstmt.setInt(
                            1, Integer.parseInt(request.getParameter("ID")));
                        rowCount = pstmt.executeUpdate();

                        
												pstmt = conn.prepareStatement(
                            "DELETE FROM PrivateInfo WHERE id = ?");

                        pstmt.setInt(
                            1, Integer.parseInt(request.getParameter("ID")));
                        rowCount = pstmt.executeUpdate();

												pstmt = conn.prepareStatement(
                            "DELETE FROM AttendanceInfo WHERE id = ?");

                        pstmt.setInt(
                            1, Integer.parseInt(request.getParameter("ID")));
                        rowCount = pstmt.executeUpdate();

*/

                        PreparedStatement pstmt = conn.prepareStatement(
                            "DELETE FROM Student WHERE id = ?");

                        pstmt.setInt(
                            1, Integer.parseInt(request.getParameter("ID")));
                        int rowCount = pstmt.executeUpdate();

                        // Commit transaction
                         conn.commit();
                        conn.setAutoCommit(true);
                    }
            %>

            <%-- -------- SELECT Statement Code -------- --%>
            <%
                    // Create the statement
                    Statement statement = conn.createStatement();

                    // Use the created statement to SELECT
                    // the student attributes FROM the Student table.
                    ResultSet rs = statement.executeQuery
                        ("Select Distinct on (id) id,ssn,first_name,middle_name,last_name "+ 
												 "from student INNER JOIN enrolled on (student.id=enrolled.stu_id) ORDER BY id ASC");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>Select Student</th>
                        <th>Action</th>
												
										</tr>
                               <%-- -------- Iteration Code -------- --%>
						<tr>
            <form action="overlaps.jsp" method="get">
						
						<td>
						
						<select name="SSN">
            <%
                    // Iterate over the ResultSet
        
                    while ( rs.next() ) {
        
            %>

                    <option value="<%= rs.getString("ssn") %>" >
		                  <%= rs.getInt("id") + " " + rs.getString("ssn") + " " + rs.getString("first_name") + " " + rs.getString("middle_name") + " " + rs.getString("last_name") %>
										</option>	
                           

														
                            <%-- Get the COLLEGE --%>

														
    
                            <%-- Button --%>
                                                                    
            <%
                    }
            %>
						 </select>

						 
						</td>
						<td>
            <input name="view" type="submit" value="view">
						
            </td>
            </form>
						

						 </tr>
						
						 <% 
              if( (request.getParameter("view") != null) && (request.getParameter("view").equals("view")) ){

						     PreparedStatement si_stmt = conn.prepareStatement(
                            "Select id,ssn,first_name,middle_name,last_name from student WHERE ssn = ?");
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
								%>

								<%
                while(si_rs.next()){
								
								  id=si_rs.getInt("id");
								  ssn=si_rs.getString("ssn");
                  fn=si_rs.getString("first_name");                
								  mn=si_rs.getString("middle_name");
                  ln=si_rs.getString("last_name");

									student_info+="Student id: "+id+"<br>SSN: "+ssn+"<br> "+fn+" "+mn+" "+ln;
                
							
               
						   }
               %>
						 <tr>

						 <td colspan="2">
						 <center>
						 <%=student_info%>
						 </center>
						 </td>
						 </tr>

           <%
					  student_info="";
						si_stmt = conn.prepareStatement(
                            "select all_overs.num as cnum,all_overs.title as ctitle,count(*) as ccount "+
                            "from( select nc.id,nc.num,nc.title from "+																			 
                                               "(select * from enrolled inner join section on enrolled.class_id=section.id where stu_id=? and sect_type!='RE') as oc, "+
                                               "(select * from classes inner join section on classes.class_id=section.id "+
                                                "where year=2009 and qtr='S' and sect_type!='RE' and classes.num not in "+
					                                                               "( select c.num from (enrolled inner join classes on classes.class_id=enrolled.class_id) as c "+
																																				   "where c.stu_id=?) "+
																	             ") as nc "+
                                   "where ( (oc.day1=nc.day1 and oc.day1!='N/A') or (oc.day2=nc.day2 and oc.day2!='N/A') or (oc.day3=nc.day3 and oc.day3!='N/A')) "+
                                         "and "+ 
		                                     "(SELECT (oc.start_time,oc.end_time) OVERLAPS (nc.start_time,nc.end_time) )=true "+
		                               "group by nc.id,nc.num,nc.title "+
		
		                               ") as all_overs "+
                            "group by all_overs.num,all_overs.title "+
                            "having count(*) = (select count(*) from "+
														                   "classes cl where cl.num=all_overs.num and "+
																							                  "cl.title=all_overs.title and "+
																																"cl.year=2009 and "+ 
																																"cl.qtr='S')");

             si_stmt.setInt(1,id);
             si_stmt.setInt(2,id);
						 
             si_rs = si_stmt.executeQuery();


						 %>
						


						 <%!
						  String cnum="";
							String ctitle="";
							int ccount=0;
							int over_flag=1;


						 %>
						 <%

						 while(si_rs.next()){
									if(over_flag==1){
									%>
									  <tr>

						       <th colspan="2">Overlapping Classes</th>
									 </tr>
										

                  <%
									over_flag=0;
									}
								
								  ccount=si_rs.getInt("ccount");
								  cnum=si_rs.getString("cnum");
                  ctitle=si_rs.getString("ctitle");
						%>			
             <tr>

						 <td colspan="2">
						 <center>
						 <%=cnum+"<br>"+ctitle%>
						 </center>
						 </td>
						 </tr>
                
							
           <%   
						}
					
																		 
						}//view pushed
						
            

             


            
            
           						
                    // Close the ResultSet
                    rs.close();
    
                    // Close the Statement
                    statement.close();
    
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
