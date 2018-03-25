<%@page import="com.Performance.Controller.AdminControll"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="com.Performance.Connection.ConnectionFactory"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <title></title>
        <link href="css/demo_table.css" rel="stylesheet" type="text/css"/>
        <link href="css/templatemo_style.css" rel="stylesheet" type="text/css" />
        <link rel="stylesheet" href="css/nivo-slider.css" type="text/css" media="screen" />
        <link rel="stylesheet" type="text/css" href="css/ddsmoothmenu.css" />
        <script type="text/javascript" src="js/jquery-1.6.3.min.js" ></script>
        <script type="text/javascript" src="js/jquery-ui.min.js" ></script>
        <script type="text/javascript">
            $(document).ready(function(){
                $("#featured > ul").tabs({fx:{opacity: "toggle"}}).tabs("rotate", 5000, true);
            });
        </script>
        <script type="text/javascript" language="javascript" src="js/jquery.js"></script>
        <script type="text/javascript" language="javascript" src="js/jquery.dataTables.js"></script>
        <script type="text/javascript" charset="utf-8">
            $(document).ready(function() {
                var oTable = $('#example').dataTable();
                var oSettings = oTable.fnSettings();
                var iStart = new Date().getTime();
                console.profile( );
                oTable.fnPageChange( "Next" );
                oTable.fnPageChange( "Previous" );
                console.profileEnd( );
                var iEnd = new Date().getTime();
                //document.getElementById('output').innerHTML = "Test took "+(iEnd-iStart)+"mS";
            } );
        </script>
        <script>
            function Edit_onclick(id){
                var f = document.userdetails;
                f.method = "post";
                f.action= 'userDownload.jsp?id='+id;
                f.submit();
            }
             
        </script>
        <link rel="stylesheet" type="text/css" href="css/ddsmoothmenu.css" />
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
        <link rel="stylesheet" href="css/slimbox2.css" type="text/css" media="screen" /> 
        <script type="text/JavaScript" src="js/slimbox2.js"></script>
         
    </head>
    <body>

        <div id="templatemo_body_wrapper">
            <div id="templatemo_wrapper"><span id="templatemo_wrapper_top"></span>
                <div id="templatemo_header">    
                    <div id="site_title"><%@include  file="projectname.html" %> </div>
                    <div id="templatemo_menu" class="ddsmoothmenu">
                        <ul> <li><a href="HomePage.jsp">Home</a></li>
                            <li><a href="Report.jsp">Report</a></li>
                            <li><a href="Searching.jsp" class="selected">Searching</a></li>
                            <li><a href="UserDetail.jsp">Profile</a></li>
                            <li><a href="Logout.jsp">Logout</a></li>
                        </ul>
                        <br style="clear: left" />
                    </div> <!-- end of templatemo_menu -->
                    <a href="#" title="Télécharger la photo" rel="nofollow" class="templatemo_header_img" target="_blank">Back to Homepage</a>
                </div>
                <%-- <div id="templatemo_slider">
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
                </div>--%>
                
                  <div id="templatemo_main">

                    <p>&nbsp;</p>
                    <p>&nbsp;</p>
                    <p>&nbsp;</p>
                    <p>&nbsp;</p>
                    <p>&nbsp;</p>

 <form name="userdetails"   >
                    <table cellpadding="0" cellspacing="0" border="0" class="display" id="example">
                        <thead>
                            <tr>
                                <th>Schema Name</th>
                                <th>File Name</th>
                                <th>File Cost</th>
                                <th>Time</th>
                                <th>File Size(KB)</th>
                                <th>Download</th>
                                

                            </tr>
                        </thead>
                            <tbody>
                
<%
                                Connection con = null;
                                String username = session.getAttribute("username").toString();
                                String name=request.getParameter("Name");
                   try{
                                    con = ConnectionFactory.getConnection();
                                    Statement stmt = con.createStatement();
                                    ResultSet rs = new AdminControll().getData();
                                    ResultSet rs1=stmt.executeQuery("select * from datatable");
									ArrayList<String>names=new ArrayList();//Stores names of files									
									
									while(rs1.next()){
										names.add(rs1.getString("file"));
									}
									
									//<%--Jaccard Similarity--%
                                                                            
									int length=names.size();
                                                                        //Setting the threshold for the jaccard index
									float threshold=(float)0.5;
                                                                        //Stores the resultant file
									ArrayList<String>result=new ArrayList();
									result.add(names.get(0));

									for(int i=0;i<length;i++)
									{
										for(int j=i+1;j<length;j++)
										{	

											String str1=names.get(i);
											String str2=names.get(j);
											

											ArrayList<Character>str1Tokens=new ArrayList();

												for(char ch:str1.toCharArray())
												{
													str1Tokens.add(ch);
												}
                                                                                                //Stores the second tokens    
												ArrayList<Character>str2Tokens=new ArrayList();

												for(char ch:str2.toCharArray())
												{
													str2Tokens.add(ch);
												}
                                                                                                //Stores all the Tokens of both the comparitive strings
												Set<Character>allTokens=new HashSet();
												allTokens.addAll(str1Tokens);
                                                                                                //calculates the no of terms in string one
												int termsInString1=allTokens.size();
												Set<Character>secondStringTokens=new HashSet();
												secondStringTokens.addAll(str2Tokens);
                                                                                                //calculates the number of terms in string 2
												int termsInString2=secondStringTokens.size();
												allTokens.addAll(secondStringTokens);
                                                                                                //finds the common terms
												int commonTerms=(termsInString1+termsInString2)-allTokens.size();
                                                                                                //calulates the Jaccard Index
												float index=(float)(commonTerms)/(float)(allTokens.size());

												if(index>threshold)
												{	
														
												result.add(str2);
												}
										}
                                                                        }
                                                                        int i=0;
                                                         while (rs.next()) {
                                                             String str1=result.get(i);
								String str2=rs.getString("file");
								if(str1.equals(str2))
								{	i++;
                                                                    String filesize = rs.getString(9);
                                                                    int size = Integer.parseInt(filesize);
                                       
                                                                }
%>              
                                <tr class="gradeX">
                                    <td><%=rs.getString(2)%></td>
                                    <td><%=rs.getString(8)%></td>
                                    <td><%=rs.getString(9)%></td>
                                    <td><%=rs.getString(6)%></td>

                                    <td><%=rs.getString(7)%></td>
                                     <td><button type="button"  value="Delete" name="delete" onclick="Edit_onclick(<%=rs.getInt(1)%>);"> Download&nbsp; </button></td>
                                </tr>
                            
<%
                                                                  
                                                      }
                    }
                    catch(Exception e) 
                    {
                          e.printStackTrace();
                    }
%>

                         

                        </tbody>

                    </table>
 </form>          
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