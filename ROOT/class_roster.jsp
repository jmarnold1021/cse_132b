<html>

<body>
  <table border="1">
        <tr>
            <td valign="top">
                <%-- -------- Include menu HTML code -------- --%>
                <jsp:include page="index.html" />
            </td>
            <td valign="top">
            <h1>View Class Roster</h1>
						

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
                        ("Select distinct(title) from classes");
											
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>Select Class</th>
                        <th>Action</th>
												
										</tr>
                               <%-- -------- Iteration Code -------- --%>
						<tr>
            <form action="class_roster.jsp" method="get">
						
						<td>
						
						<select name="TITLE" >

						
            <%
                    // Iterate over the ResultSet
        
                    while ( rs.next() ) {
									
        
            %>
						

                    <option value="<%= rs.getString("title") %>">
		                <%= rs.getString("title") %>
                       
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
                            "Select class_id,num,title,year,qtr,fac,s_date,e_date from classes WHERE title =?");
							  si_stmt.setString(1,request.getParameter("TITLE"));
                ResultSet si_rs = si_stmt.executeQuery();
               %>
								<%!
                int id=9999999;
                String num="";
                String title="";             
                String qtr="";
                String fac="";
								String sd="";
								String ed="";
								
                int year=0001;
								int flag = 0;
								
								%>

								<%
								flag=0;
                while(si_rs.next()){
								
								  id=si_rs.getInt("class_id");
								  num=si_rs.getString("num");
                  title=si_rs.getString("title");                
								  year=si_rs.getInt("year");
									
								  qtr=si_rs.getString("qtr");
                  fac=si_rs.getString("fac");
									sd=si_rs.getString("s_date");
                  ed=si_rs.getString("e_date");

									if(flag==0){
                %>
						
						<tr>
						 <td>
						 <center>
             <p>
						   
               <%= num%><br> 
							 <%=title%><br>
							 

						 </p>
						 </center>
             </td>
						</tr>
						<%
						 flag=1; 
						}
						%>
						 <tr>
             <td>
						 <center>
             <p>
               <%="<h4>Section : "+id+"</h4>"%><br> 
						   <%= qtr+" - "+year%><br>
						   <%= sd+" - "+ed%><br>
							 
							 <%=fac%><br>
							 

						 </p>
						 </center>
             </td>
						 <td>
             <p>
						 

						<%
                
						  

							PreparedStatement ci_stmt = conn.prepareStatement(
                            "Select  id,ssn,first_name,middle_name,last_name,start_date,end_date,units,grade_type from (student INNER JOIN AcademicHistory on (student.id=AcademicHistory.stu_id)) where academichistory.class_id=?");
							  ci_stmt.setInt(1,id);
                ResultSet ci_rs = ci_stmt.executeQuery();
								%>
								<%!
								
                int cid=9999999;
                String cssn="";
                String cfn="";             
								String cmn="";
                String cln="";
								String csd="01-01-0001";
								String ced="01-01-0001";
								int cunits=9999999;
								String cgt="";
								
								
								
                %>
								
								<%
                while(ci_rs.next()){
								  cid=ci_rs.getInt("id");
								  cssn=ci_rs.getString("ssn");
                  cfn=ci_rs.getString("first_name");
									cmn=ci_rs.getString("middle_name");
									cln=ci_rs.getString("last_name");
                  csd=ci_rs.getString("start_date");
                  ced=ci_rs.getString("end_date");
                  cunits=ci_rs.getInt("units");
                  cgt=ci_rs.getString("grade_type");
									


             
  
							
						 %>

             
						   <%= cfn+ " "+cmn+ " "+cln %><br>
               <%=" id: "+cid+", ssn: "+cssn+", U: "+cunits+", GT: "+cgt/*+", "+csd+" to "+ced*/ %><br><br>
						  <%--
               <%="Section id : " +cid %><br>
							 <%="Num : "+cnum%><br>
							 <%="Title : "+ctitle%><br> 
							 <%="Faculty :  "+cfac%><br>
							 <%="Units :  "+cunits%><br>
							 <%="Grade Type :  "+cgrade%>
               --%>
							 


						 
	 					
				
						 <%
						}//query 2
            %>
						</p>
            </td>
          
						 </tr>
            <%

						  
						}//query 1
						}//view pushed
						
            %>

             


            
            <%-- -------- Close Connection Code -------- --%>
            <%
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
