<html>

<body>
  <table border="1">
        <tr>
            <td valign="top">
                <%-- -------- Include menu HTML code -------- --%>
                <jsp:include page="index.html" />
            </td>
            <td valign="top">
            <h1>Schedule Review</h1>
						

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
                        ("Select class_id,num,fac from classes c where year=2009 and qtr='S' and (select count(*) from enrolled as e where c.class_id=e.class_id)!=0");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>Select Section</th>
                        <th>Action</th>
												
										</tr>
                               <%-- -------- Iteration Code -------- --%>
						<tr>
            <form action="schedule_review.jsp" method="get">
						
						<td>
						
						<select name="ID">
            <%
                    // Iterate over the ResultSet
        
                    while ( rs.next() ) {
        
            %>

                    <option value="<%= rs.getInt("class_id") %>" >
		                  <%= rs.getInt("class_id") + " " + rs.getString("num") + " " + rs.getString("fac") %>
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
                            "Select class_id,num,fac,s_date,e_date from classes where class_id=?");
							   si_stmt.setInt(1,Integer.parseInt(request.getParameter("ID")));
                 ResultSet si_rs = si_stmt.executeQuery();
              %>
							<%!
                int id=9999999;
                String cnum="";             
								String cfac="";
								String section_info="";
								String sd="";
								String ed="";
								%>

								<%
                while(si_rs.next()){
								
								  id=si_rs.getInt("class_id");
								  cnum=si_rs.getString("num");
                  cfac=si_rs.getString("fac");
									sd=si_rs.getString("s_date");
									ed=si_rs.getString("e_date");
								  

									section_info+="Section id: "+id+"<br>Coure Num: "+cnum+"<br>Faculty: "+cfac+"<br>"+sd+" - "+ed;
                
							
               
						   }
               %>
						 <tr>

						 <td colspan="2">
						 <center>
						 <%=section_info%>
						 </center>
						 </td>
						 </tr>

           <%
					  section_info="";
						si_stmt = conn.prepareStatement(
                            
"Select * from "+ 
"(select CURRENT_DATE+i as dt,dayy as dayy2,rtime as rrtime,etime as eetime "+
 "from (generate_series((DATE(?))- CURRENT_DATE,(DATE(?) - CURRENT_DATE) ) i "+
			 "join day_conversion on day_val=Extract(DOW from CURRENT_DATE+(i-1)) ), "+
       "rev_times) as all_ints "+
"where all_ints.dayy2 not in (select distinct(dayy) from (((section join day_conversion on (section.day1=dayy or section.day2=dayy or section.day3=dayy)) "+
														                                      "join enrolled on section.id=enrolled.class_id) "+
                                                                  "join student on student.id=stu_id) "+
																																	"where student.id in (select ccc.stu_id from (((section join day_conversion on (section.day1=dayy or section.day2=dayy or section.day3=dayy)) "+
														                                                                                     "join enrolled on section.id=enrolled.class_id) "+
                                                                                                                 "join student on student.id=stu_id) as ccc "+
																																																								 "where ccc.class_id=? "+
																																											")"+
                            ")"+
"or "+
		  "(Select count(*) from (((section join day_conversion on (section.day1=dayy or section.day2=dayy or section.day3=dayy)) "+
														           "join enrolled on enrolled.class_id=section.id) "+
                                       "join student on student.id=stu_id) "+
			 "where ((sect_type!='RE' and dayy=all_ints.dayy2 and (SELECT (start_time,end_time) OVERLAPS (all_ints.rrtime,all_ints.eetime) )=true) or "+
						 "(sect_type='RE' and rev_date=all_ints.dt and (SELECT (start_time,end_time) OVERLAPS (all_ints.rrtime,all_ints.eetime) )=true)) and "+
						 "student.id in (select distinct(ccc.stu_id) from (((section join day_conversion on (section.day1=dayy or section.day2=dayy or section.day3=dayy)) "+
                                                                        "join enrolled on section.id=enrolled.class_id) "+
                                                                        "join student on student.id=stu_id) as ccc "+
																																			  "where ccc.class_id=? "+
													 ")"+
			")=0 " +
"order by all_ints.dt,all_ints.rrtime,all_ints.eetime"


);
             si_stmt.setString(1,sd);
             si_stmt.setString(2,ed);
             
             si_stmt.setInt(3,id);
             si_stmt.setInt(4,id);
						 
             si_rs = si_stmt.executeQuery();


						 %>
						


						 <%!
						  String dt="";
							String day="";
							String st="";
							String et="";


						 %>
						 <%

						 while(si_rs.next()){
						      

				  			  dt=si_rs.getString("dt");
								  day=si_rs.getString("dayy2");
                  st=si_rs.getString("rrtime");
                  et=si_rs.getString("eetime");

          
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
             <tr>

						 <td colspan="2">
						 <center>
						 <%=dt+" "+day+" "+st+" "+et%>
						 </center>
						 </td>
						 </tr>
                
							
           <%   
						}
					
																		 
						}//view pushed
						
            

             


            
            
           						
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
