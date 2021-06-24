<html>

<body>
  <table border="1">
        <tr>
            <td valign="top">
                <%-- -------- Include menu HTML code -------- --%>
                <jsp:include page="index.html" />
            </td>
            <td valign="top">
            <h1>Add Faculty</h1>
						

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
                            "INSERT INTO Faculty VALUES (?, ?, ?)");

                        pstmt.setString(1, request.getParameter("NAME"));
												pstmt.setString(2, request.getParameter("TITLE"));
                        pstmt.setString(3, request.getParameter("DEPT"));
                       
												
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
                            "UPDATE Faculty SET title = ?, dept = ? " +
                            "WHERE name = ?");

                        pstmt.setString(3, request.getParameter("NAME"));
                        pstmt.setString(1, request.getParameter("TITLE"));
												pstmt.setString(2, request.getParameter("DEPT"));

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
                            "DELETE FROM Faculty WHERE name = ?");

                        pstmt.setString(
                            1, request.getParameter("NAME"));
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
                        ("SELECT * FROM Faculty");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>NAME</th>
                        <th>TITLE</th>
                        <th>DEPT</th>
		                  	
                        <th>Action</th>
                    </tr>
                    <tr>
                        <form action="faculty.jsp" method="get">
                            <input type="hidden" value="insert" name="action">
                            <th><input value="" name="NAME" size="30"></th>
                            <th>
                              <select name="TITLE">
                              <option value="L">Lecturer(L)</option>
                              <option value="ASP">Assistant Professor(ASP)</option>
                              <option value="ACP">Associate Professor(ACP)</option>
                              <option value="P">Professor(P)</option>
															</select>
														
														</th>
			                      <th><input value="" name="DEPT" size="15"></th>
                            <th><input type="submit" value="Insert"></th>
														
                       </form>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
        
                    while ( rs.next() ) {
        
            %>

                    <tr>
                        <form action="faculty.jsp" method="get">
                            <input type="hidden" value="update" name="action">

                            <%-- Get the SSN, which is a number --%>
                            <td>
                                <input value="<%= rs.getString("name") %>" 
                                    name="NAME" size="30" readonly>																
														</td>
														
    
                            <%-- Get the ID --%>
                            <td>
                                <input value="<%= rs.getString("title") %>" 
                                    name="TITLE" size="10">
                            </td>
    
                            <%-- Get the FIRSTNAME --%>
                            <td>
                                <input value="<%= rs.getString("dept") %>"
                                    name="DEPT" size="15">
                            </td>
    
                           

														
    
                            <%-- Button --%>
                            <td>
                                <input type="submit" value="Update">
                            </td>
                        </form>
                        <form action="faculty.jsp" method="get">
                            <input type="hidden" value="delete" name="action">
                            <input type="hidden" 
                                value="<%= rs.getString("name") %>" name="NAME">
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
