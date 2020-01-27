<%@page import="entidades.Parentesco"%>
<%@page import="java.util.*"%>
<%@page import="datos.DtRol"%>
<%@page import="entidades.Rol"%>
<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8"%>
<!DOCTYPE html>
<%
response.setHeader("Pragma", "No-cache");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Cache-Control","no-store");
response.setHeader("Cache-Control","must-revalidate");
response.setDateHeader("Expires", -1);

%>
<html charset="utf-8">
   <head>
   
    
      <meta charset="utf-8">
      <meta name="viewport" content="width=device-width" />
      <title>Centro de Desarrollo Psicosocial Ignacio Martín Baró</title>
      <link rel="stylesheet" href="css/components.css">
      <link rel="stylesheet" href="css/responsee.css">
      <link rel="stylesheet" href="owl-carousel/owl.carousel.css">
      <link rel="stylesheet" href="owl-carousel/owl.theme.css">
      <link rel="stylesheet" href="jAlert-master/dist/jAlert.css" />
      <!-- CUSTOM STYLE -->
      <link rel="stylesheet" href="css/template-style.css">
      <link href='http://fonts.googleapis.com/css?family=Open+Sans:400,300,600,700,800&subset=latin,latin-ext' rel='stylesheet' type='text/css'>
      <script type="text/javascript" src="js/jquery-1.8.3.min.js"></script>
      <script type="text/javascript" src="js/jquery-ui.min.js"></script>    
      <script type="text/javascript" src="js/modernizr.js"></script>
      <script type="text/javascript" src="js/responsee.js"></script>
      <script type="text/javascript" src="js/template-scripts.js"></script> 
                 
      <!--[if lt IE 9]>
	      <script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
        <script src="http://css3-mediaqueries-js.googlecode.com/svn/trunk/css3-mediaqueries.js"></script>
      <![endif]-->
      
      <%
	//CERRAMOS LA SESION
	HttpSession hts = request.getSession(false);
	hts.invalidate();
	
	%>
     
   </head>
   <body class="size-1140" charset="utf-8">
      <!-- TOP NAV WITH LOGO -->
      <header>
         <div id="topbar">
            <div class="line">
               <div class="s-12 m-6 l-6">
                  <p>Contáctanos: <strong>22783923</strong> </p>
               </div>
               <!-- <div class="s-12 m-6 l-6">
                  <div class="social right">
                     <a><i class="icon-facebook_circle"></i></a> <a><i class="icon-twitter_circle"></i></a> <a><i class="icon-google_plus_circle"></i></a> <a><i class="icon-instagram_circle"></i></a>
                  </div>
               </div> -->
            </div>  
         </div> 
         <nav>
            <div class="line">
               <div class="s-12 l-2">
                  <p class="logo"><strong>CDP</strong> IGMAB</p>
               </div>
               <div class="top-nav s-12 l-10">
                  <p class="nav-text">Menu</p>
                  <ul class="right">
                     <li class="active-item"><a href="#carousel">Principal</a></li>
                     <li><a href="#features">IGMAB</a></li>
                     <li><a href="#about-us">Creadores</a></li>
                     <li><a href="#our-work">Nuestro trabajo</a></li>
                     <li><a href="#services">Acerca de nosotros</a></li>
                     <li><a href="#contact">Contáctenos</a></li>
                  </ul>
               </div>
            </div>
         </nav>
      </header>  
      <section>
         <!-- CAROUSEL --> 
         <div id="carousel">
            <div id="owl-demo" class="owl-carousel owl-theme"> 
               <div class="item">
                  <img src="img/rsz_img_0507.jpg" alt="">
                  <div class="line"> 
                     <div class="text hide-s">
                        <div class="line"> 
                          <div class="prev-arrow hide-s hide-m">
                             <i class="icon-chevron_left"></i>
                          </div>
                          <div class="next-arrow hide-s hide-m">
                             <i class="icon-chevron_right"></i>
                          </div>
                        </div> 
                        <h2>Honestidad</h2>
<!--                         <p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna.</p> -->
                     </div>
                  </div>
               </div>
               <div class="item">
                  <img src="img/rsz_img_0502.jpg"  alt="">
                  <div class="line">
                     <div class="text hide-s"> 
                        <div class="line"> 
                          <div class="prev-arrow hide-s hide-m">
                             <i class="icon-chevron_left"></i>
                          </div>
                          <div class="next-arrow hide-s hide-m">
                             <i class="icon-chevron_right"></i>
                          </div>
                        </div> 
                        <h2>Respeto a la diversidad</h2>
<!--                         <p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna.</p> -->
                     </div>
                  </div>
               </div>
               <div class="item">
                  <img src="img/rsz_img_4186.jpg" alt="">
                  <div class="line">
                     <div class="text hide-s">
                        <div class="line"> 
                          <div class="prev-arrow hide-s hide-m">
                             <i class="icon-chevron_left"></i>
                          </div>
                          <div class="next-arrow hide-s hide-m">
                             <i class="icon-chevron_right"></i>
                          </div>
                        </div> 
                        <h2>Responsabilidad</h2>
<!--                         <p> onsubmit="iniciar($('#username').val(), $('#password').val(), $('#rol').val())"  Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna.</p> -->
                     </div>
                  </div>
               </div>
            </div>
         </div>
         <!-- FIRST BLOCK -->
         <div id="first-block">
            <div class="line">
               <h1>Centro de Desarrollo Psicosocial Ignacio Martín Baró</h1>
               
               <div class="s-12 m-4 l-2 center"><a class="white-btn" href="#contact">Contáctanos</a></div>
            </div>
         </div>
         <!-- FEATURES -->
         <div id="features">
            <div class="line">
               <div class="margin">
                  <div class="s-12 m-12 l-5">
                    <h3>Iniciar sesión en IGMAB</h3>

                    <form class="customform" action="javascript:void(0);" onsubmit="iniciar($('#username').val(), $('#password').val(), $('#rol').val())"  method="post" >
                      <div class="s-12"><input name="username" placeholder="Usuario" title="Usuario" type="text" id="username" /></div>
                      <div class="s-12"><input name="password" placeholder="Contraseña" title="Contraseña" type="password" id="password" /></div>
                      <div class="s-12"><select name="rol" id="rol"><option value=""> Seleccione un Rol </option>
									<%
										DtRol dtr = new DtRol();	
										ResultSet rs = dtr.cargarDatos();
										rs.beforeFirst();
										while(rs.next())
										{
									%>
									<option value="<%=rs.getInt("RolID")%>"><%=rs.getString("Nombre")%></option>
									<%
										}	
									%></select></div>
                      <div class="s-12 m-12 l-4"><button class="color-btn" type="submit">Ingresar</button></div>
                    </form>
                  </div>  
               </div>
            </div>
         </div>
         <!-- ABOUT US -->
         <div id="about-us">
            <div class="s-12 m-12 l-6 media-container">
               <img src="img/Foto2.jpeg" alt="">
            </div>
            <article class="s-12 m-12 l-6">
               <h2>Gang of seven<br>Java<br>Heroes</h2>
               <p>Somos un grupo de estudiantes de la carrera de Ingenieria en sistemas de información de la Universidad Centroamericana, que hemos desarrollado este
               sistema como parte de nuestro proyecto de servicio social 2016-2017 para el Centro de Desarrollo Psicosocial Ignacio Martín-Baró.
               </p>
               <div class="about-us-icons">
                  <i class="icon-paperplane_ico"></i> <i class="icon-trophy"></i> <i class="icon-clock"></i>
               </div>
            </article>
         </div>
         <!-- OUR WORK -->
         <div id="our-work">
            <div class="line">
               <h2 class="section-title">Nuestro trabajo</h2>
               <!-- <div class="tabs">
                  <div class="tab-item tab-active">
                    <a class="tab-label active-btn">Web Design</a>
                    <div class="tab-content">
                      <div class="margin">
                        <div class="s-12 m-6 l-3"><a class="our-work-container lightbox margin-bottom"><div class="our-work-text"><h4>Lorem Ipsum Dolor</h4><p>Laoreet dolore magna aliquam erat volutpat.</p></div><img src="img/por1.jpg" alt=""></a></div>
                        <div class="s-12 m-6 l-3"><a class="our-work-container lightbox margin-bottom"><div class="our-work-text"><h4>Lorem Ipsum Dolor</h4><p>Laoreet dolore magna aliquam erat volutpat.</p></div><img src="img/por4.jpg" alt=""></a></div>
                        <div class="s-12 m-6 l-3"><a class="our-work-container lightbox margin-bottom"><div class="our-work-text"><h4>Lorem Ipsum Dolor</h4><p>Laoreet dolore magna aliquam erat volutpat.</p></div><img src="img/por6.jpg" alt=""></a></div>
                        <div class="s-12 m-6 l-3"><a class="our-work-container lightbox margin-bottom"><div class="our-work-text"><h4>Lorem Ipsum Dolor</h4><p>Laoreet dolore magna aliquam erat volutpat.</p></div><img src="img/por3.jpg" alt=""></a></div>
                      </div>
                    </div>  
                  </div>
                  <div class="tab-item">
                    <a class="tab-label">Development</a>        
                    <div class="tab-content">
                      <div class="margin">
                        <div class="s-12 m-6 l-3"><a class="our-work-container lightbox margin-bottom"><div class="our-work-text"><h4>Lorem Ipsum Dolor</h4><p>Laoreet dolore magna aliquam erat volutpat.</p></div><img src="img/por7.jpg" alt=""></a></div>
                        <div class="s-12 m-6 l-3"><a class="our-work-container lightbox margin-bottom"><div class="our-work-text"><h4>Lorem Ipsum Dolor</h4><p>Laoreet dolore magna aliquam erat volutpat.</p></div><img src="img/por5.jpg" alt=""></a></div>
                        <div class="s-12 m-6 l-3"><a class="our-work-container lightbox margin-bottom"><div class="our-work-text"><h4>Lorem Ipsum Dolor</h4><p>Laoreet dolore magna aliquam erat volutpat.</p></div><img src="img/por1.jpg" alt=""></a></div>
                        <div class="s-12 m-6 l-3"><a class="our-work-container lightbox margin-bottom"><div class="our-work-text"><h4>Lorem Ipsum Dolor</h4><p>Laoreet dolore magna aliquam erat volutpat.</p></div><img src="img/por2.jpg" alt=""></a></div>
                      </div>
                    </div>  
                  </div>
                  <div class="tab-item">
                    <a class="tab-label">Social Campaigns</a>
                    <div class="tab-content">
                      <div class="margin">
                        <div class="s-12 m-6 l-3"><a class="our-work-container lightbox margin-bottom"><div class="our-work-text"><h4>Lorem Ipsum Dolor</h4><p>Laoreet dolore magna aliquam erat volutpat.</p></div><img src="img/por4.jpg" alt=""></a></div>
                        <div class="s-12 m-6 l-3"><a class="our-work-container lightbox margin-bottom"><div class="our-work-text"><h4>Lorem Ipsum Dolor</h4><p>Laoreet dolore magna aliquam erat volutpat.</p></div><img src="img/por6.jpg" alt=""></a></div>
                        <div class="s-12 m-6 l-3"><a class="our-work-container lightbox margin-bottom"><div class="our-work-text"><h4>Lorem Ipsum Dolor</h4><p>Laoreet dolore magna aliquam erat volutpat.</p></div><img src="img/por3.jpg" alt=""></a></div>
                        <div class="s-12 m-6 l-3"><a class="our-work-container lightbox margin-bottom"><div class="our-work-text"><h4>Lorem Ipsum Dolor</h4><p>Laoreet dolore magna aliquam erat volutpat.</p></div><img src="img/por5.jpg" alt=""></a></div>
                      </div>
                    </div>  
                  </div>
                  <div class="tab-item">
                    <a class="tab-label">Photography</a>
                    <div class="tab-content">
                      <div class="margin">
                        <div class="s-12 m-6 l-3"><a class="our-work-container lightbox margin-bottom"><div class="our-work-text"><h4>Lorem Ipsum Dolor</h4><p>Laoreet dolore magna aliquam erat volutpat.</p></div><img src="img/por7.jpg" alt=""></a></div>
                        <div class="s-12 m-6 l-3"><a class="our-work-container lightbox margin-bottom"><div class="our-work-text"><h4>Lorem Ipsum Dolor</h4><p>Laoreet dolore magna aliquam erat volutpat.</p></div><img src="img/por2.jpg" alt=""></a></div>
                        <div class="s-12 m-6 l-3"><a class="our-work-container lightbox margin-bottom"><div class="our-work-text"><h4>Lorem Ipsum Dolor</h4><p>Laoreet dolore magna aliquam erat volutpat.</p></div><img src="img/por5.jpg" alt=""></a></div>
                        <div class="s-12 m-6 l-3"><a class="our-work-container lightbox margin-bottom"><div class="our-work-text"><h4>Lorem Ipsum Dolor</h4><p>Laoreet dolore magna aliquam erat volutpat.</p></div><img src="img/por6.jpg" alt=""></a></div>
                      </div>
                    </div>  
                  </div>
               </div> -->
               <p>El Centro de desarrollo psicosocial brinda ayuda a personas respetando la diversidad, confidencialidad que ayude al desarrollo pleno de las personas y ayudar a la capacitación de los futuros egresados de psicología.</p>
            </div>
         </div>         
         <!-- SERVICES -->
         <div id="services">
            <div class="line">
               <h2 class="section-title">Acerca de nosotros</h2>
               <div class="margin">
                  <div class="s-12 m-6 l-4 margin-bottom">
                     <i class="icon-vector"></i>
                     <div class="service-text">
                        <h3>Misión</h3>
                        <p>Brindar un servicio de atención íntegra, que permite el desarrollo pleno de las personas, a través de la formación académica, la capacitación y la intervención relacionadas con las distintas problemáticas psicosociales. Dirigido a la comunidad educativa, población de escasos recursos, instituciones públicas y privadas, contribuyendo así a la preparación profesional y al mejoramiento de la salud mental.</p>
                     </div>
                  </div>
                  <div class="s-12 m-6 l-4 margin-bottom">
                     <i class="icon-eye"></i>
                     <div class="service-text">
                        <h3>Valores</h3>
                        <p>
                           Honestidad<br>
                           Justicia<br>
                           Responsabilidad<br>
                           Respeto a la diversidad<br>
                           Generosidad<br>
                           Respeto<br>
                           Confidencialidad<br>
                           Bondad<br>
                           Solidaridad<br>
                        	</p>
                     </div>
                  </div>
                  <div class="s-12 m-12 l-4 margin-bottom">
                     <i class="icon-random"></i>
                     <div class="service-text">
                        <h3>Visión</h3>
                        <p>Ser un espacio de crecimiento de las personas, desde el ámbito biopsicosocial y espiritual, con un enfoque interdisciplinar, que favorezca la calidad de vida de la comunidad universitaria y de la población en general</p>
                     </div>
                  </div>
               </div>
            </div>
         </div>
         <!-- <!-- LATEST NEWS
         <div id="latest-news">
            <div class="line">
              <h2 class="section-title">Latest News</h2> 
              <div class="margin">
                <div class="s-12 m-6 l-6">
                  <div class="s-12 l-2">
                    <div class="news-date">
                      <p class="day">28</p><p class="month">AUGUST</p><p class="year">2015</p>
                    </div>
                  </div>
                  <div class="s-12 l-10">
                    <div class="news-text">
                      <h4>First latest News</h4>
                      <p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam.</p>
                    </div>
                  </div>   
                </div> 
                <div class="s-12 m-6 l-6">
                  <div class="s-12 l-2">
                    <div class="news-date">
                      <p class="day">12</p><p class="month">JULY</p><p class="year">2015</p>
                    </div>
                  </div>
                  <div class="s-12 l-10">
                    <div class="news-text">
                      <h4>Second latest News</h4>
                      <p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam.</p>
                    </div>
                  </div>   
                </div>  
              </div>
            </div>
         </div>  -->
         <!-- CONTACT -->
         <div id="contact">
            <div class="line">
               <h2 class="section-title">Contáctenos</h2>
               <div class="margin">
                  <div class="s-12 m-12 l-3 hide-m hide-s margin-bottom right-align">
                    <img src="img/IMG_0499.JPG" alt="">
                  </div>
                  <div class="s-12 m-12 l-4 margin-bottom right-align">
                     <h3>Centro de Desarrollo Psicosocial<br> Ignacio Martín Baró</h3>
                     <address>
                        <p><strong>Dirección:</strong> Universidad Centroamericana</p>
                        <p><strong>País:</strong> Managua - Nicaragua</p>
                         <p><strong>Teléfono:</strong> 22783923</p>
                     </address>
                     <br />
                     <h3>Social</h3>
                     <p><i class="icon-facebook icon"></i> <a href="https://es-la.facebook.com/Centro-de-Desarrollo-Psicosocial-Ignacio-Mart%C3%ADn-Bar%C3%B3-1470665479856903/">Centro de Desarrollo Psicosocial</a></p>

                  </div>
                                 
               </div>
            </div>
         </div>
         <!-- MAP 
         <div id="map-block">  	  
            <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d1247814.3661917313!2d16.569872019090596!3d48.23131953825178!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x476c8cbf758ecb9f%3A0xddeb1d26bce5eccf!2sGallayova+2150%2F19%2C+841+02+D%C3%BAbravka!5e0!3m2!1ssk!2ssk!4v1440344568394" width="100%" height="450" frameborder="0" style="border:0"></iframe>
         </div>-->
      </section>
      <!-- FOOTER -->
      <footer>
         <div class="line">
            <div class="s-12 l-6">
               <p>2017, Centro de Desarrollo Psicosocial Ignacio Martín Baró</p>
<!--                <p>All images is purchased from Bigstock. Do not use the images in your website.</p> -->
            </div>
            <!-- <div class="s-12 l-6">
               <a class="right" href="http://www.myresponsee.com" title="Responsee - lightweight responsive framework">Design and coding<br> by Responsee Team</a>
            </div> -->
         </div>
      </footer>
      <script type="text/javascript" src="owl-carousel/owl.carousel.js"></script>
      <script src="jAlert-master/dist/jAlert.min.js"></script>
      <script src="jAlert-master/dist/jAlert-functions.min.js"> //optional!!</script>
      <script type="text/javascript">

         function iniciar(username, password, rol) {
             $.ajax({
                 url : "SlSeguridad",
                 type : "post",
                 datatype : 'html',
                 data : {
                     'username' : username,
                     'password' : password,
                     'rol' : rol
                 },
                 success : function(data) {
                     if(data=="1") {
                         console.log("Iniciado");
                         window.location.replace("./index.jsp");
                     } else if(data=="2") {
                         console.log("todo bien supuestamente");
                         errorAlert("Credenciales incorrectas");
                     }

                 }

             });
         }

         jQuery(document).ready(function($) {



            var theme_slider = $("#owl-demo");
            $("#owl-demo").owlCarousel({
                navigation: false,
                slideSpeed: 300,
                paginationSpeed: 400,
                autoPlay: 6000,
                addClassActive: true,
             // transitionStyle: "fade",
                singleItem: true
            });
            $("#owl-demo2").owlCarousel({
                slideSpeed: 300,
                autoPlay: true,
                navigation: true,
                navigationText: ["&#xf007","&#xf006"],
                pagination: false,
                singleItem: true
            });
        
            // Custom Navigation Events
            $(".next-arrow").click(function() {
                theme_slider.trigger('owl.next');
            })
            $(".prev-arrow").click(function() {
                theme_slider.trigger('owl.prev');
            })     
        }); 
      </script>
   </body>
</html>
