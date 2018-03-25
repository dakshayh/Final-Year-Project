<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="com.Performance.Connection.ConnectionFactory"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
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
<script language="javascript">
            function validat(s,college,city,key){
                if (s.value == ""){
                    document.getElementById("errorBoxName").innerHTML = "Enter the College Name";
                    document.forms["signinform"]["s"].focus() ;
                    return false;
                }
                if (college.value == ""){
                    document.getElementById("errorBoxName").innerHTML = "Enter the College Name";
                    document.forms["signinform"]["college"].focus() ;
                    return false;
                }
                if (city.value == ""){
                    document.getElementById("errorBoxName").innerHTML = "Enter the City";
                    document.forms["signinform"]["city"].focus() ;
                    return false;
                }
                if (key.value == ""){
                    document.getElementById("errorBoxName").innerHTML = "Enter the Master Key";
                    document.forms["signinform"]["key"].focus() ;
                    return false;
                }
                 

            }
        </script>
        <script type="text/javascript" src="js/jquery-1-4-2.min.js"></script> 
        <link rel="stylesheet" href="css/slimbox2.css" type="text/css" media="screen" /> 
        <script type="text/JavaScript" src="js/slimbox2.js"></script> 
        <script lang="javascript">
    
            function DeleteRecord(id){
                var f=document.forms;
                f.method="post";
                f.action='DeleteFiles.jsp?id='+id;
                f.submit();
            }

            function ActiveRecord(id){
                var f=document.forms;
                f.method="post";
                f.action='ServerCal.jsp?id='+id;
                f.submit();
            }

        </script>

        <link rel="stylesheet" href="css/bootstrap.css"/>
        <link rel="stylesheet" href="css/bootstrap-responsive.css" />
        <script type="text/javascript" src="js/bootstrapValidator.js"></script>
        <script type="text/javascript" src="js/jquery-1.4.2.min.js" ></script>
        <script src="/js/jquery.min.js"></script>
        <script src="/js/bootstrap.min.js"></script> 
<style>
    table { 
  margin: 10px 0 30px 0;
}

table tr th, table tr td { 
  background: black;
  color: #FFF;
  padding: 7px 4px;
  text-align: left;
}
.list{ 
  background: #BBB;
  color: #444;
  border-top: 1px solid #FFF;
}  
table tr td { 
  background: white;
  color: #444;
  border-top: 1px solid #FFF;
}
label{
    font-size: larger;
}
</style>
    </head>
    <body>
        <div id="templatemo_body_wrapper">
            <div id="templatemo_wrapper"><span id="templatemo_wrapper_top"></span>
                <div id="templatemo_header">    
                    <div id="site_title"><%@include  file="projectname.html" %> </div>
                    <div id="templatemo_menu" class="ddsmoothmenu">
                        <ul> <li><a href="HomePage.jsp" >Home</a></li>
                            <li><a href="Report.jsp">Report</a></li>
                            <li><a href="Searching.jsp" class="selected">Searching</a></li>
                            <li><a href="UserDetail.jsp">Profile</a></li>

                            <li><a href="Logout.jsp">Logout</a></li>
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
                    <p>&nbsp;</p>                   
                        <%
                            Connection connection = null;
                            PreparedStatement pst = null;
                            ResultSet rs = null;
                            String id = request.getParameter("id");
                            System.out.println("ID :"+id);
                            connection = ConnectionFactory.getConnection();
                            pst = connection.prepareStatement("select * from datatable where id='" + id + "'");
                            rs = pst.executeQuery();
                            rs.next();
                        %>
                        <h1>View Details</h1>
                        <form action="Download" name="signinform" method="post" autocomplete="off">
                            <div id="errorBoxName" style="color: red;"></div>
                            <table>
                                <tr>
                                    <td>   <label>Schema Name&nbsp;<font color="red">*</font>  :</label></td>
                                    <td>  <input type="text" name="s" id="s" value="<%=rs.getString(2)%>" size="35"   autocomplete="off"  readonly="off" /></td>

                                </tr>
                                <tr>
                                    <td>  <label>File Name&nbsp;<font color="red">*</font>  :</label> </td>
                                    <td>   <input type="text" name="college" id="college"  value="<%=rs.getString(8)%>" size="35"  readonly="off" /></td>
                                    <td>   <input type="hidden" name="id" value="<%=rs.getString(1)%>"/></td>
                                    

                                </tr>
                                <tr>
                                    <td>   <label>File Size&nbsp;<font color="red">*</font>  :</label></td>
                                    <td>  <input type="text" name="city" id="city" value="<%=rs.getString(7)%>" size="35"   autocomplete="off"  readonly="off" /></td>

                                </tr>

                                <tr>
                                    <td>   <label>Master Key&nbsp;<font color="red">*</font>  :</label></td>
                                    <td>  <input type="password" name="key" id="key" value="" size="35"   autocomplete="off" placeholder=" Enter master key"/></td>

                                </tr>
                            </table>
                            <p>
                                <input class="formbutton"  style="margin-left: 180px;"  name="submit" type="submit" id="submit" value=" DOWNLOAD " onclick="return validat(s,college,city,key);" />
                                &nbsp;
                                <input name="reset"  class="formbutton" type="reset" id="reset" tabindex="5" value="CLEAR" />
                            </p>
                        </form>
                    <div class="cleaner"></div>
                </div>
            </div>
        </div>

        <script type='text/javascript' src='js/logging.js'></script>
    </body>
</html>