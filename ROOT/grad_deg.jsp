<html>

<body>
  <table border="1">
        <tr>
            <td valign="top">
                <%-- -------- Include menu HTML code -------- --%>
                <jsp:include page="index.html" />
            </td>
            <td valign="top">
            <h1>Assign Grad Degrees</h1>
						

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
                            "INSERT INTO GradDegrees VALUES ( ?, ?,? )");

                        pstmt.setInt(1, Integer.parseInt(request.getParameter("ID")));
                        pstmt.setString(2, request.getParameter("DEG"));
                        pstmt.setString(3, request.getParameter("TYPE"));
												

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
                            "UPDATE Undergraduate SET college = ? WHERE id = ?");

                        pstmt.setInt(2, Integer.parseInt(request.getParameter("ID")));
                        pstmt.setString(1, request.getParameter("COLLEGE"));
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
                            "DELETE FROM GradDegrees WHERE id = ? AND deg = ? AND d_type=?");

                        pstmt.setInt(
                            1, Integer.parseInt(request.getParameter("ID")));
												pstmt.setString(
                            2, request.getParameter("DEG"));
												pstmt.setString(
                            3, request.getParameter("TYPE"));
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
                        ("SELECT * FROM GradDegrees");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>ID</th> 
                        <th>GRAD DEGREE</th>
                        <th>DEGREE TYPE</th>
												
												
                        <th>Action</th>
                    </tr>
                    <tr>
                        <form action="grad_deg.jsp" method="get">
                            <input type="hidden" value="insert" name="action">
                            <th><input value="" name="ID" size="10"></th> 
                            <th><input value="" name="DEG" size="10"></th> 
                            <th><input value="" name="TYPE" size="10"></th> 
														
												    <th><input type="submit" value="Insert"></th>
                        </form>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
        
                    while ( rs.next() ) {
        
            %>

                    <tr>
                       <%-- <form action="majors.jsp" method="get">
                            <input type="hidden" value="update" name="action">

                            <td>
                                <input value="<%= rs.getInt("id") %>" 
                                    name="ID" size="10" readonly>																
														</td>
														
    
                            <td>
                                <input value="<%= rs.getString("college") %>" 
                                    name="MAJOR" size="10">
                            </td>
    
                          
														
    
                            <td>
                                <input type="submit" value="Update">
                            </td>

                        </form>
										 --%>		
                        <form action="grad_deg.jsp" method="get">
                            <input type="hidden" value="delete" name="action">
														<td>

                            <input  
                                value="<%= rs.getInt("id") %>" name="ID" readonly>
																</td>
                              <td>

														<input  
                                value="<%= rs.getString("deg") %>" name="DEG" readonly>
																</td>

                            <%-- Button --%>
                            <td>
															<input  
                                value="<%= rs.getString("d_type") %>" name="TYPE" readonly>
																</td>

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
