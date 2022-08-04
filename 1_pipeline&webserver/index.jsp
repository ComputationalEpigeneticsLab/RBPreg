<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

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
<link rel="stylesheet" type="text/css" href="css/layui.css" />
<link rel="stylesheet" type="text/css" href="css/index.css" />
<title>RBPreg</title>
</head>
<body>
<div class="adcenter"><script src="http://www.mobancss.com/include/new/ggad2_728x90.js"></script></div>

  <!-- ======= Header ======= -->
  <header id="header" class="fixed-top ">
    <div class="container d-flex align-items-center">

      <h1 class="logo mr-auto"><a href="index.jsp">RBPreg</a></h1>
      <!-- Uncomment below if you prefer to use an image logo -->
      <!-- <a href="index.html" class="logo mr-auto"><img src="assets/img/logo.png" alt="" class="img-fluid"></a>-->

      <nav class="nav-menu d-none d-lg-block">
        <ul>
          <li class="active"><a href="index.jsp">Home</a></li>
          <li><a href="example.jsp">Tutorials</a></li>
          <li><a href="tool.jsp">Tool</a></li>
<!--           <li><a href="#portfolio">Portfolio</a></li> -->
<!--           <li><a href="#team">Team</a></li> -->
<!--           <li><a href="blog.html">Blog</a></li> -->
<!--           <li class="drop-down"><a href="">Drop Down</a> -->
<!--             <ul> -->
<!--               <li><a href="#">Drop Down 1</a></li> -->
<!--               <li class="drop-down"><a href="#">Deep Drop Down</a> -->
<!--                 <ul> -->
<!--                   <li><a href="#">Deep Drop Down 1</a></li> -->
<!--                   <li><a href="#">Deep Drop Down 2</a></li> -->
<!--                   <li><a href="#">Deep Drop Down 3</a></li> -->
<!--                   <li><a href="#">Deep Drop Down 4</a></li> -->
<!--                   <li><a href="#">Deep Drop Down 5</a></li> -->
<!--                 </ul> -->
<!--               </li> -->
<!--               <li><a href="#">Drop Down 2</a></li> -->
<!--               <li><a href="#">Drop Down 3</a></li> -->
<!--               <li><a href="#">Drop Down 4</a></li> -->
<!--             </ul> -->
<!--           </li> -->
          <li><a href="contact.jsp">Contact</a></li>

        </ul>
      </nav><!-- .nav-menu -->

    </div>
  </header><!-- End Header -->

  <!-- ======= Hero Section ======= -->
  <section id="hero">
    <div class="hero-container">
      <h3>Welcome to <strong>RBPreg</strong></h3>
      <h1>RBPreg provides user-friendly method to identify RBP regulators </h1>
      <h2>We are teams of computational biology from Harbin Medical University and Hainan Medical University</h2>
      <a href="#services" class="btn-get-started scrollto">Get Started</a>
    </div>
  </section><!-- End Hero -->

  <main id="main">

    <!-- ======= Services Section ======= -->
    <section id="services" class="services">
      <div class="container">

        <div >
          <h2><strong>Highlights</strong></h2>
          <br/>
          <p style="font-size:25px;font-weight:500;line-height:1.3;letter-spacing:1px;">
	          RBPreg is a computational method to identify the RBP regulators by integration of single cell RNA-seq and RBP binding data.
	           We first de novo scanned the gene and identified the RBP motifs in gene sequences. 
	           All protein genes were ranked based on the significance levels. 
	           Next, the RBP-gene regulatory correlations were evaluated based on the expression correlation between RBP and gene. 
	          Finally, the activities of RBPs in specific cell types were evaluated by AUCell.
          </p>
         
        </div>

        <div class="row" style="margin-top:50px;">
          <div class="col-md-6 col-lg-3 d-flex align-items-stretch mb-5 mb-lg-0">
            <div class="icon-box">
              <div class="icon"><i class="bx bx-search-alt"></i></div>
              <h4 class="title"><a href="">Query the submitted job</a></h4>
              <table>
              	<tr>
              		<td>
              			<input style="width:165px;height:30px;border-radius:5px;border: 1px solid #C7C7C7;" type="text" id="home_task_id" name="home_task_id" lay-verify="title" autocomplete="off" placeholder="Input your job ID" class="layui-input" >
              		</td>
              		<td>
              		<i id="home_searchJobID" class="bx bx-search-alt" style="font-size:32px;" onclick="home_search_jobID()"></i>
              		</td>
              	</tr>
              </table>
            </div>
          </div>
			
          <div class="col-md-6 col-lg-3 d-flex align-items-stretch mb-5 mb-lg-0">
            <div class="icon-box">
              <div class="icon"><i class="bx bx-add-to-queue"></i></div>
              <h4 class="title"><a href="tool.jsp">New job</a></h4>
              <p class="description" style="">Upload & Start a new job</p>
            </div>
          </div>

          <div class="col-md-6 col-lg-3 d-flex align-items-stretch mb-5 mb-lg-0">
            <div class="icon-box">
              <div class="icon"><i class="bx bx-directions"></i></div>
              <h4 class="title"><a href="example.jsp">Tutorials</a></h4>
              <p class="description" >Tutorials to show the example results</p>
            </div>
          </div>

          <div class="col-md-6 col-lg-3 d-flex align-items-stretch mb-5 mb-lg-0">
            <div class="icon-box">
              <div class="icon"><i class="bx bx-world"></i></div>
              <h4 class="title"><a href="contact.jsp">Contact</a></h4>
              <p class="description">Contact us ! if you have any questions</p>
            </div>
          </div>


        </div>
<!-- job id attention -->
<div id="jobIDattention" style="display:none;">
	<div style="text-align:right;">
		<a href='#services' onclick="closejobIDattention()"> <i  class="bx bx-message-square-x bx-sm"></i></a>				
	</div>
	<table style="text-align:left;margin-left:15px;width:100%;">
		<tr style="height:0px;"></tr>
		<tr>
			<td style="text-align:right;width:50px;"><i style="font-size:40px;color:#e43c5c;" class='bx bx-error'></i></td>
			<td>
				<p id="jobInfor_show" style="font-size:20px;text-align:center;"></p>
			</td>			
		</tr>
	</table>
</div>
      </div>
    </section><!-- End Services Section -->



    

   


  </main><!-- End #main -->
<div style="height:220px;"></div>
  <!-- ======= Footer ======= -->
  <footer id="footer">


    <div class="container d-md-flex py-4">

      <div class="mr-md-auto text-center text-md-left">
        <div class="copyright">
          &copy; Copyright <strong><span>RBPreg</span></strong>. Harbin Medical University & Hainan  Medical University
        </div> 
        
      </div>
     
    </div>
  </footer><!-- End Footer -->

  <a href="#" class="back-to-top"><i class="ri-arrow-up-line"></i></a>

  <!-- Vendor JS Files -->
  <script src="assets/vendor/jquery/jquery.min.js"></script>
  <script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script src="assets/vendor/jquery.easing/jquery.easing.min.js"></script>
  <script src="assets/vendor/php-email-form/validate.js"></script>
  <script src="assets/vendor/isotope-layout/isotope.pkgd.min.js"></script>
  <script src="assets/vendor/venobox/venobox.min.js"></script>
  <script src="assets/vendor/owl.carousel/owl.carousel.min.js"></script>
<script src="js/MyfuctionUse.js" type="text/javascript" charset="utf-8"></script>
  <!-- Template Main JS File -->
  <script src="assets/js/main.js"></script>

<script type="text/javascript" language="javascript" src="js/layui.js"></script>
<script src="js/layer.js"></script>
</body>
</html>