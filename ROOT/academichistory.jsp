<html>

<body>
  <table border="1">
        <tr>
            <td valign="top">
                <%-- -------- Include menu HTML code -------- --%>
                <jsp:include page="index.html" />
            </td>
            <td valign="top">
            <h1>Add Academic History</h1>
						

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
                            "INSERT INTO AcademicHistory VALUES ( ?,?,?,?,?)");
                          

												pstmt.setInt(
                            1, Integer.parseInt(request.getParameter("STU_ID")));	
                       	pstmt.setInt(
                            2, Integer.parseInt(request.getParameter("CLASS_ID")));
												
												pstmt.setInt(
                            3, Integer.parseInt(request.getParameter("UNITS")));
									      pstmt.setString(
                            4, request.getParameter("GRADE_TYPE").toUpperCase());
												

												pstmt.setString(
                            5, request.getParameter("GRADE").toUpperCase() );

														
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
                            "UPDATE AcademicHistory SET units=?, grade_type=?, grade = ? WHERE stu_id= ? AND class_id=?"); 
                        												pstmt.setInt(
                            4, Integer.parseInt(request.getParameter("STU_ID")));
												pstmt.setInt(
                            5, Integer.parseInt(request.getParameter("CLASS_ID")));
												pstmt.setInt(
                            1, Integer.parseInt(request.getParameter("UNITS")));
                        pstmt.setString(
                            2, request.getParameter("GRADE_TYPE"));
												pstmt.setString(
                            3, request.getParameter("GRADE"));

												
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
                            "DELETE FROM AcademicHistory WHERE stu_id = ? AND class_id = ?");

                        pstmt.setInt(
                            1, Integer.parseInt(request.getParameter("STU_ID")));
												pstmt.setInt(
                            2, Integer.parseInt(request.getParameter("CLASS_ID")));
											
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
                        ("SELECT * FROM AcademicHistory");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>STUDENT ID</th>
                        <th>CLASS ID</th>
												
												<th>UNITS</th>
												
												<th>GRADE TYPE</th>
												<th>GRADE</th>
												
												
                        <th>Action</th>
                    </tr>
										
                    <tr>
                        <form action="academichistory.jsp" method="get">
										
                            <input type="hidden" value="insert" name="action">
			                      <th><input value="" name="STU_ID" size="15"></th>
			                      <th><input value="" name="CLASS_ID" size="15"></th>
														
																  
														<th><input value="" name="UNITS" size="10"></th>
														<td><select name="GRADE_TYPE">
														<option value="L">Letter(L)</option>
														<option value="S/U">S/U</option>
														</select>
														</td>
														<th><input value="" name="GRADE" size="10"></th>
														
														

														
														<th><input type="submit" value="Insert"></th>
                        </form>
                    </tr>
							
																			


            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
        
                    while ( rs.next() ) {
        
            %>

                    <tr>
                        <form action="academichistory.jsp" method="get">
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
                            <%-- Get the ID --%>
                            													
															<td>
                                <input value="<%= rs.getInt("units") %>" 
                                    name="UNITS" size="10" >
                            </td>
															<td>
                                <input value="<%= rs.getString("grade_type") %>" 
                                    name="GRADE_TYPE" size="10" >
                            </td>
														<td>
                                <input value="<%= rs.getString("grade") %>" 
                                    name="GRADE" size="10">
                            </td>
													
														
    
                   					<%-- Button --%>
                            <td>
                                <input type="submit" value="Update">
                            </td>
                        </form>
                        <form action="academichistory.jsp" method="get">
                            <input type="hidden" value="delete" name="action">

														<input type="hidden" 
                                value="<%= rs.getInt("stu_id") %>" name="STU_ID">

														<input type="hidden" 
                                value="<%= rs.getInt("class_id") %>" name="CLASS_ID">
																													
                            <%-- Button --%>
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
                </table>
            </td>
        </tr>
    </table>
</body>

</html>
