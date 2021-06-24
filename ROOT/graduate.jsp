<html>

<body>
  <table border="1">
        <tr>
            <td valign="top">
                <%-- -------- Include menu HTML code -------- --%>
                <jsp:include page="index.html" />
            </td>
            <td valign="top">
            <h1>Add Graduates</h1>
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
                            "INSERT INTO Graduate VALUES ( ?, ?, ?, ?, ?, ?, ?, ?, ? )");

                        pstmt.setInt(1, Integer.parseInt(request.getParameter("ID")));
                        pstmt.setString(2, request.getParameter("DEPT"));
												pstmt.setString(3, request.getParameter("STATUS"));
                        pstmt.setBoolean(4, Boolean.parseBoolean(request.getParameter("CAND")));
												pstmt.setString(5, request.getParameter("ADV"));
												pstmt.setString(6, request.getParameter("FACT1"));
												pstmt.setString(7, request.getParameter("FACT2"));
												pstmt.setString(8, request.getParameter("FACT3"));
												pstmt.setString(9, request.getParameter("OFACT"));
												
												
                     
												
																								
                        int rowCount = pstmt.executeUpdate();

                        // Commit transaction
                        conn.commit();
                        conn.setAutoCommit(true);
                    }
            %>

            <%-- -------- UPDATE Code -------- --%>
            <%
                    // Check if an update is requested
                    if (request.getParameter("UPD") != null && request.getParameter("UPD").equals("Update")) {

                        // Begin transaction
                        conn.setAutoCommit(false);
                        
                        // Create the prepared statement and use it to
                        // UPDATE the student attributes in the Student table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "UPDATE Graduate SET dept = ?, status = UPPER(?), " +
                            "candidate = ?, advisor=?,fac1=?,fac2=?,fac3=?,o_fac=? WHERE id = ?");

                        pstmt.setInt(9, Integer.parseInt(request.getParameter("ID")));
                        pstmt.setString(1, request.getParameter("DEPT"));
												pstmt.setString(2, request.getParameter("STATUS"));
                        pstmt.setBoolean(3, Boolean.parseBoolean(request.getParameter("CAND")));
												pstmt.setString(4, request.getParameter("ADV"));
												pstmt.setString(5, request.getParameter("FACT1"));
												pstmt.setString(6, request.getParameter("FACT2"));
												pstmt.setString(7, request.getParameter("FACT3"));
												pstmt.setString(8, request.getParameter("OFACT"));
												


                        int rowCount = pstmt.executeUpdate();

                        // Commit transaction
                         conn.commit();
                        conn.setAutoCommit(true);
                    }
            %>

            <%-- -------- DELETE Code -------- --%>
            <%
                    // Check if a delete is requested
                    if (request.getParameter("DEL") != null && request.getParameter("DEL").equals("Delete")) {

                        // Begin transaction
                        conn.setAutoCommit(false);
                        
                        // Create the prepared statement and use it to
                        // DELETE the student FROM the Student table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "DELETE FROM Graduate WHERE id = ?");

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
                        ("SELECT * FROM Graduate");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>ID</th>
                        <th>DEPT</th> 
                        <th>&nbsp;&nbsp;STATUS&nbsp;&nbsp;</th> 
                        <th>&nbsp;&nbsp;CANDIDATE?&nbsp;&nbsp;</th>
                        <th>ADVISOR</th> 
												
                        <th>Action</th>
                    </tr>
                   
									  <form action="graduate.jsp" method="get">
                            <input type="hidden" value="insert" name="action">
                    <tr>
                       
                            <th><input value="" name="ID" size="10"></th> 
														<th><input value="" name="DEPT" size="15"></th>
														
                            <td>
														  <center>
														
														    <input type="radio" name="STATUS" value="M/S" checked="checked">M/S<BR>
														    <input type="radio" name="STATUS" value="PHD">PDH
														  </center>
																
														</td>
														<td>
														  <center>
														  <input type="radio" name="CAND" value="true">T
														  <input type="radio" name="CAND" value="false" checked="checked">F
															</center>
														</td>
                            <th><input value="" name="ADV" size="30"></th> 
														
                            <th><input type="submit" value="Insert"></th>
														
														
														
														
                    </tr>
										<tr>
                        <th>FACULTY 1</th>
                        <th>FACULTY 2</th>

                        <th>FACULTY 3</th>

                        <th>OUTSIDE FACULTY</th>
												
                        
                    </tr>
										<tr>
                       
                            <th><input value="" name="FACT1" size="30"></th> 
														<th><input value="" name="FACT2" size="30"></th>
														<th><input value="" name="FACT3" size="30"></th>
														<th><input value="" name="OFACT" size="30"></th>
														
                            														
														
														
														
                    </tr>






										 </form>


            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
        
                    while ( rs.next() ) {
        
            %>
						       
									  	<tr>
														<th></th>
														<th></th>
														<th></th>
														<th></th>
														<th></th>
														<th></th>
										</tr>
                   	<tr>
														<th></th>
														<th></th>
														<th></th>
														<th></th>
														<th></th>
														<th></th>
										</tr>
                    <form action="graduate.jsp" method="get">
                        <input type="hidden" value="Update" name="action">
                    <tr>
                       

                            <%-- Get the SSN, which is a number --%>
                            <td>
                                <input value="<%= rs.getInt("id") %>" 
                                    name="ID" size="10" readonly>																
														</td>
														
    
                            <%-- Get the ID --%>
                            <td>
                                <input value="<%= rs.getString("dept") %>" 
                                    name="DEPT" size="10" readonly>
                            </td>
    
                            <%-- Get the FIRSTNAME --%>
                            <td>
                                <input value="<%= rs.getString("status") %>"
                                    name="STATUS" size="15">
                            </td>
    
                            <%-- Get the LASTNAME --%>
                            <td>
                                <input value="<%= rs.getBoolean("candidate") %>" 
                                    name="CAND" size="15">
                            </td>
														<td>
														   <input value="<%= rs.getString("advisor") %>"
                                    name="ADV" size="30">

														</td>
														 <td>
                                <input type="submit" value="Update" name="UPD">
                            </td>

    								</tr>
                    <tr>




	                          <td>
														   <input value="<%= rs.getString("fac1") %>"
                                    name="FACT1" size="30">

														</td>
	                          <td>
														   <input value="<%= rs.getString("fac2") %>"
                                    name="FACT2" size="30">

														</td>
	                          <td>
														   <input value="<%= rs.getString("fac3") %>"
                                    name="FACT3" size="30">	
														</td>
																		
														<td>
														   <input value="<%= rs.getString("o_fac") %>"
                                    name="OFACT" size="30">

														</td>	
														<td></td>

														
														
														
													


                            <%-- Button --%>
                                                   <%-- </form>
                        <form action="graduate.jsp" method="get">
                            <input type="hidden" value="delete" name="action">
                            <input type="hidden" 
                                value="<%= rs.getInt("id") %>" name="ID">--%>
                            <%-- Button --%>
                            <td>
                                <input type="submit" value="Delete" name="DEL">
                            </td>
                        <%--</form>--%>
                    </tr>
										</form>







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
