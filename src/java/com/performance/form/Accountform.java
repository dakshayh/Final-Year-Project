
package com.Performance.Form;


public class AccountForm {
       
        private String UserName;
	private String Password;
	private String Address;
        private String Gender;
        private String CloudSpace;
        private String Country;
        private String Login_in;
        private int id;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getCloudid() {
        return Cloudid;
    }

    public void setCloudid(String Cloudid) {
        this.Cloudid = Cloudid;
    }
        private String Login_out;
        private String City;
	private String MobileNo;
	private String EmailId;
        private String Cloudid;
        private String Permission;
        private String cloudusage;
        private String cost;

    public String getCloudusage() {
        return cloudusage;
    }

    public void setCloudusage(String cloudusage) {
        this.cloudusage = cloudusage;
    }

    public String getCost() {
        return cost;
    }

    public void setCost(String cost) {
        this.cost = cost;
    }
      
  

    public String getPermission() {
        return Permission;
    }

    public void setPermission(String Permission) {
        this.Permission = Permission;
    }

    public String getCloudSpace() {
        return CloudSpace;
    }

    public void setCloudSpace(String CloudSpace) {
        this.CloudSpace = CloudSpace;
    }

    public String getLogin_in() {
        return Login_in;
    }

    public void setLogin_in(String Login_in) {
        this.Login_in = Login_in;
    }

    public String getLogin_out() {
        return Login_out;
    }

    public void setLogin_out(String Login_out) {
        this.Login_out = Login_out;
    }
       

    public String getCountry() {
        return Country;
    }

    public void setCountry(String Country) {
        this.Country = Country;
    }

    public String getGender() {
        return Gender;
    }

    public void setGender(String Gender) {
        this.Gender = Gender;
    }

    
        private boolean valid;

    public String getAddress() {
        return Address;
    }

    public void setAddress(String Address) {
        this.Address = Address;
    }

    public String getCity() {
        return City;
    }

    public boolean isValid() {
        return valid;
    }

    public void setValid(boolean valid) {
        this.valid = valid;
    }

    public void setCity(String City) {
        this.City = City;
    }

    public String getEmailId() {
        return EmailId;
    }

    public void setEmailId(String EmailId) {
        this.EmailId = EmailId;
    }

    public String getMobileNo() {
        return MobileNo;
    }

    public void setMobileNo(String MobileNo) {
        this.MobileNo = MobileNo;
    }

    public String getPassword() {
        return Password;
    }

    public void setPassword(String Password) {
        this.Password = Password;
    }

    public String getUserName() {
        return UserName;
    }

    public void setUserName(String UserName) {
        this.UserName = UserName;
    }

  

  
	
	
        
        
        
        
    
}
