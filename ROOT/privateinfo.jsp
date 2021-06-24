<html>

<body>
  <table border="1">
        <tr>
            <td valign="top">
                <%-- -------- Include menu HTML code -------- --%>
                <jsp:include page="index.html" />
            </td>
            <td valign="top">
            <h1>Add PrivateInfo</h1>
						

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
                            "INSERT INTO PrivateInfo VALUES ( ?, ?,?, ?, ?, ?, ?, DATE(?), ?, ?, ? )");

                        pstmt.setInt(1, Integer.parseInt(request.getParameter("ID")));
                        pstmt.setString(2, request.getParameter("SSN"));
                        pstmt.setString(3, request.getParameter("RES"));
												
												pstmt.setString(4, request.getParameter("ADDRESS"));
                        pstmt.setString(5, request.getParameter("CITY"));
                        pstmt.setString(6, request.getParameter("STATE"));
                        pstmt.setInt(7, Integer.parseInt(request.getParameter("ZIP")));
                        pstmt.setString(8, request.getParameter("DOB"));
                        pstmt.setString(9, request.getParameter("EMAIL"));
                        pstmt.setString(10, request.getParameter("PHN_NUM"));
                        pstmt.setString(11, request.getParameter("GENDER"));
												
																								
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
                            "UPDATE PrivateInfo SET ssn = ?, res=?, address = ?, " +
                            "city = ?, state = ?, zip= ?, dob= DATE(?), email = ?, phn_num = ?,gender= ? WHERE id = ?");

                        pstmt.setInt(11, Integer.parseInt(request.getParameter("ID")));
                        pstmt.setString(1, request.getParameter("SSN"));
                        pstmt.setString(2, request.getParameter("RES"));
												
												pstmt.setString(3, request.getParameter("ADDRESS"));
                        pstmt.setString(4, request.getParameter("CITY"));
                        pstmt.setString(5, request.getParameter("STATE"));
                        pstmt.setInt(6, Integer.parseInt(request.getParameter("ZIP")));
                        pstmt.setString(7, request.getParameter("DOB"));
                        pstmt.setString(8, request.getParameter("EMAIL"));
                        pstmt.setString(9, request.getParameter("PHN_NUM"));
                        pstmt.setString(10, request.getParameter("GENDER"));

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
                            "DELETE FROM PrivateInfo WHERE id = ?");

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
                        ("SELECT * FROM PrivateInfo");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>ID</th>
                        <th>SSN</th>
												<th>RESIDENCY</th>
                        <th>ADDRESS</th>
		                  	<th>CITY</th>
                        <th>STATE</th>
                        <th>ZIP</th> 
                        <th>DOB</th> 
                        <th>EMAIL</th> 
                        <th>PHN_NUM</th> 
                        <th>&nbsp;&nbsp;GENDER&nbsp;&nbsp;</th> 
                        <th>Action</th>
                    </tr>
                    <tr>
                        <form action="privateinfo.jsp" method="get">
                            <input type="hidden" value="insert" name="action">
                            <th><input value="" name="ID" size="10"></th> 
                            <th><input value="" name="SSN" size="10"></th>
														<td>
														    <select name="RES">
														     <option value="CA">California Resident</option>
														     <option value="NCA">non-CA US Resident</option>
														     <option value="FS">Foreign Student</option>
														   															

																
																</select>
                           </td>


                            <th><input value="" name="ADDRESS" size="15"></th>
			                      <th><input value="" name="CITY" size="15"></th>
                            <th><input value="" name="STATE" size="15"></th>
                            <th><input value="" name="ZIP" size="15"></th>
                            <th><input type="date" value="" name="DOB" size="15"></th>
														<th><input value="" name="EMAIL" size="15"></th>
														<th><input value="" name="PHN_NUM" size="15"></th>
														<td>
														    <select name="GENDER">
														     <option value="M">MALE(M)</option>
														     <option value="F">FEMALE(F)</option>
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
                        <form action="privateinfo.jsp" method="get">
                            <input type="hidden" value="update" name="action">

                            <%-- Get the SSN, which is a number --%>
                            <td>
                                <input value="<%= rs.getInt("id") %>" 
                                    name="ID" size="10" readonly>																
														</td>
														
    
                            <%-- Get the ID --%>
                            <td>
                                <input value="<%= rs.getString("ssn") %>" 
                                    name="SSN" size="10">
                            </td>
														 <td>
                                <input value="<%= rs.getString("res") %>" 
                                    name="RES" size="10">
                            </td>

    
                            <%-- Get the FIRSTNAME --%>
                            <td>
                                <input value="<%= rs.getString("address") %>"
                                    name="ADDRESS" size="15">
                            </td>
    
                            <%-- Get the LASTNAME --%>
                            <td>
                                <input value="<%= rs.getString("city") %>" 
                                    name="CITY" size="15">
                            </td>
    
			    <%-- Get the LASTNAME --%>
                            <td>
                                <input value="<%= rs.getString("state") %>" 
                                    name="STATE" size="15">
                            </td>

														
                            <%-- Get the COLLEGE --%>

                            <td>
                                <input value="<%= rs.getInt("zip") %>" 
                                    name="ZIP" size="15">
                            </td>
														<td>
                                <input value="<%= rs.getString("dob") %>" 
                                    name="DOB" size="15">
                            </td>
														<td>
                                <input value="<%= rs.getString("email") %>" 
                                    name="EMAIL" size="15">
                            </td>
														<td>
                                <input value="<%= rs.getString("phn_num") %>" 
                                    name="PHN_NUM" size="15">
                            </td>
															<td>
                                <input value="<%= rs.getString("gender") %>" 
                                    name="GENDER" size="15">
                            </td>

														
    
                            <%-- Button --%>
                            <td>
                                <input type="submit" value="Update">
                            </td>
                        </form>
                        <form action="privateinfo.jsp" method="get">
                            <input type="hidden" value="delete" name="action">
                            <input type="hidden" 
                                value="<%= rs.getInt("id") %>" name="ID">
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
