
package com.Performance.Controller;

import com.Performance.DAO.CloudDAO;
import com.Performance.Form.AccountForm;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class Edit_User extends HttpServlet {

   
    AccountForm MF;
   
   
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
       
        try {
         
            MF = new AccountForm();
            System.out.println("income111");
            
            MF.setUserName(request.getParameter("user").toString().trim());
            MF.setPassword(request.getParameter("pass").toString().trim());
            MF.setGender(request.getParameter("gender").toString().trim());
            MF.setAddress(request.getParameter("address").toString().trim());
            MF.setCountry(request.getParameter("country").toString().trim());
            MF.setCity(request.getParameter("city").toString().trim());
            MF.setMobileNo(request.getParameter("mobile").toString().trim());
            MF.setEmailId(request.getParameter("email").toString().trim());
       
            int i = new CloudDAO().Edit(MF);
            System.out.println("income222222");

            if (i > 0) {
                out.println("<html>"
                        + "<head>"
                        + "<title>"
                        + "Alert Message"
                        + "</title>");
                out.print("<script language='JavaScript'>alert('Successfully Your Updated.');</script>");
                out.println("<script> location.replace('UserDetail.jsp');</script>"
                + "</head>" );
                out.println("</html>");
           

            } else {
                out.println("<html>"
                        + "<head>"
                        + "<title>"
                        + "Alert Message"
                        + "</title>");
                out.print("<script language='JavaScript'>alert('Not Updated !.');</script>");
                out.println("<script> location.replace('UserEdit.jsp');</script>"
                	+ "</head>" );
                out.println("</html>");

            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        
       
    }

   
}
