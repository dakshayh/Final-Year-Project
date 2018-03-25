
package com.Performance.Controller;

import com.Performance.DAO.CloudDAO;
import com.Performance.Form.AccountForm;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.fileupload.FileItem;

public class User_Register extends HttpServlet {
    private String memberkey;
    private String permission="NO";
    private String cloud="Null";
    AccountForm MF;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        try {
          

            MF = new AccountForm();
            MF.setUserName(request.getParameter("user").toString().trim());
            MF.setPassword(request.getParameter("pass").toString().trim());
            MF.setGender(request.getParameter("gender").toString().trim());
            MF.setAddress(request.getParameter("address").toString().trim());
            MF.setCountry(request.getParameter("country").toString().trim());
            MF.setCity(request.getParameter("city").toString().trim());
            MF.setMobileNo(request.getParameter("mobile").toString().trim());
            MF.setEmailId(request.getParameter("email").toString().trim());
            MF.setCloudSpace(request.getParameter("space").toString().trim());
            MF.setCloudid(cloud);
            MF.setPermission(permission);
            MF.setCloudusage(MF.getCloudSpace());
             
            if(MF.getCloudSpace().equals("25")){
                MF.setCost("20");
            }
            if(MF.getCloudSpace().equals("50")){
                MF.setCost("40");
            }
            if(MF.getCloudSpace().equals("75")){
                MF.setCost("60");
            }
            if(MF.getCloudSpace().equals("100")){
                MF.setCost("80");
            }
           
            int i = new CloudDAO().AddViewDetail(MF);

            if (i > 0) {
                out.println("<html>"
                        + "<head>"
                        + "<title>"
                        + "Alert Message"
                        + "</title>");
                out.print("<script language='JavaScript'>alert('Successfully Your Added.');</script>");
                out.println("<script> location.replace('UserLogin.jsp');</script>"
                + "</head>" );
                out.println("</html>");
           

            } else {
                out.println("<html>"
                        + "<head>"
                        + "<title>"
                        + "Alert Message"
                        + "</title>");
                out.print("<script language='JavaScript'>alert('Not Register !.');</script>");
                out.println("<script> location.replace('UserRegister.jsp');</script>"
                	+ "</head>" );
                out.println("</html>");

            }

        } catch (Exception e) {
            e.printStackTrace();
        }


    }
    
}
