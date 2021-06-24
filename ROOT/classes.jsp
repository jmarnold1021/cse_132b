<html>

<body>
  <table border="1">
        <tr>
            <td valign="top">
                <%-- -------- Include menu HTML code -------- --%>
                <jsp:include page="index.html" />
            </td>
            <td valign="top">
            <h1>Add Classes</h1>
						

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

												/*PreparedStatement get_beg;
												get_beg = conn.prepareStatement("select CURRENT_DATE + i as dt,dayy "+                                                                                                                                                 
                                                        "from (generate_series(DATE(?) - CURRENT_DATE, "+                                                                                                                                 
                                                        "DATE(?) - CURRENT_DATE ) i inner join day_conversion on Extract(DOW from (CURRENT_DATE+(i-1)))=day_val) where dayy='M';");
												ResultSet beg;
												String bd="";
												String ed="";
												String yr=request.getParameter("YEAR");
                        if(request.getParameter("QTR").equals("F")){
                             
														 
														 get_beg.setString(
                             1, yr+"-10-01");
														 get_beg.setString(
                             2, yr+"-10-08");
														 beg=get_beg.executeQuery();
														 while(beg.next()){
                              bd=beg.getString("dt");
														 }
														


												}
												else if(request.getParameter("QTR").equals("W")){
												     
														 
														get_beg.setString(
                             1, yr+"-01-01");
														 get_beg.setString(
                             2, yr+"-01-08");
														 beg=get_beg.executeQuery();
														 while(beg.next()){
                              bd=beg.getString("dt");
														 }
																														 

												}
												else if(request.getParameter("QTR").equals("S")){
												     System.out.println("hello");
														 
												     
														 get_beg.setString(
                             1, yr+"-03-26");
														 get_beg.setString(
                             2, yr+"-04-02");
														 beg=get_beg.executeQuery();
														 while(beg.next()){
                              bd=beg.getString("dt");
												     System.out.println(bd);
															
														 }
														  																 

																														 

												}

												get_beg = conn.prepareStatement("Select (date(?) + 69) as edt");
												get_beg.setString(
                             1, bd);
												beg=get_beg.executeQuery();
                        
												while(beg.next()){
                              ed=beg.getString("edt");
															System.out.println(ed + " new date");
												}*/		 
                        
                        // Create the prepared statement and use it to
                        // INSERT the student attributes INTO the Student table.
                       PreparedStatement pstmt = conn.prepareStatement(
                            "INSERT INTO Classes VALUES ( ?, ?, ?, ?, ?, DATE(?), DATE(?), ?)");
                          
												pstmt.setInt(
                            1, Integer.parseInt(request.getParameter("CLASS_ID")));	
                        pstmt.setString(
                            2, request.getParameter("NUM"));
                        pstmt.setString(
                            3, request.getParameter("TITLE"));														
												pstmt.setInt(
                            4, Integer.parseInt(request.getParameter("YEAR")));
                        pstmt.setString(
                            5, request.getParameter("QTR"));
												pstmt.setString(
                            6, "01-01-0001");
												pstmt.setString(
                            7, "01-01-0001");


											
                       
												
                        


											
												pstmt.setString(
                            7, request.getParameter("FACT"));
												
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
                            "UPDATE Classes SET num = ?, title=?, year = ?, qtr = UPPER(?), fac = ? WHERE class_id= ?"); 
                            


												pstmt.setInt(
                            6, Integer.parseInt(request.getParameter("CLASS_ID")));		

                        pstmt.setString(
                            1, request.getParameter("NUM"));
												pstmt.setString(
                            2, request.getParameter("TITLE"));		
											
												
											
												
                        pstmt.setInt(
                            3, Integer.parseInt(request.getParameter("YEAR")));
                        pstmt.setString(
                            4, request.getParameter("QTR"));
												pstmt.setString(
                            5, request.getParameter("FACT"));
												
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
                            "DELETE FROM Classes WHERE class_id= ?");

                        
													pstmt.setInt(
                            1, Integer.parseInt(request.getParameter("CLASS_ID")));

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
                        ("SELECT * FROM Classes");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>CLASS ID</th>
												<th>COURSE NUM</th>
												<th>TITLE</th>
												

												
		                  	<th>YEAR</th>
                        <th>QUARTER</th>
                        <th>START DATE</th>
                        <th>END DATE</th>
												
												<th>FACULTY</th>
												
												
                        <th>Action</th>
                    </tr>
										
                    <tr>
                        <form action="classes.jsp" method="get">
										
                            <input type="hidden" value="insert" name="action">
			                      <th><input value="" name="CLASS_ID" size="15"></th>
                            <th><input value="" name="NUM" size="10"></th>
                            <th><input value="" name="TITLE" size="30"></th>
														
														
			                      <th><input value="" name="YEAR" size="15"></th>
	                          <td>
														    <select name="QTR">
														    <option value="F">FALL(F)</option>
														    <option value="W">WINTER(W)</option>
														    <option value="S">SPRING(S)</option>
														    <option value="S1">SUMMER1(S1)</option>
														    <option value="S2">SUMMER2(S2)</option>
																</select>
                           </td>
			                      <th>------</th>
			                      <th>------</th>
														
													 
													  
														<th><input value="" name="FACT" size="30"></th>
														

														
														<th><input type="submit" value="Insert"></th>
                        </form>
                    </tr>
							
																			


            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
        
                    while ( rs.next() ) {
        
            %>

                    <tr>
                        <form action="classes.jsp" method="get">
                            <input type="hidden" value="update" name="action">

                            <%-- Get the SSN, which is a number --%>
                            
														<td>
                                <input value="<%= rs.getInt("class_id") %>"
                                    name="CLASS_ID" size="15" readonly>
                            </td>
														
														<td>
                                <input value="<%= rs.getString("num") %>" 
                                    name="NUM" size="10">
                            </td>
														<td>
                                <input value="<%= rs.getString("title") %>" 
                                    name="NUM" size="30">
                            </td>

														
    
                            <%-- Get the ID --%>
                            <td>
                                <input value="<%= rs.getInt("year") %>" 
                                    name="YEAR" size="10" >
                            </td>
    
                            <%-- Get the FIRSTNAME --%>
                            <td>
                                <input value="<%= rs.getString("qtr") %>"
                                    name="QTR" size="15" >
                            </td>
														<td>
                                <input value="<%= rs.getString("s_date") %>" 
                                    name="SDATE" size="10" >
                            </td>
    
                            <%-- Get the FIRSTNAME --%>
                            <td>
                                <input value="<%= rs.getString("e_date") %>"
                                    name="EDATE" size="15" >
                            </td>
													

														<td>
                                <input value="<%= rs.getString("fac") %>" 
                                    name="FACT" size="30">
                            </td>


												    
                   					<%-- Button --%>
                            <td>
                                <input type="submit" value="Update">
                            </td>
                        </form>
                        <form action="classes.jsp" method="get">
                            <input type="hidden" value="delete" name="action">
														
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
