
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
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class PublicDownload extends HttpServlet {

    static final long serialVersionUID = 1L;
    private static final int BUFSIZE = 4096;
    String str="";
    String originalpath="";
    String owner="";
    String user;
    String fileName;
    File file;
    int length; 
    ServletOutputStream outStream;
    ServletContext context;
    String mimetype;
    Connection con=null;
    String keys;
   
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        user=request.getParameter("user").toString().trim();
        owner=request.getParameter("owner").toString().trim(); 
        originalpath=request.getParameter("path").toString().trim();
        System.out.println(originalpath);
        keys=request.getParameter("key").toString().trim();
              
        try
        {
            
        con = ConnectionFactory.getConnection();
       
        DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
        Date date = new Date();
    
        file = new File(originalpath);
        
        PreparedStatement pst1=con.prepareStatement("insert into publicdownload(username,owner,file,datetime,downloadkey)values(?,?,?,?,?)");
        pst1.setString(1, user);
        pst1.setString(2, owner);
        pst1.setString(3, originalpath);
        pst1.setString(4, dateFormat.format(date));
        pst1.setString(5, keys);
        pst1.executeUpdate();
       
        
        length   = 0;
        
        outStream = response.getOutputStream();
        
        context  = getServletConfig().getServletContext();
        
        mimetype = context.getMimeType(originalpath);
        
        response.setContentType(mimetype);
        
        response.setContentLength((int)file.length());
        
        fileName = (new File(originalpath)).getName();
   
        if (fileName.trim().equalsIgnoreCase("txt"))
        {
        response.setContentType("text/plain" );
        
        }
        else if (fileName.trim().equalsIgnoreCase("doc"))
        {
        response.setContentType("application/msword" );
        }
        else if (fileName.trim().equalsIgnoreCase("xls"))
        {
        response.setContentType("application/vnd.ms-excel");
        }
        else if (fileName.trim().equalsIgnoreCase("pdf"))
        {
        response.setContentType("application/pdf");
        }
        
        else
        {
           
        response.setContentType( "application/octet-stream" );
        }

       
        response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");
        
        byte[] byteBuffer = new byte[BUFSIZE];
        
        DataInputStream in = new DataInputStream(new FileInputStream(file));
       
        while ((in != null) && ((length = in.read(byteBuffer)) != -1))
        {
            outStream.write(byteBuffer,0,length);
        }
        
      
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        
    }

  
}
