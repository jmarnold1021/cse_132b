<%
   String name = request.getParameter( "username" );
   session.setAttribute( "theName", name );
%>
<HTML>
<BODY>
  
  <jsp:forward page="NextPage.jsp"/>

</BODY>
</HTML>
