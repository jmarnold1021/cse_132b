<html>

<body>
  <table border="1">
        <tr>
            <td valign="top">
                <%-- -------- Include menu HTML code -------- --%>
                <jsp:include page="index.html" />
            </td>
            <td valign="top">
            <h1>Add Courses</h1>
						

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
                        
												boolean labworkReq = false;
												System.out.println(request.getParameter("LABWORK"));
												if( request.getParameter("LABWORK") != null ){
                          labworkReq = Boolean.parseBoolean(request.getParameter("LABWORK"));
                      
                        }

                        // Begin transaction
                        conn.setAutoCommit(false);
                        
                        // Create the prepared statement and use it to
                        // INSERT the student attributes INTO the Student table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "INSERT INTO Course VALUES ( ?, ?, ?, ?, ?, ? )");
                          
                       /* pstmt.setInt(1, Integer.parseInt(request.getParameter("ID")));*/
                        pstmt.setString(1, request.getParameter("NUM"));
                        pstmt.setString(2, request.getParameter("DEPT"));
												
                        pstmt.setInt(3, Integer.parseInt(request.getParameter("MIN_UNITS")));
                        pstmt.setInt(4, Integer.parseInt(request.getParameter("MAX_UNITS")));
                        pstmt.setString(5, request.getParameter("GRADE_TYPE").toUpperCase());
                        pstmt.setBoolean(6,labworkReq);
												
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
                            "UPDATE Course SET min_units = ?, max_units = ?, " +
                            "grade_type = UPPER(?), labwork_req = ? WHERE num = ?");

                        pstmt.setInt(1, Integer.parseInt(request.getParameter("MIN_UNITS")));
                        pstmt.setInt(2, Integer.parseInt(request.getParameter("MAX_UNITS")));
                        pstmt.setString(3, request.getParameter("GRADE_TYPE").toUpperCase());
                        pstmt.setBoolean(4, Boolean.parseBoolean(request.getParameter("LABWORK")));
												
                        pstmt.setString(5, request.getParameter("NUM"));
												

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

										/*		PreparedStatement pstmt = conn.prepareStatement(
                            "DELETE FROM NumChanges WHERE num_to= ?");

                        pstmt.setString(
                            1, request.getParameter("NUM"));
                        int rowCount = pstmt.executeUpdate();*/
                        
                        
                      /*
                       	pstmt = conn.prepareStatement(
                            "DELETE FROM Prereqs WHERE num= ? OR pre_num = ?");

                        pstmt.setString(
                            1, request.getParameter("NUM"));
												pstmt.setString(
                            2, request.getParameter("NUM"));
                        rowCount = pstmt.executeUpdate();

												
												pstmt = conn.prepareStatement(
                            "DELETE FROM Concentration WHERE num= ?");

                        pstmt.setString(
                            1, request.getParameter("NUM"));
                        rowCount = pstmt.executeUpdate();
*/


												PreparedStatement pstmt = conn.prepareStatement(
                            "DELETE FROM Course WHERE num= ?");

                        pstmt.setString(
                            1, request.getParameter("NUM"));
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
                        ("SELECT * FROM Course");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>NUM</th>
                        <th>DEPT</th>
		                  	<th>MIN_UNITS</th>
                        <th>MAX_UNITS</th>
                        <th>GRADE_TYPE</th> 
                        <th>LABWORK_REQ</th> 
                        <th>Action</th>
                    </tr>
										
                    <tr>
                        <form action="courses.jsp" method="get">
										
                            <input type="hidden" value="insert" name="action">
                            <th><input value="" name="NUM" size="10"></th>
                            <th><input value="" name="DEPT" size="10"></th>
														
			                      <th><input value="" name="MIN_UNITS" size="15"></th>
			                      <th><input value="" name="MAX_UNITS" size="15"></th>
	                          <td>
														    <select name="GRADE_TYPE">
														    <option value="L">Letter(L)</option>
														    <option value="S/U">S/U</option>
														    <option value="O">Optional(O)</option>
														    </select>
													  </td>

			                     <%-- <th><input value="" name="LABWORK" size="15"></th> --%>
														<td><input type="radio" name="LABWORK" value="true">Required?</td>
														<th><input type="submit" value="Insert"></th>
                        </form>
                    </tr>
							
																			


            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
        
                    while ( rs.next() ) {
        
            %>

                    <tr>
                        <form action="courses.jsp" method="get">
                            <input type="hidden" value="update" name="action">

                            <%-- Get the SSN, which is a number --%>
                            <td>
                                <input value="<%= rs.getString("num") %>" 
                                    name="NUM" size="10" readonly>
                            </td>

														 <td>
                                <input value="<%= rs.getString("dept") %>" 
                                    name="DEPT" size="10" readonly>
                            </td>

														
    
                            <%-- Get the ID --%>
                            <td>
                                <input value="<%= rs.getString("min_units") %>" 
                                    name="MIN_UNITS" size="10">
                            </td>
    
                            <%-- Get the FIRSTNAME --%>
                            <td>
                                <input value="<%= rs.getString("max_units") %>"
                                    name="MAX_UNITS" size="15">
                            </td>
    
                            <%-- Get the LASTNAME --%>
                            <td>
                                <input value="<%= rs.getString("grade_type") %>" 
                                    name="GRADE_TYPE" size="15">
                            </td>
    
			    <%-- Get the LASTNAME --%>
                            <td>
                                <input value="<%= rs.getBoolean("labwork_req") %>" 
                                    name="LABWORK" size="15">
                            </td>

														<%-- Button --%>
                            <td>
                                <input type="submit" value="Update">
                            </td>
                        </form>
                        <form action="courses.jsp" method="get">
                            <input type="hidden" value="delete" name="action">
                            <input type="hidden" 
                                value="<%= rs.getString("num") %>" name="NUM">
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
