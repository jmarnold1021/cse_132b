<html>

<body>
  <table border="1">
        <tr>
            <td valign="top">
                <%-- -------- Include menu HTML code -------- --%>
                <jsp:include page="index.html" />
            </td>
            <td valign="top">
            <h1>View Grade Reports</h1>
						

            <%-- Set the scripting language to Java and --%>
            <%-- Import the java.sql package --%>
            <%@ page language="java" import="java.sql.*" %>
            <%@ page language="java" import="java.util.*" %>
            <%@ page language="java" import="java.text.*" %>
						
						

    
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
           

                              // Create the statement
                    Statement statement = conn.createStatement();

                    // Use the created statement to SELECT
                    // the student attributes FROM the Student table.
                    ResultSet rs = statement.executeQuery
                        ("Select id,SSN,first_name,middle_name,last_name from student");
											
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th colspan="3">Select Student</th>
												
										</tr>
                               <%-- -------- Iteration Code -------- --%>
						<tr>
            <form action="grade_report.jsp" method="get">
						
						<td colspan="3">
						<center>
						<select name="TITLE" >

						
            <%
                    // Iterate over the ResultSet
        
                    while ( rs.next() ) {
									
        
            %>

                    <option value="<%= rs.getString("ssn") %>">
		                  <%= rs.getInt("id") + " " + rs.getString("ssn") + " " + rs.getString("first_name") + " " + rs.getString("middle_name") + " " + rs.getString("last_name") %>

										</option>
                         

														
                            <%-- Get the COLLEGE --%>

														
    
                            <%-- Button --%>
                                                               
            <%
                    }
            %>
						
						 </select>

						 
						<br>
						
            <input name="view" type="submit" value="view">
						</center>
            </td>
            </form>
						

						 </tr>
						
						 <% 
              if( (request.getParameter("view") != null) && (request.getParameter("view").equals("view")) ){

							  

						    PreparedStatement si_stmt = conn.prepareStatement(
                            "Select id,ssn,first_name,middle_name,last_name from student WHERE ssn =?");
							  si_stmt.setString(1,request.getParameter("TITLE"));
                ResultSet si_rs = si_stmt.executeQuery();
               %>
								<%!
                int id=9999999;
                String ssn="";
                String fn="";             
								String mn="";
                String ln="";
								String student_info="";
								LinkedHashMap<String,String> classes_per = new LinkedHashMap();
								LinkedHashMap<String,Double> gpa_per_num = new LinkedHashMap();
								LinkedHashMap<String,Double> gpa_per_denom = new LinkedHashMap();
								
								HashMap<String,Double> g_cons=new HashMap();
								DecimalFormat fmt = new DecimalFormat("0.00");
								double cdenom = 0.0;
								double cnum = 0.0;
								double cgpa=0.0;
							
								%>

								<%
                while(si_rs.next()){
								
								  id=si_rs.getInt("id");
								  ssn=si_rs.getString("ssn");
                  fn=si_rs.getString("first_name");                
								  mn=si_rs.getString("middle_name");
                  ln=si_rs.getString("last_name");

									 student_info="Student : " +id+"<br>SSN : "+ssn+"<br>"+fn+ " "+mn+ " "+ln;
									 
								}
								



						    Statement converts = conn.createStatement();
                 ResultSet rsc = converts.executeQuery
                        ("Select * from grade_conversion");
								 while(rsc.next()){
                    g_cons.put(rsc.getString("LETTER_GRADE"),Double.valueOf(rsc.getFloat("NUMBER_GRADE")));
                  }
									rsc.close();
									converts.close();
               
						  	PreparedStatement ci_stmt = conn.prepareStatement(
                            "select classes.class_id,num,title,year,qtr,fac,units,grade_type,grade from classes inner join academichistory on (classes.class_id=academichistory.class_id) where stu_id=? ORDER BY year DESC");
							  ci_stmt.setInt(1,id);
                ResultSet ci_rs = ci_stmt.executeQuery();


								%>





								<%!
								
                int cid=9999999;
                String num="";
                String title="";             
                String qtr="";
                String fac="";
								int year=0001;
								int units=0;
								String grade_type="";
								String grade="";
								
								
								String currdate="";
								
								String temp="";
								double snum = 0.0;
								double sdenom=0.0;
								
                %>
								
								<%
								
								classes_per.clear();
								cnum=0.0;
								cdenom=0.0;

                while(ci_rs.next()){
								  cid=ci_rs.getInt("class_id");
								  num=ci_rs.getString("num");
                  title=ci_rs.getString("title");                
								  year=ci_rs.getInt("year");
									
								  qtr=ci_rs.getString("qtr");
                  fac=ci_rs.getString("fac");
									units=ci_rs.getInt("units");
                  grade_type=ci_rs.getString("grade_type");
                  grade=ci_rs.getString("grade");
									
                  currdate=year+" "+qtr;
                                    
								   temp="";
									 temp=cid+" "+num+" "+title+" "+fac+" "+grade_type+" "+units+" "+grade+"<br>";
									 
                   System.out.println(grade_type);
                   System.out.println(units);
									 
									 if( grade_type.equals("S/U") || grade.equals("F") || grade.equals("N/C") || grade.equals("W") ){
									    snum=0.0;
									    sdenom=0.0;
									   

									 }
									 else{
									    snum=g_cons.get(grade)*units;
									    sdenom=units;


									 }
									 
									 if(classes_per.get(currdate)==null){
								     classes_per.put(currdate ,temp );
										 gpa_per_num.put(currdate,snum);
										 gpa_per_denom.put(currdate,sdenom);
										 
									 }
									 else{
								     classes_per.put(currdate ,classes_per.get(currdate)+temp );
										 gpa_per_num.put(currdate ,gpa_per_num.get(currdate)+snum);
										 gpa_per_denom.put(currdate,gpa_per_denom.get(currdate)+sdenom);

									}
									cnum+=snum;
									cdenom+=sdenom;
									 
									
	                     
               }

						
						if(cdenom<=0.0){

              cgpa=0.0;
						}
						else{
              cgpa=cnum/cdenom;
						}
            

						%>
						<tr>
						<td colspan="3">
						<center>
            <%= student_info+ "<br>CumGPA: " +fmt.format(cgpa) %>
						</center>
						</td>
						</tr>
						<tr>
           <th>Quarter</th>
           <th>Classes Taken</th>
           <th>Quarter GPA</th>
					 
						</tr>
          
						<%
						  for(String qurt : classes_per.keySet()){
            %>
						  <tr>

						  <td><center><%=qurt%></center></td>
              

							<td><center><%=classes_per.get(qurt)%></center></td>
							<td>
							<center>
							  <%
                 if(gpa_per_denom.get(qurt)<=0.0){
							  %>
							   <%=0.0%>
                <%
                }
							  else{
                 %>
							    <%=fmt.format(gpa_per_num.get(qurt)/gpa_per_denom.get(qurt))%>
							
							  <%
							    }
							  %>
								</center>
							  </td>
							

            
           
					 </tr>
					 
           <%
						  }
           %>
					<%		

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
