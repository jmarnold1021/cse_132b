<html>

<body>
  <table border="1">
        <tr>
            <td valign="top">
                <%-- -------- Include menu HTML code -------- --%>
                <jsp:include page="index.html" />
            </td>
            <td valign="top">
             <h1> Enroll Students</h1>
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
                        /* 
												 String p_select = "Select count(*) as cap From Enrolled Where sect_id=? AND year=? AND qtr=?";
												 PreparedStatement pstmt = conn.prepareStatement(p_select);
                              
													pstmt.setInt(
                             1, Integer.parseInt(request.getParameter("SECT_ID")));
													pstmt.setInt(
                             2, Integer.parseInt(request.getParameter("YEAR")));
                          pstmt.setString(
                             3, request.getParameter("QTR"));	
												      
															
												ResultSet rset = pstmt.executeQuery();
                        rset.next();
												System.out.println("There are " + rset.getInt("cap"));
												int cap = rset.getInt("cap");



												p_select = "Select class_size as size From Section Where id=?";
												pstmt = conn.prepareStatement(p_select);
                              
															pstmt.setInt(
                                 1, Integer.parseInt(request.getParameter("SECT_ID")));
																
												      
															
												rset = pstmt.executeQuery();
                        rset.next();
												System.out.println("There are " + rset.getInt("size"));
												int size = rset.getInt("size");
                        
												if(size==cap){

                        //get waitlist length
												p_select = "Select count(*) as w_size From Waitlisted Where sect_id=? AND year=? AND qtr=?";
												pstmt = conn.prepareStatement(p_select);
                              
															pstmt.setInt(
                                 1, Integer.parseInt(request.getParameter("SECT_ID")));
															pstmt.setInt(
                                 2, Integer.parseInt(request.getParameter("YEAR")));
                              pstmt.setString(
                                 3, request.getParameter("QTR"));
																
												      
															
												rset = pstmt.executeQuery();
                        rset.next();

												int wait_size = rset.getInt("w_size");


               

												 System.out.println("Adding to wait list");
												 pstmt = conn.prepareStatement(
                            "INSERT INTO Waitlisted VALUES ( ?, ?, ?, ?, ?)");
                          
                          pstmt.setInt(
                             1, Integer.parseInt(request.getParameter("STU_ID")));
												  pstmt.setInt(
                             2, Integer.parseInt(request.getParameter("YEAR")));
                          pstmt.setString(
                             3, request.getParameter("QTR"));	
												  pstmt.setInt(
                             4, Integer.parseInt(request.getParameter("SECT_ID")));
													pstmt.setInt(
                             5, wait_size+1 );
												  int rowCount = pstmt.executeUpdate();


                        }
												else{*/
                        
                        // Create the prepared statement and use it to
                        // INSERT the student attributes INTO the Student table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "INSERT INTO Enrolled VALUES ( ?, ?, ?, ?)");
                          
                          pstmt.setInt(
                             1, Integer.parseInt(request.getParameter("STU_ID")));
												  pstmt.setInt(
                             2, Integer.parseInt(request.getParameter("CLASS_ID")));
                          pstmt.setInt(
                             3, Integer.parseInt(request.getParameter("UNITS")));
												   pstmt.setString(
                             4, request.getParameter("GRADE_TYPE"));	

												  int rowCount = pstmt.executeUpdate();
												//}
											
                        // Commit transaction
                        conn.commit();
                        conn.setAutoCommit(true);
                    }
										if (action != null && action.equals("insertw")) {
                        
											  // Begin transaction
                        conn.setAutoCommit(false);

												 PreparedStatement pstmt = conn.prepareStatement(
                            "INSERT INTO Waitlisted VALUES ( ?, ?, ?, ?, ?)");
                          
                          pstmt.setInt(
                             1, Integer.parseInt(request.getParameter("STU_IDw")));
												  pstmt.setInt(
                             2, Integer.parseInt(request.getParameter("YEARw")));
                          pstmt.setString(
                             3, request.getParameter("QTRw"));	
												  pstmt.setInt(
                             4, Integer.parseInt(request.getParameter("SECT_IDw")));
													pstmt.setInt(
                             5, Integer.parseInt(request.getParameter("POSw")));
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
                            "UPDATE Enrolled SET units = ?, grade_type=UPPER(?) WHERE stu_id= ? AND class_id=?");

                      	pstmt.setInt(
                            3, Integer.parseInt(request.getParameter("STU_ID")));
												pstmt.setInt(
                            4, Integer.parseInt(request.getParameter("CLASS_ID")));
												
                        pstmt.setInt(
                            1, Integer.parseInt(request.getParameter("UNITS")));
                        pstmt.setString(
                            2, request.getParameter("GRADE_TYPE"));
												
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

												PreparedStatement pstmt = conn.prepareStatement(
                            "DELETE FROM Enrolled WHERE stu_id = ? AND class_id = ?");

                        
												pstmt.setInt(
                            1, Integer.parseInt(request.getParameter("STU_ID")));
												pstmt.setInt(
                            2, Integer.parseInt(request.getParameter("CLASS_ID")));

                        int rowCount = pstmt.executeUpdate();
                        
               

                        // Commit transaction
                         conn.commit();
                        conn.setAutoCommit(true);
                    }
										if (action != null && action.equals("deletew")) {

                        // Begin transaction
                        conn.setAutoCommit(false);
                        
                        // Create the prepared statement and use it to
                        // DELETE the student FROM the Student table.

												PreparedStatement pstmt = conn.prepareStatement(
                            "DELETE FROM Waitlisted WHERE stu_id = ? AND year = ? AND qtr=? AND sect_id= ?");

                        
												pstmt.setInt(
                            1, Integer.parseInt(request.getParameter("STU_IDw")));
												pstmt.setInt(
                            2, Integer.parseInt(request.getParameter("YEARw")));
                        pstmt.setString(
                            3, request.getParameter("QTRw"));
												pstmt.setInt(
                            4, Integer.parseInt(request.getParameter("SECT_IDw")));

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
                        ("SELECT * FROM Enrolled");

										
            %>

            <!-- Add an HTML table header row to format the results -->
					<%--	<table>
						<tr>
						<th>Enrolled Students</th>
						<th>Waitlisted Students</th>
						
						</tr>
						<tr>
						<td valign="top"> --%>
                <table border="1">
                    <tr>
                        <th>STUDENT ID</th>
                        <th>CLASS ID</th>
												
		                  	<th>UNITS</th>
                        <th>GRADE TYPE</th>
																								
                        <th>Action</th>
                    </tr>
										
                    <tr>
                        <form action="enroll.jsp" method="get">
										
                            <input type="hidden" value="insert" name="action">
			                      <th><input value="" name="STU_ID" size="15"></th>
														
			                      <th><input value="" name="CLASS_ID" size="15"></th>
			                      <th><input value="" name="UNITS" size="15"></th>
														<td><select name="GRADE_TYPE">
														<option value="L">Letter(L)</option>
														<option value="S/U">S/U</option>
														
														</select>
														</td>
			                    													  
                          
														
														<th><input type="submit" value="Insert"></th>
                        </form>
                    </tr>
							
																			


            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
        
                    while ( rs.next() ) {
        
            %>

                    <tr>
                        <form action="enroll.jsp" method="get">
                            <input type="hidden" value="update" name="action">

                            <%-- Get the SSN, which is a number --%>
														<td>
                                <input value="<%= rs.getInt("stu_id") %>"
                                    name="STU_ID" size="15" readonly>
                            </td>
                            
														<td>
                                <input value="<%= rs.getInt("class_id") %>"
                                    name="CLASS_ID" size="15" readonly>
                            </td>
														<td>
                                <input value="<%= rs.getInt("units") %>"
                                    name="UNITS" size="15" >
                            </td>
														<td>
														    
                                <input value="<%= rs.getString("grade_type") %>"
                                    name="GRADE_TYPE" size="15" >
                            </td>
														
    
                            <%-- Get the ID 
														
                            <td>
                                <input value="<%= rs.getInt("year") %>" 
                                    name="YEAR" size="10" readonly>
                            </td>--%>
    
                            <%-- Get the FIRSTNAME 
                            <td>
                                <input value="<%= rs.getString("qtr") %>"
                                    name="QTR" size="15" readonly>
                            </td>--%>
																												
    
                   					<%-- Button --%>
                            <td>
                                <input type="submit" value="Update">
                            </td>
                        </form>

                        <form action="enroll.jsp" method="get">
                            <input type="hidden" value="delete" name="action">
														

														<input type="hidden" 
                                value="<%= rs.getInt("stu_id") %>" name="STU_ID">

                          
														<input type="hidden" 
                                value="<%= rs.getString("class_id") %>" name="CLASS_ID">		
                            <td>
                                <input type="submit" value="Delete">
                            </td>
														
                        </form>
												
                    </tr>
            <%
                    }
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
            </td>
        </tr>
    </table>
</body>

</html>
