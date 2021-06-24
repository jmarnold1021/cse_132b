<html>

<body>
  <table border="1">
        <tr>
            <td valign="top">
                <%-- -------- Include menu HTML code -------- --%>
                <jsp:include page="index.html" />
            </td>
            <td valign="top">
            <h1>View Schedule</h1>
						

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
                            "INSERT INTO Student VALUES (DEFAULT,?, ?, ?, ?, DATE(NOW()),DATE(NOW()) )");

                        pstmt.setString(1, request.getParameter("SSN"));
                        pstmt.setString(2, request.getParameter("FIRSTNAME"));
												pstmt.setString(3, request.getParameter("MIDDLENAME"));
                        pstmt.setString(4, request.getParameter("LASTNAME"));
                        /*pstmt.setString(5, request.getParameter("STARTDATE"));
                        pstmt.setString(6, request.getParameter("ENDDATE"));*/
												
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
                            "UPDATE Student SET first_name = ?, middle_name = ?, " +
                            "last_name = ?, start_date = DATE(?),  end_Date=DATE(?) WHERE id = ?");

                        pstmt.setInt(6, Integer.parseInt(request.getParameter("ID")));
                        pstmt.setString(1, request.getParameter("FIRSTNAME"));
												pstmt.setString(2, request.getParameter("MIDDLENAME"));
                        pstmt.setString(3, request.getParameter("LASTNAME"));
                        pstmt.setString(4, request.getParameter("STARTDATE"));
                        pstmt.setString(5, request.getParameter("ENDDATE"));

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


                     /*   PreparedStatement pstmt = conn.prepareStatement(
                            "DELETE FROM Majors WHERE id = ?");

                        pstmt.setInt(
                            1, Integer.parseInt(request.getParameter("ID")));
                        int rowCount = pstmt.executeUpdate();

											  pstmt = conn.prepareStatement(
                            "DELETE FROM Minors WHERE id = ?");

                        pstmt.setInt(
                            1, Integer.parseInt(request.getParameter("ID")));
                        rowCount = pstmt.executeUpdate();

												pstmt = conn.prepareStatement(
                            "DELETE FROM Graduate WHERE id = ?");

                        pstmt.setInt(
                            1, Integer.parseInt(request.getParameter("ID")));
                        rowCount = pstmt.executeUpdate();


												pstmt = conn.prepareStatement(
                            "DELETE FROM Undergraduate WHERE id = ?");

                        pstmt.setInt(
                            1, Integer.parseInt(request.getParameter("ID")));
                        rowCount = pstmt.executeUpdate();

                        
												pstmt = conn.prepareStatement(
                            "DELETE FROM PrivateInfo WHERE id = ?");

                        pstmt.setInt(
                            1, Integer.parseInt(request.getParameter("ID")));
                        rowCount = pstmt.executeUpdate();

												pstmt = conn.prepareStatement(
                            "DELETE FROM AttendanceInfo WHERE id = ?");

                        pstmt.setInt(
                            1, Integer.parseInt(request.getParameter("ID")));
                        rowCount = pstmt.executeUpdate();

*/

                        PreparedStatement pstmt = conn.prepareStatement(
                            "DELETE FROM Student WHERE id = ?");

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
                        ("Select Distinct on (id) id,ssn,first_name,middle_name,last_name "+ 
												 "from student INNER JOIN enrolled on (student.id=enrolled.stu_id) ORDER BY id ASC");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>Select Student</th>
                        <th>Action</th>
												
										</tr>
                               <%-- -------- Iteration Code -------- --%>
						<tr>
            <form action="view_schedules.jsp" method="get">
						
						<td>
						
						<select name="SSN">
            <%
                    // Iterate over the ResultSet
        
                    while ( rs.next() ) {
        
            %>

                    <option value="<%= rs.getString("ssn") %>" >
		                  <%= rs.getInt("id") + " " + rs.getString("ssn") + " " + rs.getString("first_name") + " " + rs.getString("middle_name") + " " + rs.getString("last_name") %>
										</option>	
                           

														
                            <%-- Get the COLLEGE --%>

														
    
                            <%-- Button --%>
                                                                    
            <%
                    }
            %>
						 </select>

						 
						</td>
						<td>
            <input name="view" type="submit" value="view">
						
            </td>
            </form>
						

						 </tr>
						
						 <% 
              if( (request.getParameter("view") != null) && (request.getParameter("view").equals("view")) ){

						    PreparedStatement si_stmt = conn.prepareStatement(
                            "Select id,ssn,first_name,middle_name,last_name from student WHERE ssn = ?");
							  si_stmt.setString(1,request.getParameter("SSN"));
                ResultSet si_rs = si_stmt.executeQuery();
               %>
								<%!
                int id=9999999;
                String ssn="";
                String fn="";             
								String mn="";
                String ln="";
								%>

								<%
                while(si_rs.next()){
								
								  id=si_rs.getInt("id");
								  ssn=si_rs.getString("ssn");
                  fn=si_rs.getString("first_name");                
								  mn=si_rs.getString("middle_name");
                  ln=si_rs.getString("last_name");
                %>
							<tr>
							<th></th>
							<th></th>
							<th></th>
							<th></th>
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
							<th></th>
							<th></th>
							<th></th>
							<th></th>
							
							
							
							</tr>
						 <tr>
						 <td colspan="2">
						 <center>
             <p>
               <%= "<h4>Student : " +id+"</h4>"%><br> 
							 <%="SSN : "+ssn%><br>
							 <%= fn+ " "+mn+ " "+ln%>
						 </p>
						 </center>
             </td>
						 </tr>

						<%
                }
						  

							PreparedStatement ci_stmt = conn.prepareStatement(
                            "Select enrolled.class_id,num,title,fac,units,grade_type,s_date,e_date "+
														"from enrolled inner join classes on (enrolled.class_id=classes.class_id) WHERE enrolled.stu_id = ?");
							  ci_stmt.setInt(1,id);
                ResultSet ci_rs = ci_stmt.executeQuery();
								%>
								<%!
								int countc=0;
                int cid=9999999;
                String cnum="";
                String ctitle="";             
								int cunits=99999999;
                String cgrade="";
								String cfac="";
								String sd="";
								String ed="";
                %>
								
								<%
							  countc=0;	
                while(ci_rs.next()){
                  countc++;
								  cid=ci_rs.getInt("class_id");
								  cnum=ci_rs.getString("num");
                  ctitle=ci_rs.getString("title");
									cfac=ci_rs.getString("fac");
									cunits=ci_rs.getInt("units");
                  cgrade=ci_rs.getString("grade_type");
									sd=ci_rs.getString("s_date");
									ed=ci_rs.getString("e_date");


             
  
							
						 %>
             <tr>
						 <td>
             <p>
               <%="<h4>Class : " +countc+"</h4>" %><br>
						  
               <%="Section id : " +cid %><br>
							 <%="Num : "+cnum%><br>
							 <%="Title : "+ctitle%><br> 
							 <%="Faculty :  "+cfac%><br>
							 <%="Start Date : "+sd%><br>
							 <%=" End Date  : "+ed%><br>

							 <%="Units :  "+cunits%><br>
							 <%="Grade Type :  "+cgrade%>

							 


						 </p>
	 					 </td>
                
						 <%
						 	PreparedStatement se_stmt = conn.prepareStatement(
                            "Select * from section WHERE id = ?");
							  se_stmt.setInt(1,cid);
                ResultSet se_rs = se_stmt.executeQuery();
								%>
								<%!
								int counts=0;
                int sid=9999999;
                String stype="LE";
                String srevdate="01-01-0001";             
								boolean smanddis=false;
                String sday1="";
								String sday2="";
								String sday3="";
								String st="";
								String et="";
								String sbuild="";
								String sroom="";
								int size=99999999;
								
                %>
								
								<%
								counts=0;
                while(se_rs.next()){
								  counts++;

								  sid=se_rs.getInt("id");
								  stype=se_rs.getString("sect_type");
                  srevdate=se_rs.getString("rev_date");
									smanddis=se_rs.getBoolean("mand_dis");
									sday1=se_rs.getString("day1");
                  sday2=se_rs.getString("day2");
                  sday3=se_rs.getString("day3");
                  st=se_rs.getString("start_time");
                  et=se_rs.getString("end_time");
                  sbuild=se_rs.getString("building");
                  sroom=se_rs.getString("room");
                  size=se_rs.getInt("class_size");
									

									
									
									
									


						 %>
            <td valign="top">
						  <center>
						
            <p>
							   <%= "<h4>Meeting : "+counts+"</h4>"%><br>               
							
						  <%=stype%><br>
							<%
							if(stype.equals("RE")){
							%>
							   <%= srevdate%><br>               
							<%
              }
							
							if(stype.equals("DI")){
							  if(smanddis==true){

							%>
							 
							  <%= "Manditory"%><br>
								<%
								}
								else{
								%>

							  <%= "Optional"%><br>
                
              <%
							  }
              }
						  	

							
							if(!(sday1.equals("N/A") )){
							%>
							  
							  <%= sday1%>
              <%
              }
							if(!(sday2.equals("N/A"))){
							%>
							  <%= ", "+sday2%>
              <%
              }
						  if(!(sday3.equals("N/A"))){
							%>
							  <%= ", "+sday3%>
              <%
              }
								int s=Integer.parseInt(st.substring(0,2));
                  if( (s>=12) && (s<=23) ){
										if(s==12){
										  s=12;
                    }
										else{
                      s=s-12;
										}
                    st=""+s+st.substring(2,5)+" pm";
									}
								  else{
                  
									  if(s==24){
										  s=12;
                    }
									  st=""+s+st.substring(2,5)+" am";
                  }

								int e=Integer.parseInt(et.substring(0,2));
                  if( (e>=12) && (e<=23)){
									  if(e==12){
										  e=12;
                    }
										else{
                      e=e-12;
										}
                    et=""+e+et.substring(2,5)+" pm";
                  }
									else{

									  if(e==24){
										  e=12;
                    }
									  et=""+e+et.substring(2,5)+" am";
                  }
							%>
							<br>
              <%= st+" - "+et%><br>
             
              <%= sbuild + " "+sroom%><br>
              <%= "Class Size : " +size%><br>
							
							

							

            </p>
           </center>
						
						</td>

           <%
           }
					 %>
					 </tr>
           <%
              
						}
						}//view pushed
						
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
