package com.Performance.DAO;

import com.Performance.Connection.ConnectionFactory;
import com.Performance.Form.AccountForm;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class CloudDAO {

    private PreparedStatement pst = null;
    private Connection connection = null;
    private int result = 0;
    private ResultSet rst = null;
    private boolean check;

    public int AddViewDetail(AccountForm MF) {

        try {
            connection = ConnectionFactory.getConnection();
            pst = connection.prepareStatement("insert into user(username,password,gender,address,country,city,mobile,emailid,space,cloudid,permission,cloudusage,cost)values(?,?,?,?,?,?,?,?,?,?,?,?,?)");
            pst.setString(1, MF.getUserName());
            pst.setString(2, MF.getPassword());
            pst.setString(3, MF.getGender());
            pst.setString(4, MF.getAddress());
            pst.setString(5, MF.getCountry());
            pst.setString(6, MF.getCity());
            pst.setString(7, MF.getMobileNo());
            pst.setString(8, MF.getEmailId());
            pst.setString(9, MF.getCloudSpace());
            pst.setString(10, MF.getCloudid());
            pst.setString(11, MF.getPermission());
            pst.setString(12, MF.getCloudusage());
            pst.setString(13, MF.getCost());
            
            result = pst.executeUpdate();


        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return result;
    }

    public AccountForm memberCheck(AccountForm MF) {


        try {
            connection = ConnectionFactory.getConnection();
            pst = connection.prepareStatement("select * from user where username='" + MF.getUserName() + "' and password='" + MF.getPassword() + "'");
            rst = pst.executeQuery();
            check = rst.next();
            if (!check) {
                MF.setValid(false);
            } else if (check) {

                String username = rst.getString(2);
                String password = rst.getString(3);
                String Space=rst.getString(10);
                String Cloudid=rst.getString(11);
                String Permission=rst.getString(12);

                MF.setUserName(username);
                MF.setPassword(password);
                MF.setCloudSpace(Space);
                MF.setCloudid(Cloudid);
                MF.setPermission(Permission);
                MF.setValid(true);
            }

        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

        return MF;
    }

    public int loginTime(AccountForm MF) {
        try {
            connection = ConnectionFactory.getConnection();
            pst = connection.prepareStatement("insert into logout(username,timein,timeout)values(?,?,?)");
            pst.setString(1, MF.getUserName());
            pst.setString(2, MF.getLogin_in());
            pst.setString(3, MF.getLogin_out());
            result = pst.executeUpdate();

        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

        return result;
    }
    
      public int Edit(AccountForm MF) {

        try {
           
            connection = ConnectionFactory.getConnection();
            pst = connection.prepareStatement("update user set username='"+MF.getUserName()+"', password='"+MF.getPassword()+"',gender='"+MF.getGender()+"',address='"+MF.getAddress()+"',country='"+MF.getCountry()+"',city='"+MF.getCity()+"',mobile='"+MF.getMobileNo()+"',emailid='"+MF.getEmailId()+"' where username='"+MF.getUserName()+"'");
            result = pst.executeUpdate();
                               } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return result;
    }

    
}