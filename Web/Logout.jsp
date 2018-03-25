<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.Performance.Form.AccountForm"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.sql.Statement"%>
<%@page import="com.Performance.Connection.ConnectionFactory"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<html lang="en">
<head>   
</head>

<body>
<%!
        
AccountForm MF=new AccountForm();
private int i;
private int id;
private String timeout="NO";


%>
       
                <%
                    Connection con = null;
                    Statement st = null;
                    ResultSet rt=null;
                    PreparedStatement pst=null;
                    String username = (String) session.getAttribute("username").toString().trim();
                    DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd-hh.mm.ss a");
                    Date date = new Date();
                    String logout = dateFormat.format(date);
                  
                    try {
                        
                        con = ConnectionFactory.getConnection();
                        pst=con.prepareStatement("select * from logout where username='"+username+"' and timeout='"+timeout+"'");
                        rt=pst.executeQuery();
                        while(rt.next())
                                                       {
                        id=rt.getInt(1);            
                        }                       
                       st=con.createStatement(); 
                       i = st.executeUpdate("update logout set timeout='" +logout+ "' where username='"+username+"' and id="+id);                                         
                        if (i > 0) {
                            session.invalidate();
                            response.sendRedirect("IndexPage.jsp");
                        }
                    } catch (Exception e) {
                        e.getMessage();
                    }
                %> 
</body>
</html>
