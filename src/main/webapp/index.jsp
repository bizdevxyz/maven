<%@ page import = "java.io.*,java.util.*" %>
<html>
   <head>
      <title>Docker Enterprise - tomcat/maven example 3</title>
   </head>
   <body>
      <%
         Integer hitsCount = (Integer)application.getAttribute("hitCounter");
         if( hitsCount ==null || hitsCount == 0 ) {
            /* First visit */
            out.println("Welcome to the website!");
            hitsCount = 1;
         } else {
            /* return visit */
            out.println("page automatically refreshes every 5 seconds..");
            hitsCount += 1;
         }
         application.setAttribute("hitCounter", hitsCount);
      %>
      
      <center>
         <h2>Docker Enterprise - tomcat/maven example 3</h2>
         <p>Total number of visits: <%= hitsCount%></p>
         <%
            // Set refresh, autoload time as 5 seconds
            response.setIntHeader("Refresh", 5);
            TimeZone.setDefault(TimeZone.getTimeZone("EST"));
            Calendar cal_Two = Calendar.getInstance(TimeZone.getTimeZone("EST"));
            out.println("Current Time: " + cal_Two.getTime() + "\n");          
         %>
      </center> 
   </body>
</html>
