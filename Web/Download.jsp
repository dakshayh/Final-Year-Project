
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.DataInputStream"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.io.File"%>
<%@page import="com.Performance.Connection.ConnectionFactory"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
    <head>
    </head>
</body>

<%
 int BUFSIZE = 4096;
     String str = "";
    String originalpath = "";
    String member = "";
    String user;
    String fileName;
    File file;
    int length;
    ServletOutputStream outStream;
    ServletContext context;
    String mimetype;
    Connection con = null;
    String files;
    
    String id = request.getParameter("id");
        String masterkey = request.getParameter("key");
        String schema = request.getParameter("s");
        System.out.println("schema :" + schema);
        System.out.println("key :" + masterkey);
        System.out.println("id :" + id);
        
            con = ConnectionFactory.getConnection();
            PreparedStatement pst = con.prepareStatement("select * from schematable where name='" + schema + "' and masterkey='" + masterkey + "'");
            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                PreparedStatement pst2 = con.prepareStatement("select * from datatable where id='" + id + "'");
                ResultSet rs1 = pst2.executeQuery();
                rs1.next();
                user = rs1.getString(2);
                member = rs1.getString(9);
                originalpath = rs1.getString(3);
                files = rs1.getString(8);


                DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
                Date date = new Date();

                file = new File(originalpath);

                PreparedStatement pst1 = con.prepareStatement("insert into downloads(username,files,timein,memberid)values(?,?,?,?)");
                pst1.setString(1, user);
                pst1.setString(2, files);
                pst1.setString(3, dateFormat.format(date));
                pst1.setString(4, member);
                pst1.executeUpdate();


                length = 0;

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


            } else {
                System.out.println("Wrong");
                 
            }

%>     
</form>
</body>
</html>
