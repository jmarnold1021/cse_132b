<html>

<body>
  <table border="1">
        <tr>
            <td valign="top">
                <%-- -------- Include menu HTML code -------- --%>
                <jsp:include page="index.html" />
            </td>
            <td valign="top">
            <h1>Add NumChanges</h1>
						

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
 
											  // Create the statement
                        //PreparedStatement state = conn.prepareStatement("SELECT * FROM NumChanges where num_to = ?");
											  // state.setString(1,request.getParameter("FNUM"));

                        // Use the created statement to SELECT
                        // the student attributes FROM the Student table.
                       // ResultSet rst = state.executeQuery();

                         //if(rst.next()){
                           //System.out.println("Prev mapping found" + rst.getString("num_from"));

												 //}
                         //  System.out.println("end search");
												 


                                                
                        // Create the prepared statement and use it to
                        // INSERT the student attributes INTO the Student table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "INSERT INTO NumChanges VALUES ( ?, ?, ? )");
                          
                        pstmt.setString(1, request.getParameter("FNUM"));
                       
                        pstmt.setString(2, request.getParameter("TNUM"));
                        pstmt.setInt(3, Integer.parseInt(request.getParameter("YEAR")));
												
												
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
                            "UPDATE Concentration SET conc = ? WHERE num = ?");

                      
                        pstmt.setString(1, request.getParameter("FNUM"));
												
                        pstmt.setString(2, request.getParameter("TNUM"));
                        pstmt.setString(3, request.getParameter("YEAR"));
												
												

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
                            "DELETE FROM numchanges WHERE (num_from = ? AND num_to = ? AND year_changed = ?)");

                        pstmt.setString(
                            1, request.getParameter("FNUM"));
												pstmt.setString(
                            2, request.getParameter("TNUM"));
												pstmt.setInt(
                            3, Integer.parseInt(request.getParameter("YEAR")));
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
                        ("SELECT * FROM NumChanges");
										
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>FROM NUM</th>
		                  	<th>TO NUM</th> 
		                  	<th>YEAR CHANGED</th> 
                        <th>Action</th>
                    </tr>
										
                    <tr>
                        <form action="numchanges.jsp" method="get">
										
                            <input type="hidden" value="insert" name="action">
                            <th><input value="" name="FNUM" size="10"></th>
			                      <th><input value="" name="TNUM" size="15"></th>
			                      <th><input value="" name="YEAR" size="15"></th>
														
														<th><input type="submit" value="Insert"></th>
                        </form>
                    </tr>
							
																			


            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
        
                    while ( rs.next() ) {
        
            %>

                    <tr>
                       <%-- <form action="concentrations.jsp" method="get">
                            <input type="hidden" value="update" name="action"> --%>

                            <%-- Get the SSN, which is a number --%>
													<form action="numchanges.jsp" method="get">
                            <input type="hidden" value="delete" name="action">
                            <td>
                                <input value="<%= rs.getString("num_from") %>" 
                                    name="FNUM" size="10" readonly>
                            </td>
														
    
                            <%-- Get the ID --%>
                            <td>
                                <input value="<%= rs.getString("num_to") %>" 
                                    name="TNUM" size="10" readonly>
                            </td>

														 <td>
                                <input value="<%= rs.getInt("year_changed") %>" 
                                    name="YEAR" size="10" readonly>
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
