<html>

<body>
  <table border="1">
        <tr>
            <td valign="top">
                <%-- -------- Include menu HTML code -------- --%>
                <jsp:include page="index.html" />
            </td>
            <td valign="top">
            <h1>Add Degrees</h1>
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
                            "INSERT INTO DegreeReqs VALUES (?, 'UCSD', ?, ?, ?, ?, ?)");

                        pstmt.setString(1, request.getParameter("NAME"));
												
												pstmt.setString(2, request.getParameter("DEG_TYPE"));
                        pstmt.setString(3, request.getParameter("DEPT"));
                        pstmt.setFloat(4, Float.parseFloat(request.getParameter("UCGPA")));
                        pstmt.setString(5, request.getParameter("CONC"));
                        pstmt.setInt(6, Integer.parseInt(request.getParameter("UNITS")));
												
                       												
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
                            "UPDATE DegreeReqs SET dept = ?, avg_uc_gpa = ?, " +
                            "req_conc = ?, total_units = ? WHERE name = ? AND deg_type = ?");

                        pstmt.setString(1, request.getParameter("DEPT"));
												pstmt.setFloat(2, Float.parseFloat(request.getParameter("UCGPA")));
                        pstmt.setString(3, request.getParameter("CONC"));
                        pstmt.setInt(4, Integer.parseInt(request.getParameter("UNITS")));
												
                        pstmt.setString(5, request.getParameter("NAME"));
                        pstmt.setString(6, request.getParameter("DEG_TYPE"));
												

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
                            "DELETE FROM Degreereqs where name = ? AND deg_type = ?");

                        pstmt.setString(
                            1, request.getParameter("NAME"));
												pstmt.setString(
                            2, request.getParameter("DEG_TYPE"));
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
                        ("SELECT * FROM DegreeReqs");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>DEGREE</th>
												<th>UNIVERSITY</th>
                        <th>TYPE</th>
                        <th>DEPT</th>
		                  	<th>REQ UC GPA</th>
                        <th>REQ CONCENTRATION</th>
                        <th>REQ UNITS</th> 
                        <th>Action</th>
                    </tr>
                    <tr>
                        <form action="degreereqs.jsp" method="get">
                            <input type="hidden" value="insert" name="action">
                            <th><input value="" name="NAME" size="30"></th>
                            <th>UCSD</th> 
														
                             <td>
														    <select name="DEG_TYPE">
														     <option value="A.A.">A.A.</option>
														     <option value="A.S.">A.S.</option>
														     <option value="B.A.">B.A.</option>
														    <option value="B.S.">B.S.</option>
														    <option value="M.A.">M.A.</option>
														    <option value="M.S.">M.S.</option>
														    <option value="M.D.">M.D.</option>
														    <option value="PH.D.">PH.D.</option>
																
																

																
																</select>
                           </td>


                            <th><input value="" name="DEPT" size="15"></th>
			                      <th><input value="" name="UCGPA" size="15"></th>
                            <th><input value="N/A" name="CONC" size="15"></th>
                            <th><input value="" name="UNITS" size="15"></th>
                            <th><input type="submit" value="Insert"></th>
                        </form>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
        
                    while ( rs.next() ) {
        
            %>

                    <tr>
                        <form action="degreereqs.jsp" method="get">
                            <input type="hidden" value="update" name="action">

                            <%-- Get the SSN, which is a number --%>
                            <td>
                                <input value="<%= rs.getString("name") %>" 
                                    name="NAME" size="30" readonly>																
														</td>
														<td>
                                <input value="<%= rs.getString("university") %>" 
                                    name="UV" size="10" readonly>																
														</td>
    
                            <%-- Get the ID --%>
                            <td>
                                <input value="<%= rs.getString("deg_type") %>" 
                                    name="DEG_TYPE" size="10" readonly>
                            </td>
    
                            <%-- Get the FIRSTNAME --%>
                            <td>
                                <input value="<%= rs.getString("dept") %>"
                                    name="DEPT" size="15">
                            </td>
    
                            <%-- Get the LASTNAME --%>
                            <td>
                                <input value="<%= rs.getFloat("avg_uc_gpa") %>" 
                                    name="UCGPA" size="15">
                            </td>
    
			    <%-- Get the LASTNAME --%>
                            <td>
                                <input value="<%= rs.getString("req_conc") %>" 
                                    name="CONC" size="15">
                            </td>

														
                            <%-- Get the COLLEGE --%>

                            <td>
                                <input value="<%= rs.getString("total_units") %>" 
                                    name="UNITS" size="15">
                            </td>

														
    
                            <%-- Button --%>
                            <td>
                                <input type="submit" value="Update">
                            </td>
                        </form>
                        <form action="degreereqs.jsp" method="get">
                            <input type="hidden" value="delete" name="action">
                            <input type="hidden" 
                                value="<%= rs.getString("name") %>" name="NAME">
														 <input type="hidden" 
                                value="<%= rs.getString("deg_type") %>" name="DEG_TYPE">

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
