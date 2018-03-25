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

    </head>
    <body>

        <div id="templatemo_body_wrapper">
            <div id="templatemo_wrapper"><span id="templatemo_wrapper_top"></span>
                <div id="templatemo_header">    
                    <div id="site_title"><%@include  file="projectname.html" %> </div>
                    <div id="templatemo_menu" class="ddsmoothmenu">
                        <ul> <li><a href="Administrator.jsp">Home</a></li>
                            <li><a href="UserView.jsp" class="selected">User Details</a></li>
                            <li><a href="addDatabaseschema.jsp">Schema</a></li>
                            <li><a href="addSchemaData.jsp">SchemaData</a></li>
                             <li><a href="downloadDeatils.jsp"> &nbsp;Downloads</a></li>
                                      <li><a href="AdminLogout.jsp">Logout</a></li>
                        </ul>
                        <br style="clear: left" />
                    </div> <!-- end of templatemo_menu -->
                    <a href="#" title="Télécharger la photo" rel="nofollow" class="templatemo_header_img" target="_blank">Back to Homepage</a>
                </div>
                <br>
                <br>
                <br>
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
                    <h2 align="center" style="font-family: 'Time New Roman';font-size: 15pt;color: blue;font-style: italic">Cloud User</h2>

                    <p>&nbsp;</p>
                    <form name="forms">          

                        <%

                            Connection connection = null;
                            PreparedStatement pst = null;
                            ResultSet rst = null;
                            try {
                                connection = ConnectionFactory.getConnection();
                                pst = connection.prepareStatement("select * from user");
                                rst = pst.executeQuery();
                        %>
                        <table class="table table-bordered">

                            <tr>

                                <th>UserName</th>
                                <th>Password</th>
                                <th>Address</th>
                                <th>Mail Id</th>
                                <th>Contact No</th>
                                <th>Cloud Space</th>
                                <th>Permission</th>
                                <th>Activation</th>
                                <th>Delete</th>

                            </tr>  

                            <%
                                while (rst.next()) {
                            %>
                            <tr class="success">
                                <td><%=rst.getString(2)%></td>
                                <td><%=rst.getString(3)%></td>
                                <td><%=rst.getString(5)%></td>
                                <td><%=rst.getString(9)%></td>
                                <td><%=rst.getString(8)%></td>
                                <td><%=rst.getString(10)%></td>
                                <td><%=rst.getString(12)%></td>
                                <td><input type="button" value="Active" name="Action" id="Acti" class="btn btn-default" onclick="ActiveRecord(<%=rst.getInt(1)%>);"/></td>
                                <td><input type="button" value="Delete" name="Delete" id="Dele" class="btn btn-default" onclick="DeleteRecord(<%=rst.getInt(1)%>);"/></td>


                            </tr>

                            <%
                                    }
                                } catch (Exception e) {
                                    e.printStackTrace();
                                }

                            %>
                        </table>


                    </form>

                    <form name="Wholefile" action="Administrator.jsp" method="POST">
                        <p align="center">&nbsp;&nbsp;&nbsp;<input type="submit"  class="btn btn-default" value="Back" name="Back" style="height: 30px; width: 100px" /></p>
                    </form>



                    <div class="cleaner"></div>
                </div>
            </div>
        </div>

        <script type='text/javascript' src='js/logging.js'></script>
    </body>
</html>