<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title></title>
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
        <link rel="stylesheet" href="css/bootstrap.css"/>
        <link rel="stylesheet" href="css/bootstrap-responsive.css" />
        <script type="text/javascript" src="js/bootstrapValidator.js"></script>
        <script type="text/javascript" src="js/jquery-1.4.2.min.js" ></script>
    </head>
    <body>

       <div id="templatemo_body_wrapper">
            <div id="templatemo_wrapper"><span id="templatemo_wrapper_top"></span>
                <div id="templatemo_header">    
                    <div id="site_title"><%@include  file="projectname.html" %></div>
                    <div id="templatemo_menu" class="ddsmoothmenu">
                        <ul>
                        <li><a href="IndexPage.jsp">Home</a></li>
                           <li class="selected"><a href="UserLogin.jsp">Login</a></li>
                        <li><a href="UserRegister.jsp">CreateAccount</a></li>
                         
                        </ul>
                        <br style="clear: left" />
                    </div> <!-- end of templatemo_menu -->
                    <a href="#" title="Télécharger la photo" rel="nofollow" class="templatemo_header_img" target="_blank">Back to Homepage</a>
                </div>
                <div id="templatemo_slider">
                    <div id="slider-wrapper">
                        <br>
                        <br>
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

                <h2 align="center" style="font-family: 'Time New Roman';font-size: 15pt;color: blue;font-style: italic">Login</h2>
                <p>&nbsp;</p>
                <p>&nbsp;</p>
             

                <form method="post" class="form-horizontal" action="User_Login" autocomplete="off">

                    <div class="form-group">
                        <label for="UserName" class="col-md-5 control-label"><b>UserName:&nbsp;&nbsp;</b></label>
                        <div class="col-md-3">  
                            <input type="text" class="form-control" id="username" name="user" placeholder="Enter the UserName"  required>            
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="Password" class="col-md-5 control-label"><b>Password:&nbsp;&nbsp;</b></label>  
                        <div class="col-md-3"> 
                            <input type="password" class="form-control" id="password" name="pass" placeholder="Enter the Password" required>
                        </div>
                    </div>

                
                        <div class="form-group">
                            <div class="col-sm-offset-6 col-md-15">
                                <button type="submit" class="btn btn-default">Login</button>
                                <button type="reset" class="btn btn-default">Clear</button>
                            </div>
                        </div>

                </form>


                    <div class="cleaner"></div>
                </div>
                <p>&nbsp;</p>
                <p>&nbsp;</p>
            </div>
        </div>


        <script type='text/javascript' src='js/logging.js'></script>
    </body>
</html>