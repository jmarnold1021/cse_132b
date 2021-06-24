import java.io.*;
import java.text.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;

/**
 * Test Time Servlet
 */

public class TimeTest extends HttpServlet {

    public void doGet(HttpServletRequest request,
                      HttpServletResponse response)
        throws IOException, ServletException
    {
     
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        String newTime = (new Date()).toString();

        out.println("<html>");
        out.println("<head>");
        out.println("<title>Time Test Servlet</title>");
        out.println("</head>");
        out.println("<body>");
        out.println("<h1>Current Time (Servlet)</h1>");
        out.println(newTime);
        out.println("</body>");
        out.println("</html>");
    }
}



