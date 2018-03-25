package com.Performance.Controller;

import com.Performance.DAO.CloudDAO;
import com.Performance.Form.AccountForm;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class User_Login extends HttpServlet {

    private String Encrypt = "Encryption";
    private String Upload = "Upload";
    private String Decrypt = "Decryption";
    private String path = "/home/ubuntu/Proj";
    private String Project = "Performance";
    private String logintime = "";
    Connection connection = null;
    PreparedStatement pst = null;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            HttpSession session = request.getSession(true);

            AccountForm MF = new AccountForm();

            MF.setUserName(request.getParameter("user").toString().trim());
            MF.setPassword(request.getParameter("pass").toString().trim());


            MF = new CloudDAO().memberCheck(MF);


            if (null != MF.getUserName() && null != MF.getPassword() && "Admin".equals(MF.getUserName())
                    && "Admin".equals(MF.getPassword())) {


                File Projects = new File(path + File.separator + Project + File.separator);
                Projects.mkdir();
                String projectpath = Projects.toString();

                File folder = new File(projectpath + File.separator + MF.getUserName());
                folder.mkdir();
                String storevalues = folder.toString();

                File Upfile = new File(storevalues + File.separator + Upload);
                Upfile.mkdir();
                String UP = Upfile.toString();

                File Encryptfolder = new File(storevalues + File.separator + Encrypt);
                Encryptfolder.mkdir();
                String En = Encryptfolder.toString();

                File Decryptfolder = new File(storevalues + File.separator + Decrypt);
                Decryptfolder.mkdir();
                String Dn = Decryptfolder.toString();

                session.setAttribute("upload", UP);
                session.setAttribute("encryption", En);
                session.setAttribute("decryption", Dn);



                out.println("<html>"
                        + "<head>"
                        + "<title>"
                        + "Administrator"
                        + "</title>");
                out.print("<script language='JavaScript'>alert('Welcome to Administrator.');</script>");
                out.println("<script> location.replace('Administrator.jsp');</script>"
                        + "</head>");
                out.println("</html>");


            } else if (null != MF.getUserName() && null != MF.getPassword() && MF.isValid()) {
                System.out.println("1");
                if (MF.getPermission().equals("NO")) {
                    System.out.println("2");
                    out.println("<html>");
                    out.println("<head>");
                    out.print("<script language='JavaScript'>alert('your account has been not activated yet ');</script>");
                    out.println("<script> location.replace('UserLogin.jsp'); </script>");
                    out.println("</head>");
                    out.println("</html>");
                } else {
                    System.out.println("3");
                    System.out.println("Username"+MF.getUserName());
                    session.setAttribute("username", MF.getUserName());
                   // session.setAttribute("cloudid", MF.getCloudid());
                    DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd-hh.mm.ss a");
                    Date date = new Date();
                    logintime = dateFormat.format(date);
                    String loginout = "NO";
                    MF.setUserName(MF.getUserName());
                    MF.setLogin_in(logintime);
                    MF.setLogin_out(loginout);
                    int i = new CloudDAO().loginTime(MF);

                    if (i > 0) {
                        out.println("<html>"
                                + "<head>"
                                + "<title>"
                                + "Record Added"
                                + "</title>");
                        out.print("<script language='JavaScript'>alert('Correct Login.');</script>");
                        out.println("<script> location.replace('HomePage.jsp');</script>"
                                + "</head>");
                        out.println("</html>");
                    }
                }


            } else {
                out.println("<html>"
                        + "<head>"
                        + "<title>"
                        + "Not Login"
                        + "</title>");
                out.print("<script language='JavaScript'>alert('Incorrect Login !.');</script>");
                out.println("<script> location.replace('UserLogin.jsp');</script>"
                        + "</head>");
                out.println("</html>");
            }
        } catch (Exception e) {
            e.getMessage();
        }

    }
}
