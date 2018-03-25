package com.Performance.Controller;

import com.Performance.Connection.ConnectionFactory;
import java.io.DataInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class Download extends HttpServlet {

    static final long serialVersionUID = 1L;
    private static final int BUFSIZE = 4096;
    String str = "";
    String originalpath = "";
    String cost = "";
    String usage = "";
    String time = "";
    String user;
    String fileName;
    File file;
    int length;
    ServletOutputStream outStream;
    ServletContext context;
    String mimetype;
    Connection con = null;
    String files;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = null;
        long start = System.currentTimeMillis();
        response.setContentType("text/html;charset=UTF-8");
        String id = request.getParameter("id");
        String masterkey = request.getParameter("key");
        String schema = request.getParameter("s");
        System.out.println("schema :" + schema);
        System.out.println("key :" + masterkey);
        System.out.println("id :" + id);
        HttpSession session = request.getSession(true);
        String username = (String) session.getAttribute("username").toString().trim();
        try {
            con = ConnectionFactory.getConnection();
            PreparedStatement pst = con.prepareStatement("select * from schematable where name='" + schema + "' and masterkey='" + masterkey + "'");
            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                PreparedStatement pst2 = con.prepareStatement("select * from datatable where id='" + id + "'");
                ResultSet rs1 = pst2.executeQuery();
                rs1.next();
                //user = rs1.getString(2);
                cost = rs1.getString(9);
                originalpath = rs1.getString(3);
                files = rs1.getString(8);
                usage = rs1.getString("filesize");
                System.out.println("File Usage(Size) :" + usage);
                DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
                Date date = new Date();
                file = new File(originalpath);
                length = 0;

                // downloading   
                outStream = response.getOutputStream();
                context = getServletConfig().getServletContext();
                mimetype = context.getMimeType(originalpath);
                response.setContentType(mimetype);
                response.setContentLength((int) file.length());
                fileName = (new File(originalpath)).getName();
                if (fileName.trim().equalsIgnoreCase("txt")) {
                    response.setContentType("text/plain");

                } else if (fileName.trim().equalsIgnoreCase("doc")) {
                    response.setContentType("application/msword");
                } else if (fileName.trim().equalsIgnoreCase("xls")) {
                    response.setContentType("application/vnd.ms-excel");
                } else if (fileName.trim().equalsIgnoreCase("pdf")) {
                    response.setContentType("application/pdf");
                } else {
                    response.setContentType("application/octet-stream");
                }
                response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");

                byte[] byteBuffer = new byte[BUFSIZE];

                DataInputStream in = new DataInputStream(new FileInputStream(file));

                while ((in != null) && ((length = in.read(byteBuffer)) != -1)) {
                    outStream.write(byteBuffer, 0, length);
                }

                long end = System.currentTimeMillis();
                String cloudusagediff = "";
                String time = String.valueOf(end - start);
                PreparedStatement p = con.prepareStatement("select * from user where username='" + username + "'");
                ResultSet r = p.executeQuery();
                if (r.next()) {
                    String cloud_usage = r.getString("cloudusage");

                    System.out.println("Cloud Usage (MB):" + cloud_usage);
                    double parseDouble = Double.parseDouble(cloud_usage) * 1024;//KB value
                    System.out.println("Cloud Usage (KB):" + parseDouble);
                    System.out.println("File Usage(Size)KB :" + usage);//0.400390KB

                    double file_size = Double.parseDouble(usage);
                    cloudusagediff = String.valueOf((parseDouble - file_size) / 1024);
                    System.out.println("Cloud Difference(In KB) :" + cloudusagediff);
                    r.getString("space");
                }
                PreparedStatement p1 = con.prepareStatement("update user set cloudusage='" + cloudusagediff + "' where username='" + username + "'");
                if (p1.executeUpdate() > 0) {
                    System.out.println("Succesfully updated User table");
                } else {
                    System.out.println("Error in updated User table");
                }

                PreparedStatement ev = con.prepareStatement("select * from evaluation where username='" + username + "'");
                ResultSet rv = ev.executeQuery();
                if (rv.next()) {
                    System.out.println("Update Into Evaluation Table");
                    PreparedStatement pst1 = null;
                    double valTime = getPerformValue(username, "time", schema)+Double.parseDouble(time);
                    double valPricing = getPerformValue(username, "pricing", schema)+Double.parseDouble(cost);
                    double valUsage = getPerformValue(username, "usage", schema)+Double.parseDouble(usage);
                    System.out.println("Val Time :" + valTime);
                    System.out.println("Val Pricing :" + valPricing);
                    System.out.println("Val Usage :" + valUsage);
                    double va = valTime + Double.parseDouble(time);
                    System.out.println("After Addd :" + va);
                    String s = schema;
                    pst1 = con.prepareStatement("update evaluation set " + s + "=? where username='" + username + "' and performtype=?");
                    pst1.setDouble(1, valTime);
                    pst1.setString(2, "time");
                    if (pst1.executeUpdate() > 0) {
                        System.out.println("Updated New Evaluation Time ,Hi");
                    }


                    pst1 = con.prepareStatement("update evaluation set " + s + "=? where username='" + username + "' and performtype=?");
                    pst1.setDouble(1, valPricing);
                    pst1.setString(2, "pricing");
                    if (pst1.executeUpdate() > 0) {
                        System.out.println("Updated New Evaluation Pricing ,Hi");
                    }
                    
                    pst1 = con.prepareStatement("update evaluation set " + s + "=? where username='" + username + "' and performtype=?");
                    pst1.setDouble(1, valUsage);
                    pst1.setString(2, "usage");
                    if (pst1.executeUpdate() > 0) {
                        System.out.println("Updated New Evaluation Usage ,Hi");
                    }
                } else {
                    System.out.println("Inserted Into Evaluation Table");
                    PreparedStatement pst1 = null;
                    if (schema.equalsIgnoreCase("JAVA")) {
                        pst1 = con.prepareStatement("insert into evaluation(username,performtype,java,dotnet,javascript,php)values(?,?,?,?,?,?)");
                        pst1.setString(1, username);
                        pst1.setString(2, "time");
                        pst1.setInt(3, Integer.parseInt(time));
                        pst1.setInt(4, 0);
                        pst1.setInt(5, 0);
                        pst1.setInt(6, 0);
                        if (pst1.executeUpdate() > 0) {
                            System.out.println("Inserted New Evaluation Time");
                        }
                        pst1 = con.prepareStatement("insert into evaluation(username,performtype,java,dotnet,javascript,php)values(?,?,?,?,?,?)");
                        pst1.setString(1, username);
                        pst1.setString(2, "pricing");
                        pst1.setInt(3, Integer.parseInt(cost));
                        pst1.setInt(4, 0);
                        pst1.setInt(5, 0);
                        pst1.setInt(6, 0);
                        if (pst1.executeUpdate() > 0) {
                            System.out.println("Inserted New Evaluation Pricing");
                        }
                        pst1 = con.prepareStatement("insert into evaluation(username,performtype,java,dotnet,javascript,php)values(?,?,?,?,?,?)");
                        pst1.setString(1, username);
                        pst1.setString(2, "usage");
                        pst1.setDouble(3, Double.parseDouble(usage));
                        pst1.setDouble(4, 0);
                        pst1.setDouble(5, 0);
                        pst1.setDouble(6, 0);
                        if (pst1.executeUpdate() > 0) {
                            System.out.println("Inserted New Evaluation Usage");
                        }
                    } else if (schema.equalsIgnoreCase("DOTNET")) {
                        pst1 = con.prepareStatement("insert into evaluation(username,performtype,java,dotnet,javascript,php)values(?,?,?,?,?,?)");
                        pst1.setString(1, username);
                        pst1.setString(2, "time");
                        pst1.setInt(3, 0);
                        pst1.setInt(4, Integer.parseInt(time));
                        pst1.setInt(5, 0);
                        pst1.setInt(6, 0);
                        if (pst1.executeUpdate() > 0) {
                            System.out.println("Inserted New Evaluation Time");
                        }
                        pst1 = con.prepareStatement("insert into evaluation(username,performtype,java,dotnet,javascript,php)values(?,?,?,?,?,?)");
                        pst1.setString(1, username);
                        pst1.setString(2, "pricing");
                        pst1.setInt(3, 0);
                        pst1.setInt(4, Integer.parseInt(cost));
                        pst1.setInt(5, 0);
                        pst1.setInt(6, 0);
                        if (pst1.executeUpdate() > 0) {
                            System.out.println("Inserted New Evaluation Pricing");
                        }
                        pst1 = con.prepareStatement("insert into evaluation(username,performtype,java,dotnet,javascript,php)values(?,?,?,?,?,?)");
                        pst1.setString(1, username);
                        pst1.setString(2, "usage");
                        pst1.setDouble(3, 0);
                        pst1.setDouble(4, Double.parseDouble(usage));
                        pst1.setDouble(5, 0);
                        pst1.setDouble(6, 0);
                        if (pst1.executeUpdate() > 0) {
                            System.out.println("Inserted New Evaluation Usage");
                        }
                    } else if (schema.equalsIgnoreCase("JAVASCRIPT")) {
                        pst1 = con.prepareStatement("insert into evaluation(username,performtype,java,dotnet,javascript,php)values(?,?,?,?,?,?)");
                        pst1.setString(1, username);
                        pst1.setString(2, "time");
                        pst1.setInt(3, 0);
                        pst1.setInt(4, 0);
                        pst1.setInt(5, Integer.parseInt(time));
                        pst1.setInt(6, 0);
                        if (pst1.executeUpdate() > 0) {
                            System.out.println("Inserted New Evaluation Time");
                        }
                        pst1 = con.prepareStatement("insert into evaluation(username,performtype,java,dotnet,javascript,php)values(?,?,?,?,?,?)");
                        pst1.setString(1, username);
                        pst1.setString(2, "pricing");
                        pst1.setInt(3, 0);
                        pst1.setInt(4, 0);
                        pst1.setInt(5, Integer.parseInt(cost));
                        pst1.setInt(6, 0);
                        if (pst1.executeUpdate() > 0) {
                            System.out.println("Inserted New Evaluation Pricing");
                        }
                        pst1 = con.prepareStatement("insert into evaluation(username,performtype,java,dotnet,javascript,php)values(?,?,?,?,?,?)");
                        pst1.setString(1, username);
                        pst1.setString(2, "usage");
                        pst1.setDouble(3, 0);
                        pst1.setDouble(4, 0);
                        pst1.setDouble(5, Double.parseDouble(usage));
                        pst1.setDouble(6, 0);
                        if (pst1.executeUpdate() > 0) {
                            System.out.println("Inserted New Evaluation Usage");
                        }
                    } else if (schema.equalsIgnoreCase("PHP")) {
                        pst1 = con.prepareStatement("insert into evaluation(username,performtype,java,dotnet,javascript,php)values(?,?,?,?,?,?)");
                        pst1.setString(1, username);
                        pst1.setString(2, "time");
                        pst1.setInt(3, 0);
                        pst1.setInt(4, 0);
                        pst1.setInt(5, 0);
                        pst1.setInt(6, Integer.parseInt(time));
                        if (pst1.executeUpdate() > 0) {
                            System.out.println("Inserted New Evaluation Time");
                        }
                        pst1 = con.prepareStatement("insert into evaluation(username,performtype,java,dotnet,javascript,php)values(?,?,?,?,?,?)");
                        pst1.setString(1, username);
                        pst1.setString(2, "pricing");
                        pst1.setInt(3, 0);
                        pst1.setInt(4, 0);
                        pst1.setInt(5, 0);
                        pst1.setInt(6, Integer.parseInt(cost));
                        if (pst1.executeUpdate() > 0) {
                            System.out.println("Inserted New Evaluation Pricing");
                        }
                        pst1 = con.prepareStatement("insert into evaluation(username,performtype,java,dotnet,javascript,php)values(?,?,?,?,?,?)");
                        pst1.setString(1, username);
                        pst1.setString(2, "usage");
                        pst1.setDouble(3, 0);
                        pst1.setDouble(4, 0);
                        pst1.setDouble(5, 0);
                        pst1.setDouble(6, Double.parseDouble(usage));
                        if (pst1.executeUpdate() > 0) {
                            System.out.println("Inserted New Evaluation Usage");
                        }
                    }

                }

              
                System.out.println("Inserted Into Download Table");
                PreparedStatement pst1 = con.prepareStatement("insert into downloads(username,schema_name,files,time,usages,pricing) values(?,?,?,?,?,?)");
                pst1.setString(1, username);
                pst1.setString(2, schema);
                pst1.setString(3, files);
                pst1.setString(4, time);
                pst1.setString(5, usage);
                pst1.setString(6, cost);
                if (pst1.executeUpdate() > 0) {
                    System.out.println("inserted");

                } else {
                    System.out.println("not inserted");
                }
            } else {

                System.out.println("Wrong");
                PrintWriter out1= response.getWriter();
                out1.println("<html>");
                    out1.println("<head>");
                    out1.print("<script language='JavaScript'>alert('Wrong Master Key ');</script>");
                    out1.println("<script> location.replace('HomePage.jsp'); </script>");
                    out1.println("</head>");
                    out1.println("</html>");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    private double getPerformValue(String username, String perform, String schema) {
        double v = 0.0;
        try {
            PreparedStatement ev = con.prepareStatement("select * from evaluation where username='" + username + "' and performtype='" + perform + "'");
            ResultSet rv = ev.executeQuery();
            rv.next();
            if (schema.equalsIgnoreCase("java")) {
                v = rv.getDouble("java");
            } else if (schema.equalsIgnoreCase("dotnet")) {
                v = rv.getDouble("dotnet");
            } else if (schema.equalsIgnoreCase("javascript")) {
                v = rv.getDouble("javascript");
            } else if (schema.equalsIgnoreCase("php")) {
                v = rv.getDouble("php");
            }
            return v;
        } catch (SQLException ex) {

            Logger.getLogger(Download.class.getName()).log(Level.SEVERE, null, ex);
            return v;
        }
    }
}
