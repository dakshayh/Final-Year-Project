<%@page import="com.Performance.Connection.ConnectionFactory"%>
<%@page import="java.util.Random"%>
<%@page import="java.security.SecureRandom"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page language="java" import="java.io.*"%>
<%@page language="java" import="java.sql.*" %>
<!DOCTYPE html>
<%! int count, cloudid;
    private String cloud;
    private String username=" ";
    PreparedStatement pst = null, pst1 = null;
    ResultSet rst = null;
    Connection connection;
%>

<%
    cloudid = (int) (Math.random() * 8347);
    cloud = String.valueOf(cloudid);
    String ids = request.getParameter("id");
    //int id = Integer.parseInt(ids);
    System.out.println(ids);
    try {
        connection = ConnectionFactory.getConnection();
        pst = connection.prepareStatement("select username from user where id='" + ids+"'");
        rst = pst.executeQuery();
        while (rst.next()) {
            username = rst.getString(1);
            System.out.println(username);
        }
        pst1 = connection.prepareStatement("update user set cloudid='" + cloud + "',permission='" + "YES" + "' where username='" + username + "'");
        int count = pst1.executeUpdate();
        if(count==1)
                       {%>
         
            <script> location.replace('UserView.jsp');</script>
            
          <%  
            
        }else
                       {
            
        }


    } catch (Exception ex) {
        out.println("" + ex.getMessage());
    }

%>
