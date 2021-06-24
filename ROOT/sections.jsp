<html>

<body>
  <table border="1">
        <tr>
            <td valign="top">
                <%-- -------- Include menu HTML code -------- --%>
                <jsp:include page="index.html" />
            </td>
            <td valign="top">
            <h1>Add Sections</h1>
						

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
                            "INSERT INTO Section VALUES ( ?, ?, DATE(?), ?, ?, ?, ?, ?, ?, ?, ?, ?)");
                          
                      pstmt.setInt(
                              1, Integer.parseInt(request.getParameter("ID")));
												pstmt.setString(
                            2, request.getParameter("SECT_TYPE"));
                        
                         
												pstmt.setString(
                              3, request.getParameter("REV_DATE"));
                        
												
											  
												pstmt.setBoolean(
                              4, Boolean.parseBoolean(request.getParameter("DIS_MAND")));

                        //has to be filled
												if(request.getParameter("SECT_TYPE").equals("RE")){
												     PreparedStatement get_day=conn.prepareStatement("Select dayy from Extract(DOW from Date(?)) as p join day_conversion on p=day_val");
												  	get_day.setString(
                              1, request.getParameter("REV_DATE"));
													  ResultSet ress = get_day.executeQuery();
                            String dayofw="";
														while(ress.next()){
                              dayofw=ress.getString("dayy");
														}
                            pstmt.setString(
                             5, dayofw);
														ress.close();
                            get_day.close();
															
												  
												}
												else{
									        pstmt.setString(
                             5, request.getParameter("DAY1"));
                        }
                        
												 if(request.getParameter("DAY2") == null){

                          pstmt.setString(
                              6, "N/A");

												}
												else{
                      	  pstmt.setString(
                              6, request.getParameter("DAY2"));
                        }

												if(request.getParameter("DAY3") == null){

                          pstmt.setString(
                              7, "N/A");

												}
												else{
                      	  pstmt.setString(
                              7, request.getParameter("DAY3"));
                        }
												
												 pstmt.setTime(
                              8, Time.valueOf(request.getParameter("ST")));
                        
                          pstmt.setTime(
                              9, Time.valueOf(request.getParameter("ET")));

												  pstmt.setString(
                              10, request.getParameter("BLDG"));

													pstmt.setString(
                              11, request.getParameter("ROOM"));

													pstmt.setInt(
                              12, Integer.parseInt(request.getParameter("SIZE")));		

                        
												/*
												if(request.getParameter("ST1")==null){
												
                           pstmt.setNull(
                               7, java.sql.Types.TIME);
												}
												else{
												
                           String[] parts = request.getParameter("ST1").split(":");
												   pstmt.setTime(
                               7, new Time( Integer.parseInt(parts[0]), Integer.parseInt(parts[1]), Integer.parseInt(parts[2]) ));
                        }
											  if(request.getParameter("ET1")==null){
												
                           pstmt.setNull(
													    8, java.sql.Types.TIME);
                        }
												else{
                       	  pstmt.setTime(
                              8, Time.valueOf(request.getParameter("ET1")));
                        }
                        */





                       
                 
	                       												




                        /*


                        if(request.getParameter("DAY3")==null){

												pstmt.setNull(
													    12, java.sql.Types.VARCHAR);
												}
                        else{
												pstmt.setString(
                            12, request.getParameter("DAY3"));
                        }
												if(request.getParameter("ST3")==null){

												  pstmt.setNull(
													    13, java.sql.Types.TIME);
												}
												else{
                      	pstmt.setTime(
                            13, Time.valueOf(request.getParameter("ST3")));
												}
												if(request.getParameter("ET3")==null){
											  	pstmt.setNull(
													    14, java.sql.Types.TIME);
												}
                        else{
												  pstmt.setTime(
                            14, Time.valueOf(request.getParameter("ET3")));
												}		
                        

												if(request.getParameter("DIS_MAND")==null){

												  pstmt.setNull(
													    15, java.sql.Types.BOOLEAN);
												}
                        else{
                      	  pstmt.setBoolean(
                              15, Boolean.parseBoolean(request.getParameter("DIS_MAND")));
												}


	                     */
		

														
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
                            "UPDATE Section SET sect_type = UPPER(?), rev_date = DATE(?), mand_dis= ?, " +
                            "day1=UPPER(?),day2=UPPER(?),day3=UPPER(?), start_time=?, end_time=?,building=?,"+
														"room=?,class_size=? WHERE id = ?");

                        pstmt.setInt(
                            12, Integer.parseInt(request.getParameter("ID")));
												pstmt.setString(
                            1, request.getParameter("SECT_TYPE"));
												pstmt.setString(
                            2, request.getParameter("REV_DATE"));

                        pstmt.setBoolean(
                            3, Boolean.parseBoolean(request.getParameter("DIS_MAND")));
												pstmt.setString(
                            4, request.getParameter("DAY1"));
												pstmt.setString(
                            5, request.getParameter("DAY2"));
												pstmt.setString(
                            6, request.getParameter("DAY3"));
												pstmt.setTime(
                              7, Time.valueOf(request.getParameter("ST")));
                        
                        pstmt.setTime(
                              8, Time.valueOf(request.getParameter("ET")));
											  pstmt.setString(
                              9, request.getParameter("BLDG"));

											  pstmt.setString(
                              10, request.getParameter("ROOM"));

												pstmt.setInt(
                              11, Integer.parseInt(request.getParameter("SIZE")));
												

                        int rowCount = pstmt.executeUpdate();

                        // Commit transaction
                         conn.commit();
                        conn.setAutoCommit(true);
                    }
            %>

            <%-- -------- DELETE Code -------- --%>
            <%
                    // Check if a delete is requested
                    if ( (request.getParameter("DEL") != null) && (request.getParameter("DEL").equals("Delete")) ) {

                        // Begin transaction
                        conn.setAutoCommit(false);
                        
                        // Create the prepared statement and use it to
                        // DELETE the student FROM the Student table.
											

											 PreparedStatement pstmt = conn.prepareStatement(
                            "DELETE FROM Section WHERE id= ? AND sect_type = ? AND building =? AND room = ?"+ 
														"AND day1=? AND day2 = ?  AND day3=? AND rev_date = DATE(?)");

                        
											 pstmt.setInt(
                            1, Integer.parseInt(request.getParameter("ID")));
											 pstmt.setString(
                            2, request.getParameter("SECT_TYPE"));
												pstmt.setString(
                            8, request.getParameter("REV_DATE"));
												pstmt.setString(
                            5, request.getParameter("DAY1"));
												pstmt.setString(
                            6, request.getParameter("DAY2"));
												pstmt.setString(
                            7, request.getParameter("DAY3"));
												//pstmt.setTime(
                        //      9, Time.valueOf(request.getParameter("ST")));
                        
                       // pstmt.setTime(
                       //       10, Time.valueOf(request.getParameter("ET")));
											  pstmt.setString(
                              3, request.getParameter("BLDG"));

											  pstmt.setString(
                              4, request.getParameter("ROOM"));

										                       

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
                        ("SELECT * FROM Section ORDER BY id ASC");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>CLASS_ID</th>
                        <th>BUILDING</th>
												
		                  	<th>ROOM</th>
                        <th>CLASS SIZE</th>
                        <th></th>
                        <th>Action</th>


												

												
                    </tr>
										<form action="sections.jsp" method="get">
										
                    <input type="hidden" value="insert" name="action">
                    <tr>
                        
                            <th><input value="" name="ID" size="10"></th>
										      <th><input value="" name="BLDG" size="15"></th>

														
										      <th><input value="" name="ROOM" size="15"></th>
										      <th><input value="" name="SIZE" size="15"></th>
                           														
														<th></th>


									          <th><input type="submit" value="Insert"></th>
														
														
														
														
			                     
			                     
                    </tr>
										<tr>
														<th></th>

														<th>REVIEW DATE(opt)</th>
														
														<th>START TIME</th>
														
														<th>END TIME</th>
														<th></th>
														
														
										
										</tr>

										<tr>
														<th></th>
										
										        <th><input value="01-01-0001" name="REV_DATE" size="15"></th>
										
	                         			<th><input value="" name="ST" size="10"></th>
													
										        <th><input value="" name="ET" size="10"></th>
														<th></th>
													
													
													
                    

                    </tr>
										 <tr>
                        <th>SECT TYPE</th>
										 
                        <th>MANDITORY_DIS</th>
												
		                  	<th>DAY 1</th>
                        <th>DAY 2</th>
                        <th>DAY 3</th>
                        


												

												
                    </tr>
                    <tr>
														<td>
														    <select name="SECT_TYPE">
														    <option  value="LA">LA</option>
														    <option  value="LE">LE</option>
														    <option  value="DI">DI</option>
														    <option  value="RE">RE</option>
																</select>
 
																
																
														</td>
														 <td>
														    <input type="radio" name="DIS_MAND" value="true">T<br>
													    	<input type="radio" name="DIS_MAND" checked="checked" value="false">F
														</td>
														
													



														 <td>
														    																
																<select name=DAY1>
														    <option  value="N/A">N/A</option>
																
																<option  value="M">Monday(M)</option>
														    <option  value="TU">Tuesday(TU)</option>
														    <option  value="W">Wednesday(W)</option>
														    <option  value="TH">Thursday(TH)</option>
														    <option  value="F">Friday(F)</option>
														    <option  value="SAT">Saturday(SAT)</option>
														    <option  value="SUN">Sunday(SUN)</option>
															
																</select>

																
																
																
                           </td>
                            <td>
														   <select name=DAY2>
														    <option value="N/A">N/A</option>
															 
																<option  value="M">Monday(M)</option>
														    <option  value="TU">Tuesday(TU)</option>
														    <option  value="W">Wednesday(W)</option>
														    <option  value="TH">Thursday(TH)</option>
														    <option  value="F">Friday(F)</option>
														    <option  value="SAT">Saturday(SAT)</option>
														    <option  value="SUN">Sunday(SUN)</option>
															
																</select>
																
																
                           </td>
                            <td>
														    <select name=DAY3>
														    <option name="DAY3" value="N/A">N/A</option>
																
																<option  value="M">Monday(M)</option>
														    <option  value="TU">Tuesday(TU)</option>
														    <option  value="W">Wednesday(W)</option>
														    <option  value="TH">Thursday(TH)</option>
														    <option  value="F">Friday(F)</option>
														    <option  value="SAT">Saturday(SAT)</option>
														    <option  value="SUN">Sunday(SUN)</option>
																
															
																</select>
																
																
                           </td>

										        
														

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

										 <form action="sections.jsp" method="get">
                            <input type="hidden" value="update" name="action">
														
                    <tr>
                       

                            <%-- Get the SSN, which is a number --%>
                            <td>
                                <input value="<%= rs.getInt("id") %>" 
                                    name="ID" size="10" readonly>
                            </td>
														
    
                            <%-- Get the ID --%>
                            <td>
                                <input value="<%= rs.getString("building") %>" 
                                    name="BLDG" size="10" readonly>
                            </td>
    
                            <%-- Get the FIRSTNAME --%>
                            <td>
                                <input value="<%= rs.getString("room") %>"
                                    name="ROOM" size="15" readonly>
                            </td>
														 <td>
                                <input value="<%= rs.getInt("class_size") %>"
                                    name="SIZE" size="15"readonly>
                            </td>
														<th></th>
														
                     </tr>


                    
										 <tr>
														<th></th>
										 
                           <td>
											
                            <input value="<%= rs.getString("rev_date") %>" 
                                    name="REV_DATE" size="10" readonly>
                            </td>
    
                            <%-- Get the FIRSTNAME --%>
                            <td>
                                <input value="<%= rs.getTime("start_time") %>"
                                    name="ST" size="15" readonly>
                            </td>
														 <td>
                                <input value="<%= rs.getTime("end_time") %>"
                                    name="ET" size="15" readonly>
                            </td>
														<th></th>
														





										 </tr>



                     

										 <tr>
                            <%-- Button --%>


                             <td>
                                <input value="<%= rs.getString("sect_type") %>" 
                                    name="SECT_TYPE" size="10" readonly>
                            </td> <td>
                                <input value="<%= rs.getBoolean("mand_dis") %>" 
                                    name="DIS_MAND" size="10">
                            </td>
														<td>
                                <input value="<%= rs.getString("day1") %>" 
                                    name="DAY1" size="10" readonly>
                            </td>
														<td>
                                <input value="<%= rs.getString("day2") %>" 
                                    name="DAY2" size="10" readonly>
                            </td>
														<td>
                                <input value="<%= rs.getString("day3") %>" 
                                    name="DAY3" size="10" readonly>
                            </td>


                            <%--<td>
                                <input type="submit" name="UPD" value="Update">
                            </td>--%>

                          <%--<form action="sections.jsp" method="get">--%>
                           <%-- <input type="hidden" value="delete" name="action">--%>
                           <%-- <input type="hidden" 
                                value="<%= rs.getString("id") %>" name="ID">-->%
														
                            <%-- Button --%>
                            <td>
                                <input type="submit" name="DEL" value="Delete">
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
