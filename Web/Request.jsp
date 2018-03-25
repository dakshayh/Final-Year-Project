<%@page import="com.Performance.Connection.ConnectionFactory"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>


<%!
private String id;
String username;
private int no;
private String owner;
private String files;
private String requesttime;
private String filepath;
Date date = new Date();
Connection con=null;
PreparedStatement pst=null;
ResultSet rs=null;
Statement st=null;
private String keyvalues;
%>


<%
    
    id = request.getParameter("id");
    no = Integer.parseInt(id);
    username=session.getAttribute("username").toString().trim();
    DateFormat dateFormat = new SimpleDateFormat("hh:mm:ss a ");
    requesttime = dateFormat.format(date);
    int keyvalue = (int)(Math.random() * 89564);
    keyvalues = String.valueOf(keyvalue);
    System.out.println(keyvalues);
    
   try {
        
        con = ConnectionFactory.getConnection();
        st = con.createStatement();
        rs=st.executeQuery("select * from uploads where id="+no);
        while(rs.next())
                       {
            owner=rs.getString(2);
            files=rs.getString(10);
            filepath=rs.getString(7);
            
        }
        
        pst=con.prepareStatement("insert into request(owner,publicuser,file,filepath,dates,filekey)values(?,?,?,?,?,?)");
        pst.setString(1, owner);
        pst.setString(2, username);
        pst.setString(3, files);
        pst.setString(4, filepath);
        pst.setString(5, requesttime);
        pst.setString(6,keyvalues);
        int i=pst.executeUpdate();
         if (i > 0) {
            out.println("<html>"
                    + "<head>"
                    + "<title>"
                    + "Alert Message"
                    + "</title>");
            out.print("<script language='JavaScript'>alert('Successfully Your File Requesting .');</script>");
            out.println("<script> location.replace('PublicUser.jsp');</script>"
                    + "</head>");
            out.println("</html>");

        } else {
            out.println("<html>"
                    + "<head>"
                    + "<title>"
                    + "Alert Message"
                    + "</title>");
            out.print("<script language='JavaScript'>alert('Your File Not Request.');</script>");
            out.println("<script> location.replace('PublicUser.jsp');</script>"
                    + "</head>");
            out.println("</html>");
        }
        
       
    } catch (Exception e) {
        out.println(e.getMessage());
    }
%>