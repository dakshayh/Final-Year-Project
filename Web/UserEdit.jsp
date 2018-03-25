<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="com.Performance.Connection.ConnectionFactory"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title>
<meta name="keywords" content="beauty class, free theme, website design, bokehs, pink, orange, templatemo, CSS, HTML" />
<meta name="description" content="Beauty Class Theme, pinky background gradient with bokehs, free CSS template provided by templatemo.com" />
<link href="css/templatemo_style.css" rel="stylesheet" type="text/css" />

<link rel="stylesheet" href="css/nivo-slider.css" type="text/css" media="screen" />
<link rel="stylesheet" type="text/css" href="css/ddsmoothmenu.css" />

<script language="javascript" type="text/javascript">
function clearText(field)
{
    if (field.defaultValue == field.value) field.value = '';
    else if (field.value == '') field.value = field.defaultValue;
}
</script>

<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/ddsmoothmenu.js">
</script>

<script type="text/javascript">

ddsmoothmenu.init({
	mainmenuid: "templatemo_menu", //menu DIV id
	orientation: 'h', //Horizontal or vertical menu: Set to "h" or "v"
	classname: 'ddsmoothmenu', //class added to menu's outer DIV
	//customtheme: ["#1c5a80", "#18374a"],
	contentsource: "markup" //"markup" or ["container_id", "path_to_menu_file"]
})

</script>

<script type="text/javascript" src="js/jquery-1-4-2.min.js"></script> 
<link rel="stylesheet" href="css/slimbox2.css" type="text/css" media="screen" /> 
<script type="text/JavaScript" src="js/slimbox2.js"></script> 

          
        <script type="text/javascript">
            $(document).ready(function() {
                $('#country').change(function(event) {  
                    var $countr=$("select#country").val();
                    $.get('CitySearch',{countryname:$countr},function(responseJson) {   
                        var $select = $('#city');                           
                        $select.find('option').remove();                          
                        $.each(responseJson, function(key, value) {               
                            $('<option/>').text(value).appendTo($select);      
                        });
                    });
                });
            });

        </script>

        <script type="text/javascript">
            $(document).ready(function() {
                $('#attributeForm').bootstrapValidator();
            });
        </script>    
        <link rel="stylesheet" href="css/bootstrap.css"/>
        <link rel="stylesheet" href="css/bootstrap-responsive.css" />
        <script type="text/javascript" src="js/bootstrapValidator.js"></script>
        <script type="text/javascript" src="js/jquery-1.4.2.min.js" ></script>
        <script src="/js/jquery.min.js"></script>
        <script src="/js/bootstrap.min.js"></script> 

   
</head>
<body>

<div id="templatemo_body_wrapper">
    <div id="templatemo_wrapper"><span id="templatemo_wrapper_top"></span>
        <div id="templatemo_header">    
            <div id="site_title"><%@include  file="projectname.html" %> </div>
            <div id="templatemo_menu" class="ddsmoothmenu">
                <ul> <li><a href="IndexPage.jsp" class="selected">Home</a></li>
                        <li><a href="UserRegister.jsp">Cloud Create</a></li>
                        <li><a href="">Cost of Cloud</a></li>
                        <li><a href="Searching.jsp">Searching the Files</a></li>
                        <li><a href="UserLogin.jsp">Login</a></li>
                </ul>
                <br style="clear: left" />
            </div> <!-- end of templatemo_menu -->
            <a href="#" title="Télécharger la photo" rel="nofollow" class="templatemo_header_img" target="_blank">Back to Homepage</a>
        </div>
        <div id="templatemo_slider">
           <div id="slider-wrapper">
                <div id="slider" class="nivoSlider">
                    <img src="images/slider/01.jpg" alt="Slider 01"  />
                    <a href="#"><img src="images/slider/02.jpg" alt="Slider 02" /></a>
                    <img src="images/slider/03.jpg" alt="Slider 03"  />
                    <img src="images/slider/04.jpg" alt="Slider 04"  />
                    <img src="images/slider/05.jpg" alt="Slider 05"  />
                </div>
                <div id="htmlcaption" class="nivo-html-caption">
                   
                </div>
            </div>
            <script type="text/javascript" src="js/jquery-1.4.3.min.js"></script>
            <script type="text/javascript" src="js/jquery.nivo.slider.pack.js"></script>
            <script type="text/javascript">
            $(window).load(function() {
                $('#slider').nivoSlider();
            });
            </script>
        </div>
        <div id="templatemo_main">
            <h2 align="center" style="font-family: 'Time New Roman';font-size: 15pt;color: blue;font-style: italic">Edit Profile</h2>
                <p>&nbsp;</p>


                <%

                    Connection con = null;
                    String idvalue = request.getParameter("id").toString().trim();
                    int id = Integer.parseInt(idvalue);

                    con = ConnectionFactory.getConnection();
                    Statement stmt = con.createStatement();
                    ResultSet rs = stmt.executeQuery("select * from user where id=" + id);

                    while (rs.next()) {


                %>


                <form method="post" class="form-horizontal" name="attributeForm" action="Edit_User" autocomplete="off">

                    <div class="form-group">
                        <label for="UserName" class="col-md-5 control-label"><b>UserName:&nbsp;&nbsp;</b></label>
                        <div class="col-md-3">  
                            <input type="text" class="form-control" id="username" name="user" value="<%=rs.getString(2)%>"  placeholder="Enter the UserName" required>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="Password" class="col-md-5 control-label"><b>Password:&nbsp;&nbsp;</b></label>  
                        <div class="col-md-3"> 
                            <input type="password" class="form-control" id="password" name="pass" placeholder="Enter the Password" required>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="gender" class="col-md-5 control-label"><b>Gender:</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
                        <div class="col-md-3">
                            <label><b>  Male </b></label>
                            <input type="radio" name="gender" value="Male" />
                            <label><b> Female</b></label>
                            <input type="radio" name="gender" value="Female" />
                        </div>
                    </div>


                    <div class="form-group">
                        <label class="col-md-5 control-label"><b>Address:</b>&nbsp;&nbsp;&nbsp;&nbsp;</label>
                        <div class="col-md-3"> 
                            <textarea rows="2" cols="16" class="form-control" id="address" name="address" placeholder="Enter the Address" required><%=rs.getString(5)%></textarea>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-md-5 control-label"><b>Country:</b>&nbsp;&nbsp;&nbsp;&nbsp;</label>
                        <div class="col-md-3">
                            <select id="country" name="country" class="form-control">
                                <option selected="selected">Select Country</option>
                                <option value="India">India</option>
                                <option value="US">US</option>
                            </select>
                        </div>
                    </div>


                    <div class="form-group">
                        <label class="col-md-5 control-label"><b>City: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</b></label>
                        <div class="col-md-3"> 
                            <select id="city" name="city" class="form-control">
                                <option selected="selected">Select City</option>
                            </select>
                        </div>
                    </div>


                    <div class="form-group">
                        <label class="col-md-5 control-label"><b>Mobile No: &nbsp;&nbsp;</b></label>
                        <div class="col-md-3"> 
                            <input type="text" class="form-control"  maxlength="10" placeholder=" Enter the Mobile No" name="mobile"
                                   data-bv-notempty="true" value="<%=rs.getString(8)%>"
                                   data-bv-notempty-message="The Mobile No is required and cannot be empty"  required="required"/>
                        </div>
                    </div>


                    <div class="form-group">
                        <label class="col-md-5 control-label"><b>Email id: &nbsp;&nbsp;&nbsp;&nbsp;</b></label>
                        <div class="col-md-3"> 
                            <input type="text" class="form-control" name="email" placeholder=" Enter the Email Id"
                                   data-bv-notempty="true" value="<%=rs.getString(9)%>"
                                   data-bv-notempty-message="The Email Id is required and cannot be empty"  required="required"/>
                        </div>
                    </div>
                    <%
                        }


                    %>

                    <div class="form-group">
                        <div class="col-sm-offset-5 col-md-15">
                            <button type="submit" class="btn btn-default" style="height: 30px;width: 100px">Edit</button>
                            <button type="reset" class="btn btn-default" style="height: 30px;width: 100px">Clear</button>
                        </div>
                    </div>


                </form>
           


     <div class="cleaner"></div>
        </div>
    </div>
</div>
    
 <script type='text/javascript' src='js/logging.js'></script>
</body>
</html>