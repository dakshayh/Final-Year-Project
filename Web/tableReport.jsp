<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.Performance.Controller.AdminControll"%>
<%@page import="com.Performance.Connection.ConnectionFactory"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
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
        <script lang="javascript">
    
            function Back_onclick() 
            {
                window.location.href = "HomePage.jsp";
            }
          
    
    
        </script>
        <script lang="javascript">
    
          
            function Edit_onclick(id) 
            {
                var f=document.userdetails;
                f.method="post";
                f.action='UserEdit.jsp?id='+id;
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
                        <ul> <li><a href="HomePage.jsp">Home</a></li>
                            <li><a href="Report.jsp" class="selected">Report</a></li>
                            <li><a href="Searching.jsp">Searching</a></li>
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

                    <h2 align="center" style="font-family: 'Time New Roman';font-size: 15pt;color: blue;font-style: italic">Cost evaluation Of Cloud Service</h2>

                    <%!
                        ResultSet rst1 = null;
                        ResultSet rst2 = null;
                        ResultSet rst3 = null;
                        ResultSet rst4 = null;
                        ArrayList<Double> lst=new ArrayList<Double>();
                        double timej = 0.0;
                        double pricej = 0.0;
                        double usagej = 0.0;
                        double timed = 0.0;
                        double priced = 0.0;
                        double usaged = 0.0;
                        double timeja = 0.0;
                        double priceja = 0.0;
                        double usageja = 0.0;
                        double timep = 0.0;
                        double pricep = 0.0;
                        double usagep = 0.0;
                        
                        
                        double javaTotalaCost = 0.0;
                        double dotTotalaCost = 0.0;
                        double jsTotalaCost = 0.0;
                        double phpTotalaCost = 0.0;
                        Connection con = null;
                        
                        %>
                        
                        <%
                       
                        String username = (String)session.getAttribute("username");
                      
                        try {

                            con = ConnectionFactory.getConnection();
                            //Statement stmt = con.createStatement();
                            String sql = "select * from downloads where username=? and schema_name=?";
                            PreparedStatement ps = con.prepareStatement(sql);
                            ps.setString(1, username);
                            ps.setString(2, "java");
                            ResultSet rst1=ps.executeQuery();
                            //Statement stmt = con.createStatement();
                           // rst1 = new AdminControll().getDownload(username, "java");
                            
                            while (rst1.next()) {
                                timej = timej + Double.parseDouble(rst1.getString(5));
                                pricej = pricej + Double.parseDouble(rst1.getString(6));
                                usagej = usagej + Double.parseDouble(rst1.getString(7));
                            }
                            javaTotalaCost=timej+pricej+usagej;
                            
                            String sql1 = "select * from downloads where username=? and schema_name=?";
                            PreparedStatement ps1 = con.prepareStatement(sql1);
                            ps1.setString(1, username);
                            ps1.setString(2, "dotnet");
                            ResultSet rst2=ps1.executeQuery();
                                //rst2 = new AdminControll().getDownload(username, "dotnet");
                                while (rst2.next()) {
                                timed = timed + Double.parseDouble(rst2.getString(5));
                                priced = priced + Double.parseDouble(rst2.getString(6));
                                usaged = usaged + Double.parseDouble(rst2.getString(7));
                            }
                            dotTotalaCost=timed+priced+usaged;
                            
                           
                            String sql2 = "select * from downloads where username=? and schema_name=?";
                            PreparedStatement ps2 = con.prepareStatement(sql2);
                            ps2.setString(1, username);
                            ps2.setString(2, "php");
                            ResultSet rst3=ps2.executeQuery();
                            
                                //rst3 = new AdminControll().getDownload(username, "php");
                                while (rst3.next()) {
                                timep = timep + Double.parseDouble(rst3.getString(5));
                                pricep = pricep + Double.parseDouble(rst3.getString(6));
                                usagep = usagep + Double.parseDouble(rst3.getString(7));
                            }
                            phpTotalaCost=timep+pricep+usagep;
                            
                            
                            
                                //lst = new AdminControll().getDownload(username, "javascript");
                            String sql3 = "select * from downloads where username=? and schema_name=?";
                            PreparedStatement ps3 = con.prepareStatement(sql3);
                            ps3.setString(1, username);
                            ps3.setString(2, "javascript");
                            ResultSet rst4=ps3.executeQuery();
                                while (rst4.next()) {
                                   // System.out.println("true");
                                    
                                     
                               timeja = timeja + Double.parseDouble(rst4.getString(5));
                                priceja = priceja + Double.parseDouble(rst4.getString(6));
                               usageja = usageja + Double.parseDouble(rst4.getString(7));
                            }
                            jsTotalaCost=timeja+priceja+usageja;
                            System.out.println(jsTotalaCost);

                    %>
                    <form name="userdetails">
                        <table class="table table-bordered" id="example" style="height: 120px;width:800px;
                               margin-left: 40px;">

                            <tr>

                                <th>Schema Name</th>

                                <th>Time(Millisecond)</th>
                                <th>Pricing($)</th>
                                <th>Usage(KB)</th>
                                <th>Total Cost($)</th>

                            </tr>
 
                            <tr class="success">
                                <td><%="JAVA" %></td>
                                <td><%=timej %></td>
                                <td><%=pricej %></td>
                                <td><%=usagej %></td>
                                <td><%=javaTotalaCost %></td>
                            </tr>
                              <tr class="success">
                                <td><%="DOTNET" %></td>
                                <td><%=timed %></td>
                                <td><%=priced %></td>
                                <td><%=usaged %></td>
                                <td><%=dotTotalaCost %></td>
                            </tr>
                              <tr class="success">
                                <td><%="JAVASCRIPT" %></td>
                                <td><%=timeja %></td>
                                <td><%=priceja %></td>
                                <td><%=usageja %></td>
                                <td><%=jsTotalaCost %></td>
                            </tr>
                              <tr class="success">
                                <td><%="PHP" %></td>
                                <td><%=timep %></td>
                                <td><%=pricep %></td>
                                <td><%=usagep %></td>
                                <td><%=phpTotalaCost %></td>
                            </tr>
                            <%
                                       
                                    }  catch (Exception e) {
                                    e.printStackTrace();
                                }
                            %>
                        </table>

                    </form>


                    <div class="form-group">
                        <div class="col-sm-offset-3 col-md-15">
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <button type="button" class="btn btn-default" style="height: 40px;width: 150px" onclick="Back_onclick()">Back</button>
                        </div>
                    </div>


                    <div class="cleaner"></div>
                </div>
            </div>
        </div>

        <script type='text/javascript' src='js/logging.js'></script>
    </body>
</html>