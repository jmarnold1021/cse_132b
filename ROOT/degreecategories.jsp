<html>

<body>
  <table border="1">
        <tr>
            <td valign="top">
                <%-- -------- Include menu HTML code -------- --%>
                <jsp:include page="index.html" />
            </td>
            <td valign="top">
            <h1>Add Degree Categories</h1>
						

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
                            "INSERT INTO DegreeCategories VALUES (?, ?, ?, ?, ?)");

                        pstmt.setString(1, request.getParameter("NAME"));
												pstmt.setString(2, request.getParameter("DEG_TYPE"));
                        pstmt.setString(3, request.getParameter("CAT_TYPE"));
                        pstmt.setInt(4, Integer.parseInt(request.getParameter("UNITS")));
												
                        pstmt.setFloat(5, Float.parseFloat(request.getParameter("CGPA")));
												
                       												
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
                            "UPDATE DegreeCategories SET avg_cat_gpa = ?, " +
                            "req_units = ? WHERE name = ? AND deg_type = ? AND cat_type=?");

												pstmt.setFloat(1, Float.parseFloat(request.getParameter("CGPA")));
                        pstmt.setInt(2, Integer.parseInt(request.getParameter("UNITS")));
												
                        pstmt.setString(3, request.getParameter("NAME"));
                        pstmt.setString(4, request.getParameter("DEG_TYPE"));
                        pstmt.setString(5, request.getParameter("CAT_TYPE"));
												

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
                            "DELETE FROM DegreeCategories where name = ? AND deg_type = ? and cat_type=?");

                        pstmt.setString(
                            1, request.getParameter("NAME"));
												pstmt.setString(
                            2, request.getParameter("DEG_TYPE"));
												pstmt.setString(
                            3, request.getParameter("CAT_TYPE"));		
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
                        ("SELECT * FROM DegreeCategories");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>DEGREE</th>
                        <th>TYPE</th>
                        <th>CATEGORY</th>
		                  	<th>REQ CAT GPA</th>
                        <th>REQ CAT UNITS</th>
                        <th>Action</th>
                    </tr>
                    <tr>
                        <form action="degreecategories.jsp" method="get">
                            <input type="hidden" value="insert" name="action">
                            <th><input value="" name="NAME" size="30"></th> 
                             <td>
														    <select name="DEG_TYPE">
														    <option value="B.A.">B.A.</option>
														    <option value="B.S.">B.S.</option>
														  
																
																

																
																</select>
                           </td>

			                      <th><input value="" name="CAT_TYPE" size="15"></th>

			                      <th><input value="" name="CGPA" size="15"></th>
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
                        <form action="degreecategories.jsp" method="get">
                            <input type="hidden" value="update" name="action">

                            <%-- Get the SSN, which is a number --%>
                            <td>
                                <input value="<%= rs.getString("name") %>" 
                                    name="NAME" size="30" readonly>																
														</td>
														
    
                            <%-- Get the ID --%>
                            <td>
                                <input value="<%= rs.getString("deg_type") %>" 
                                    name="DEG_TYPE" size="10" readonly>
                            </td>
    
                            <%-- Get the FIRSTNAME --%>
                            <td>
                                <input value="<%= rs.getString("cat_type") %>"
                                    name="CAT_TYPE" size="20" readonly>
                            </td>
    
                            <%-- Get the LASTNAME --%>
                            <td>
                                <input value="<%= rs.getFloat("avg_cat_gpa") %>" 
                                    name="CGPA" size="15">
                            </td>
    
			    <%-- Get the LASTNAME --%>
                            <td>
                                <input value="<%= rs.getString("req_units") %>" 
                                    name="UNITS" size="15">
                            </td>

														    
                            <%-- Button --%>
                            <td>
                                <input type="submit" value="Update">
                            </td>
                        </form>
                        <form action="degreecategories.jsp" method="get">
                            <input type="hidden" value="delete" name="action">
                            <input type="hidden" 
                                value="<%= rs.getString("name") %>" name="NAME">
														 <input type="hidden" 
                                value="<%= rs.getString("deg_type") %>" name="DEG_TYPE">
														<input type="hidden" 
                                value="<%= rs.getString("cat_type") %>" name="CAT_TYPE">


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
