<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link href="css/loadingUse.css" rel="stylesheet">
<script type="text/javascript">

document.onreadystatechange = subSomething;
//加载状态为complete时移除loading效果
function subSomething() {
    //当页面加载状态
    if (document.readyState == "complete") {
        //延迟一秒关闭loading
        $('#loading').delay(500).hide(0);
        
    }
}

</script>
  <meta charset="utf-8">
  <meta content="width=device-width, initial-scale=1.0" name="viewport">
  <meta content="" name="descriptison">
  <meta content="" name="keywords">
<link href="img/logo.png" rel="icon">


  <!-- Google Fonts -->
  <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Nunito:300,300i,400,400i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i" rel="stylesheet">

  <!-- Vendor CSS Files -->
  <link href="assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <link href="assets/vendor/icofont/icofont.min.css" rel="stylesheet">
  <link href="assets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
  <link href="assets/vendor/remixicon/remixicon.css" rel="stylesheet">
  <link href="assets/vendor/venobox/venobox.css" rel="stylesheet">
  <link href="assets/vendor/owl.carousel/assets/owl.carousel.min.css" rel="stylesheet">

  <!-- Template Main CSS File -->
  <link href="assets/css/style.css" rel="stylesheet">
   <!-- 引入layui  -->
<link rel="stylesheet" type="text/css" href="css/contact.css" />

<title>RBPreg</title>
<script type="text/javascript">
	function message_submit(){
		var name = document.getElementById("name").value;
		
		var email = document.getElementById("email").value;
		var Theme = document.getElementById("Theme").value;
		var message = document.getElementById("message").value;
		//console.log(message);
		if (name == "" || null) {
			alert("Please input your name!");
			return false;
		}
		if (email == "" || null) {
			alert("Please input your email!");
			return false;
		}
		$("#message_success_back").show(300);
	}
function close_contact_Success_msg(){
	$("#message_success_back").hide();
}
</script>
</head>
<style>

</style>
<body>
<div id="loading">
	<div class="la-ball-clip-rotate-multiple la-3x" style="color: #f68f6f;margin: auto;  position: absolute;  top: 0; left: 0; bottom: 0; right: 0; ">
		<div></div>
		<div></div>
		<div></div>
		<div></div>
		<div></div>
		<div></div>
	</div>
</div>

<!-- ======= Header ======= -->
  <header id="header" class="fixed-top header-inner-pages">
    <div class="container d-flex align-items-center">

      <h1 class="logo mr-auto"><a href="index.jsp">RBPreg</a></h1>

      <nav class="nav-menu d-none d-lg-block">
        <ul>
          <li ><a href="index.jsp">Home</a></li>
 		  <li ><a href="example.jsp">Tutorials</a></li>
          <li ><a href="tool.jsp">Tool</a></li>
          <li class="active"><a href="contact.jsp">Contact</a></li>

        </ul>
      </nav><!-- .nav-menu -->

    </div>
  </header><!-- End Header -->

  

  <main id="main">
  	<!-- ======= Breadcrumbs ======= -->
    <section id="breadcrumbs" class="breadcrumbs">
      <div class="container" style="margin-top:10px;">

        
        <h2>Contact</h2>

      </div>
    </section><!-- End Breadcrumbs -->

    <section id="contact" class="contact">
      <div class="container" id="shlow">
      		<div style="height:20px;"></div>
			  <div style="margin-left:10px;"> <h3>Please contact us when you have any questions in using RBPreg.</h3>  </div>
			  <div id="whole_contact" >
	          	<div class="row mt-5">
		          <div class="col-lg-4" style="margin-top:20px;">
		            <div class="info">
		              <div class="address">
		                <i class="icofont-google-map"></i>
		                <h4>Location :</h4>
		                <p style="font-size:15px;">194 Xuefu Road, Harbin 150081, CHINA</p>
		              </div>
		
		              <div class="email">
		                <i class="icofont-envelope"></i>
		                <h4>Email :</h4>
		                <p style="font-size:;">Juan Xu : xujuanbiocc@ems.hrbmu.edu.cn</p>
		              </div>
		
		              <div class="phone">
		                <i class="icofont-phone" style=""></i>
		                <h4>Call :</h4>
		                <p style="font-size:16px;">+86-451-86615922</p>
		              </div>
		
		            </div>
		
		          </div>
		
		          <div class="col-lg-8 mt-5 mt-lg-0">				            
		              <div class="form-row">
		                <div class="col-md-6 form-group">
		                  <input type="text" name="name" class="form-control" id="name" placeholder="Your Name *"   />
		                  <div class="validate"></div>
		                </div>
		                <div class="col-md-6 form-group">
		                  <input type="email" class="form-control" name="email" id="email" placeholder="Email *" data-rule="email"  />
		                  
		                </div>
		              </div>
		              <div class="form-group">
		                <input type="text" class="form-control" name="subject" id="Theme" placeholder="Theme"   />
		                
		              </div>
		              <div class="form-group">
		                <textarea class="form-control" name="message" rows="5" id="message"  placeholder="Input your message"></textarea>
		                
		              </div>
		              
		              <br/>
		              <div class="text-center">
		              	<input id="fileqcmpsubmit_email"   type = "submit" value="Send Message" onclick="message_submit()"
														style="height:40px;width:180px; border:1px solid #969696; border-radius:5px;font-size:20px;transition: ease-in all 0.25s;font-weight:bold;background-color:#e43c5c;color:white;" 
														onfocus="this.className='input_on';this.οnmοuseοut=''" 
														onblur="this.className='input_off';this.οnmοuseοut=function(){this.className='input_out'};" 
														onmousemove="this.className='input_move'" 
														onmouseout="this.className='input_out'"
													/>
		              </div>
		              <br/><br/><br/>
		            <div id="message_success_back" style="display:none;">
								<div style="text-align:right;">
									<a href='#' onclick="close_contact_Success_msg()"> <i  class="bx bx-message-square-x bx-sm"></i></a>
											
								</div>
								<table style="text-align:left;margin-left:15px;width:100%;">
									<tr style="height:0px;"></tr>
									<tr>
										<td style="text-align:left;width:50px;"><i style="font-size:40px;" class='bx bx-message-rounded-check'></i></td>
										<td>
											<p  style="font-size:20px;text-align:left;">Message submitted successfully! We will consider your suggestion carefully.</p>
										</td>
										
									</tr>
								</table>
							</div>
		
		          </div>
		
		        </div>
	          
	
	
			  </div>
          </div>
          <!-- End blog entries list -->
      
    </section><!-- End Blog Section -->


  </main><!-- End #main -->

  <!-- ======= Footer ======= -->
<!--   <footer id="footer"> -->


<!--     <div class="container d-md-flex py-4"> -->

<!--       <div class="mr-md-auto text-center text-md-left"> -->
<!--         <div class="copyright"> -->
<!--           &copy; Copyright <strong><span>RBPreg</span></strong>. Harbin Medical University & Hainan  Medical University -->
<!--         </div>  -->
        
<!--       </div> -->
     
<!--     </div> -->
<!--   </footer>End Footer -->

  <a href="#" class="back-to-top"><i class="ri-arrow-up-line"></i></a>

  <!-- Vendor JS Files -->
  <script src="assets/vendor/jquery/jquery.min.js"></script>
  <script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script src="assets/vendor/jquery.easing/jquery.easing.min.js"></script>
  <script src="assets/vendor/php-email-form/validate.js"></script>
  <script src="assets/vendor/isotope-layout/isotope.pkgd.min.js"></script>
  <script src="assets/vendor/venobox/venobox.min.js"></script>
  <script src="assets/vendor/owl.carousel/owl.carousel.min.js"></script>

  <!-- Template Main JS File -->
  <script src="assets/js/main.js"></script>

<script type="text/javascript" language="javascript" src="js/layui.js"></script>
<script src="js/layer.js"></script>
</body>
</html>
