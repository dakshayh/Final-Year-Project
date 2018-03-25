<%@page import="com.Performance.Controller.AdminControll"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.Performance.Connection.ConnectionFactory"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
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
            function validat(college,city){

                if (college.value == ""){
                    document.getElementById("errorBoxName").innerHTML = "Enter the Schema Name";
                    document.forms["signinform"]["college"].focus() ;
                    return false;
                }
                if (city.value == ""){
                    document.getElementById("errorBoxName").innerHTML = "Enter the Master Key";
                    document.forms["signinform"]["city"].focus() ;
                    return false;
                }
                

            }
        </script>
        <script type="text/javascript" src="js/jquery-1-4-2.min.js"></script> 
        <link rel="stylesheet" href="css/slimbox2.css" type="text/css" media="screen" /> 
        <script type="text/JavaScript" src="js/slimbox2.js"></script> 

    </head>
    <body>

        <div id="templatemo_body_wrapper">
            <div id="templatemo_wrapper"><span id="templatemo_wrapper_top"></span>
                <div id="templatemo_header">    
                    <div id="site_title"><%@include  file="projectname.html" %></div>
                    <div id="templatemo_menu" class="ddsmoothmenu">
                        <ul> <li><a href="Administrator.jsp" >Home</a></li>
                            <li><a href="UserView.jsp">User Details</a></li>
                            <li><a href="addDatabaseschema.jsp" class="selected">Schema</a></li>
                            <li><a href="addSchemaData.jsp">SchemaData</a></li>
                             <li><a href="downloadDeatils.jsp"> &nbsp;Downloads</a></li>
                                   
                            <li><a href="AdminLogout.jsp">Logout</a></li>
                        </ul>
                        <br style="clear: left" />
                    </div> <!-- end of templatemo_menu -->
                    <a href="#" title="Télécharger la photo" rel="nofollow" class="templatemo_header_img" target="_blank">Back to Homepage</a>
                </div>
                <div id="templatemo_slider">
                    <div id="slider-wrapper">

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


                    <%
                            
                        DateFormat dateFormat = new SimpleDateFormat("hh:mm:ss a ");
                        Date date = new Date();
                        String logintime = dateFormat.format(date);

                    %>


                    <table>
                        <tr>
                            <td style="color:blue;font-family: 'Time New Roman';font-size: 15pt;font-style: italic">MR/MS: <%="Administrator"%> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <%=logintime%></td>
                        </tr>
                    </table>

                    <br>
                        <br>
                            <br>
                                <br>
                                    <br>
                                        <center>
                                            <h1>Update Database Schema</h1>
                                            <form action="addDatabaseschema.jsp" name="signinform" method="post" autocomplete="off">
                                                <div id="errorBoxName" style="color: red;"></div>
                                                <table>

                                                    <tr>
                                                        <td>  <label>Schema Name&nbsp;<font color="red">*</font>  :</label> </td>
                                                        <td>   
                                                            <select style="width: 260px;" tabindex="10" name="college" id="college">
                                                                <option>--Select--</option>
                                                                <%
                                                                    ResultSet rsCollege = new AdminControll().getSchema();
                                                                    while (rsCollege.next()) {
                                                                %>
                                                                <option><%=rsCollege.getString(2)%></option>
                                                                <%
                                                                    }
                                                                %>                                 
                                                            </select>
                                                        </td>

                                                    </tr>
                                                    <tr>
                                                        <td>   <label>Master Key&nbsp;<font color="red">*</font>  :</label></td>
                                                        <td>  <input type="text" name="city" id="city" value="" size="35"   autocomplete="off"  /></td>

                                                    </tr>


                                                </table>
                                                <p>
                                                    <input class="formbutton"  style="margin-left: 180px;"  name="submit" type="submit" id="submit" value=" SUBMIT " onclick="return validat(college,city);" />
                                                    &nbsp;
                                                    <input name="reset"  class="formbutton" type="reset" id="reset" tabindex="5" value="CLEAR" />
                                                </p>


                                            </form> 
                                        </center>

                                        <p>&nbsp;</p>
                                        <p>&nbsp;</p>
                                        <p>&nbsp;</p>
                                        <p>&nbsp;</p>
                                        <p>&nbsp;</p>
                                        <div class="cleaner"></div>
                                        </div>
                                        </div>
                                        </div>

                                        <script type='text/javascript' src='js/logging.js'></script>
                                        </body>
                                        </html>

                                        <%   if ("POST".equals(request.getMethod())) {
                                                Connection con = ConnectionFactory.getConnection();

                                                //PreparedStatement userStmnt = con.prepareStatement("insert into schematable(name,masterkey) values('" + request.getParameter("college").toUpperCase() + "','" + request.getParameter("city") + "');");
                                                PreparedStatement userStmnt = con.prepareStatement("update schematable set masterkey='" + request.getParameter("city") + "' where name='" + request.getParameter("college").toUpperCase() + "'");
                                                if (userStmnt.executeUpdate() > 0) {
                                                    out.println("<html>");
                                                    out.println("<head>");
                                                    out.print("<script language='JavaScript'>alert('Schema  Details Updated Successfully...  ');</script>");
                                                    out.println("<script> location.replace('addDatabaseschema.jsp'); </script>");
                                                    out.println("</head>");
                                                    out.println("</html>");
                                                } else {
                                                    out.println("<html>");
                                                    out.println("<head>");
                                                    out.print("<script language='JavaScript'>alert('Error Occurred...  ');</script>");
                                                    out.println("<script> location.replace('addDatabaseschema.jsp'); </script>");
                                                    out.println("</head>");
                                                    out.println("</html>");
                                                }
                                            }
                                        %>



