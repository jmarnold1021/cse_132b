<html>

<body>
  <table border="1">
        <tr>
            <td valign="top">
                <%-- -------- Include menu HTML code -------- --%>
                <jsp:include page="index.html" />
            </td>
            <td valign="top">
            <h1>Class Statistics</h1>
						

            <%-- Set the scripting language to Java and --%>
            <%-- Import the java.sql package --%>
            <%@ page language="java" import="java.sql.*" %>
            <%@ page language="java" import="java.text.*" %>
            <%@ page language="java" import="java.util.*" %>
						
						
    
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
                   
            %>

                      
            <%-- -------- SELECT Statement Code -------- --%>
            <%
                    // Create the statement
                    Statement statement = conn.createStatement();

                    // Use the created statement to SELECT
                    // the student attributes FROM the Student table.
                    ResultSet rs = statement.executeQuery
                        ("Select num,year,qtr,fac from classes group by num,year,qtr,fac order by num");


            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>Select Section</th>
                        <th>Action</th>
												
										</tr>
                               <%-- -------- Iteration Code -------- --%>
						<tr>
            <form action="statistics.jsp" method="get">
						
						<td>
						
						<select name="INFO">
            <%
                    // Iterate over the ResultSet
        
                    while ( rs.next() ) {
        
            %>

                    <option value="<%=rs.getString("num")+"::"+rs.getInt("year")+"::"+rs.getString("qtr")+"::"+rs.getString("fac")%>" >
		                  <%= rs.getString("num")+" "+rs.getInt("year")+" "+rs.getString("qtr")+" "+rs.getString("fac")%>
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
             %>
							<%!
							  String [] cdata=null;
								String cnum="";
								int cyear=0;
								String cqtr="";
								String cfac="";
								String cinfo="";
								double ygpa=0.0;
								DecimalFormat fmt = new DecimalFormat("0.00");
                LinkedHashMap<String,Integer> gr = new LinkedHashMap();
								
								
							%>

							
						 <%

              cdata=request.getParameter("INFO").split("::");
							cnum=cdata[0];
							cyear=Integer.parseInt(cdata[1]);
							cqtr=cdata[2];
							cfac=cdata[3];
							cinfo=cnum+"<br> "+cfac+"<br>"+cyear+" "+cqtr;
							gr.put("A",0);
							gr.put("B",0);
							gr.put("C",0);
							gr.put("D",0);
							gr.put("F",0);
							gr.put("S/U",0);
							
							              /*
						  PreparedStatement si_stmt = conn.prepareStatement(
                            "select CAT as gd,count(c.grd) as cnt from "+
                            "grade_conversion left outer join "+
                            "(select classes.class_id as cid,num as n,year as yr,qtr as q,fac as f,grade as grd "+
                            "from classes join academichistory on classes.class_id=academichistory.class_id  "+
                            "where fac=? and num=? and year=? and qtr=?) as c on (LETTER_GRADE=grd) or (grd=NULL) "+
                            "group by CAT "+
								            "Having CAT='A' or "+
            								"CAT='B' or "+
												    "CAT='C' or "+
												    "CAT='D' or "+
												    "CAT='F' or "+
												    "CAT='S/U' "+
												    "ORDER BY CAT ASC"
												);
								si_stmt.setString(1,cfac);
								si_stmt.setString(2,cnum);
								si_stmt.setInt(3,cyear);
								
								si_stmt.setString(4,cqtr);
                ResultSet si_rs = si_stmt.executeQuery();
						  */
							
							 PreparedStatement si_stmt = conn.prepareStatement("select cnum,cyr,cfac,cqtr,cgd,ccnt from CPGQ where cfac=? and cnum=? and cyr=? and cqtr=?");
               si_stmt.setString(1,cfac);
								si_stmt.setString(2,cnum);
								si_stmt.setInt(3,cyear);
								
								si_stmt.setString(4,cqtr);
                ResultSet si_rs = si_stmt.executeQuery();
                






              %>
							<%!
                int cnt=0;
								String cgrade="";

                             
								String grade_counts="";
								String y_grade_counts="";
							  String c_grade_counts="";
								
								
								%>

								<%
								 
                while(si_rs.next()){
								  cgrade=si_rs.getString("cgd");
									cnt=si_rs.getInt("ccnt");
									gr.put(cgrade,cnt);
									
								}

								
								int c=0;

								for(String key : gr.keySet()){

									grade_counts+=key+" : "+gr.get(key);
									if((c % 3) == 2){
                    grade_counts+="<br>";
									}
									else{
									   if(c==11)
										   break;
                     grade_counts+=" , ";
									}

									gr.put(key,0);//clear for next query
									c++;
                }
								
								si_stmt = conn.prepareStatement(
                            "select num,year,qtr,fac,count(*) as cnt "+
                            "from classes "+ 
                            "where fac=? and num=? and year=? and qtr=? "+
                            "group by num,year,qtr,fac"
                           );
								si_stmt.setString(1,cfac);
								si_stmt.setString(2,cnum);
								si_stmt.setInt(3,cyear);
								
								si_stmt.setString(4,cqtr);
                si_rs = si_stmt.executeQuery();
                while(si_rs.next()){
                
                 cinfo+="<br>Sections Taught: "+si_rs.getInt("cnt");

								}
                
								/*si_stmt = conn.prepareStatement(
                            "select CAT as gd,count(c.grd) as cnt from "+
                            "grade_conversion left outer join "+
                            "(select classes.class_id as cid,num as n,fac as f,grade as grd "+
                            "from classes join academichistory on classes.class_id=academichistory.class_id  "+
                            "where fac=? and num=?) as c on (LETTER_GRADE=grd) or (grd=NULL) "+
                            "group by CAT "+
								            "Having CAT='A' or "+
            								"CAT='B' or "+
												    "CAT='C' or "+
												    "CAT='D' or "+
												    "CAT='F' or "+
												    "CAT='S/U' "+
												    "ORDER BY CAT ASC"
												);*/

								si_stmt = conn.prepareStatement("Select cnum,cfac,cgd,ccnt from CPG where cfac=? and cnum=?");				
								si_stmt.setString(1,cfac);
								si_stmt.setString(2,cnum);
							  si_rs = si_stmt.executeQuery();
							   c=0;
								
                while(si_rs.next()){
								  cgrade=si_rs.getString("cgd");
									cnt=si_rs.getInt("ccnt");
									gr.put(cgrade,cnt);

								}	
								
								for(String key : gr.keySet()){
									 y_grade_counts+=key+" : "+gr.get(key);
									if((c % 3) == 2){
                    y_grade_counts+="<br>";
									}
									else{
									   if(c==11)
										   break;
                     y_grade_counts+=" , ";
									}
									gr.put(key,0);
									c++;

                }
	              si_stmt = conn.prepareStatement(
                "select c.n,c.f,SUM(cunits*NUMBER_GRADE)/SUM(cunits) as gpa from "+
                "grade_conversion join "+
                "(select units as cunits,num as n,fac as f,grade as grd "+
                " from classes join academichistory on classes.class_id=academichistory.class_id "+
                  "where fac=? and num=? and grade!='S' and grade!='U' ) as c on (LETTER_GRADE=grd) "+
                  "group by c.n,c.f");

                si_stmt.setString(1,cfac);
								si_stmt.setString(2,cnum);
							  si_rs = si_stmt.executeQuery();
							  
								
                while(si_rs.next()){
								  ygpa=si_rs.getFloat("gpa");

								}






								si_stmt = conn.prepareStatement(
                            "select CAT as gd,count(c.grd) as cnt from "+
                            "grade_conversion left outer join "+
                            "(select classes.class_id as cid,num as n,grade as grd "+
                            "from classes join academichistory on classes.class_id=academichistory.class_id  "+
                            "where num=?) as c on (LETTER_GRADE=grd) or (grd=NULL) "+
                            "group by CAT "+
								            "Having CAT='A' or "+
            								"CAT='B' or "+
												    "CAT='C' or "+
												    "CAT='D' or "+
														"CAT='F' or "+
												    "CAT='S/U' "+
												    "ORDER BY CAT ASC"
												);
								si_stmt.setString(1,cnum);
							  si_rs = si_stmt.executeQuery();
							   c=0;
								
                while(si_rs.next()){
								  cgrade=si_rs.getString("gd");
									cnt=si_rs.getInt("cnt");
									
									 c_grade_counts+=cgrade+" : "+cnt;
									if((c % 3) == 2){
                    c_grade_counts+="<br>";
									}
									else{
									   if(c==11)
										   break;
                     c_grade_counts+=" , ";
									}
									c++;
                }

								











               




               %>
						 	 
							<tr>
							<th>Info</th>
							<th>Grade Count</th>	
							</tr>
						 <tr>
              <td>
						 <center>
						 <%=cinfo%>
						 </center>
						 </td>
						 <td>
						 <%=grade_counts%>
						 </td>
						 
						 </tr>
						 <tr>
               <td>
						 <center>
						 <%=cnum+"<br>"+cfac+"<br>GPA Over Years: "+fmt.format(ygpa)%>
						 </center>
						 </td>

						  <td>
						 <%=y_grade_counts%>
						 </td>
						 </tr>
						 </tr>
						 <tr>
               <td>
						 <center>
						 <%=cnum%>
						 </center>
						 </td>

						  <td>
						 <%=c_grade_counts%>
						 </td>
						 </tr>
						

          
					
						<%
							 grade_counts="";
							 y_grade_counts="";
							 c_grade_counts="";
							 
							 
							 cinfo="";
						
						
						
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
