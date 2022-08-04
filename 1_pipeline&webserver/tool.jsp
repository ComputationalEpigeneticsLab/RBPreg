<%@ page import="Util.*" import="java.sql.*" import="java.util.ArrayList" language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
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
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
 <meta charset="utf-8">
  <meta content="width=device-width, initial-scale=1.0" name="viewport">
  <meta content="" name="descriptison">
  <meta content="" name="keywords">

  <!-- Favicons -->
<link href="img/logo.png" rel="icon">

  <link rel="stylesheet" href="css/style_FileUpLoad.css">
  <!-- Google Fonts -->
  <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Nunito:300,300i,400,400i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i" rel="stylesheet">

  <!-- Vendor CSS Files -->
  <link href="assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <link href="assets/vendor/icofont/icofont.min.css" rel="stylesheet">
  <link href="assets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
  <link href="assets/vendor/remixicon/remixicon.css" rel="stylesheet">
  <link href="assets/vendor/venobox/venobox.css" rel="stylesheet">
  <link href="assets/vendor/owl.carousel/assets/owl.carousel.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="css/jquery.dataTables.min.css">
<link rel="stylesheet" type="text/css" href="css/buttons.dataTables.min.css">
<link rel="stylesheet" type="text/css" href="css/ball-newton-cradle.css" />
  <!-- Template Main CSS File -->
  <link href="assets/css/style.css" rel="stylesheet">
   <!-- 引入layui  -->
 <!-- 引入layui  -->
<link rel="stylesheet" type="text/css" href="css/tool.css" />
<link rel="stylesheet" type="text/css" href="css/layui.css" />
<title>Tool</title>
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
      <!-- Uncomment below if you prefer to use an image logo -->
      <!-- <a href="index.html" class="logo mr-auto"><img src="assets/img/logo.png" alt="" class="img-fluid"></a>-->

      <nav class="nav-menu d-none d-lg-block">
        <ul>
          <li><a href="index.jsp">Home</a></li>
 		  <li ><a href="example.jsp">Tutorials</a></li>
          <li class="active"><a href="tool.jsp">Tool</a></li>
          <li><a href="contact.jsp">Contact</a></li>

        </ul>
      </nav><!-- .nav-menu -->

    </div>
  </header><!-- End Header -->

  <main id="main">

    <!-- ======= Breadcrumbs ======= -->
    <section id="breadcrumbs" class="breadcrumbs">
      <div class="container" style="margin-top:10px;">

        
        <h2>Tool</h2>
<!--         <ol> -->
<!--           <li><a href="example.jsp">Base</a></li> -->
<!--           <li><a href="index.html">BC-B cell</a></li> -->
<!--         </ol> -->

      </div>
    </section><!-- End Breadcrumbs -->

    <!-- ======= Blog Section ======= -->
    <section id="blog" class="blog">
      <div class="container">

        <div class="row">

          <div class="col-lg-12 ">
          	<div class="sidebar">
          		<div> <h3><strong>Find  submitted job</strong></h3>  </div>
					<br/>
          		<div>
						<table style="margin-left:10px;">
							<tr>
								<td>
									<div style="width:150px;"><p style="font-size:25px;"> Job ID :</p></div>
								</td>
								<td>
									<input style="width:400px;height:40px;border-radius:10px;border: 1px solid #C7C7C7;" type="text" id="task_id" name="task_id" lay-verify="title" autocomplete="off" placeholder=" Please input job ID to access submitted results" class="layui-input" >				
								</td>
								<td style="width:10px;"></td>
								
								<td>
									<input class="q_submit" type = "image" src="img/search_big.png" height="45px"  onclick="Task_id_F()"> 
								</td>
							</tr>
						</table>
					</div>
					<br/>
					<div id="taskid_infor" class="fontflex" style="width:80%;margin-left:5%;min-height:100px;display:none;font-size:25px;color:red;"></div>
					 <br/>         		
          	</div>
				<div id="part1_file" class="sidebar">
					<div> <h3><strong>Start a new job</strong></h3>  </div>
					<br/>
						  <div id="choose_emil" style=""> 
											<table  class="table_use" style="" id="email_details" >
												<tr>
													<td > <div style="width:;"><p style="font-size:20px;">Email address : </p></div> </td>									      		
										      		<td >	
										      			<div style="width:400px;">
										      			<input class="qc_subTable_input1" type="text" id="email_address" name="email_address" lay-verify="title" autocomplete="off" placeholder=" Please input your email address" class="layui-input" >
														</div>								      			
										      		</td>
										      		<td valign="top">										      			
											            	<button id="choose_emil_select" class=""  type="button"   style="border-style: none;background:white;">
											              		<i style="font-size:20px;" class="bx bx-info-circle"  ></i>
											              	</button>
										              	
										      		</td>
												</tr>
																																	
											</table>
							        </div>  
							        <br/>	
					<!-- /.card-body upload_file -->
						        <div >							        					                    						                    
						        	<div id="upload_file">		              		
									 	<table class=""  >
							              		<tr>
													<td rowspan="2">
														<div class="article">
														        	<div class="item">
															            <div class="addImg"  >															                
															                    <i  class="bx bx-cloud-upload bx" style="position: absolute;top: 15px; left: 110px; bottom: 0; right: 0; font-size:70px;"></i>															                
															            </div>
															            <input name="url" type="file" class="upload_input" id="upload_file_id" onchange="change(this)" />
															            <div class="preBlock">
															            	<table style="margin:auto;height: 100%;font-size:18px;display:none;" id="FileSuccessNameTable">
															            		<tr>
															            			<td>
															            				<i style="font-size:50px;" class="bx bx-file"  ></i>
															            				
															            			</td>
															            			<td style="width:10px;">
															            				<p> : </p>
															            			</td>
															            			<td>
													            						<p id="FileSuccessName" ></p>
													            					</td>
															            		</tr>
															            	</table>						                						             									
															            </div>
														            <div class="delete" id="del">×</div>
														        	</div>		       
											    		</div>
													</td>
													<td >
														<div style="width:10px;"></div>
													</td>
													<td valign="top">
														<button id="FileAnno" class=""  type="button"   style="border-style: none;background:white;">
											            	<i style="font-size:20px;" class="bx bx-info-circle"  ></i>
											            </button>
													</td>
												</tr>
												</table>
  											<div id="email_anno" style="display:none;">
												<div style="width:96%;margin-left:2%;text-align:center;margin-top:20px;line-height:1.2;">
													
													<p >  Please enter your email address and we will contact you by email after the task is completed.</p>		
												</div>
											</div>
											
											<div id="file_anno" style="display:none ;">
												<div style="width:96%;margin-left:2%;padding:20px;display: flex;align-items: center;justify-content: center;   text-align: justify;margin:0 auto;line-height:1.2;">		
													<p >  Input a scRNA-seq expression profile ( .txt / .csv ) with row name as gene symbol and with column name as cell name. <br/>Note that the value should be split by "Tab". </p>		
													
													
												</div>
													
												<div>
													<img alt="" src="img/exp.png" style="width:350px;margin-left:-40px;">
												</div>											
											</div>	
							        </div>
							        <div id="upload_right">
							        	<table>
							        		<tr>
							        			<td>
														<div  style="width:200px;"><p style="font-size:20px;">MinCountsPerGene : </p></div>
												</td>
												<td>
														<div id="MinCountsPerGene" style="width:400px;"></div>
												</td>
							        		</tr>
							        		<tr style="height:30px;"></tr>
							        		<tr>
							        			<td>
														<div  style="width:200px;"><p style="font-size:20px;">MinSamples : </p></div>
												</td>
												<td>
														<div id="MinSamples" style="width:400px;"></div>
												</td>
							        		</tr>
							        	</table>
							         </div>
							         <br/>
<!-- 							         -->
							        <table>
							        
							        	<tr>							        	
							        		<td>							        		
							        			<div id="Submit_email" >
									              	<input id="fileqcmpsubmit_email"   type = "submit" value="Submit" onclick="emaile_submit()"
																	style="height:40px;width:100px; border:1px solid #969696; border-radius:5px;font-size:20px;transition: ease-in all 0.25s;font-weight:bold;" 
																	onfocus="this.className='input_on';this.οnmοuseοut=''" 
																	onblur="this.className='input_off';this.οnmοuseοut=function(){this.className='input_out'};" 
																	onmousemove="this.className='input_move'" 
																	onmouseout="this.className='input_out'"
																/>
									              </div>
							        		</td>
							        		
							        		<td>
							        		<div id="Submit_email" >
							        			<button  class="" type="button" 
													style="height:40px;width:100px; border:1px solid #969696; border-radius:5px;font-size:20px;transition: ease-in all 0.25s;font-weight:bold;" 
													onfocus="this.className='input_on';this.οnmοuseοut=''" 
													onblur="this.className='input_off';this.οnmοuseοut=function(){this.className='input_out'};" 
													onmousemove="this.className='input_move'" 
													onmouseout="this.className='input_out'">
													<a style='text-decoration:none;' href='download_loading.jsp?path=base/user_example.7z&name=user_example.7z'>Example</a>
												</button>
											</div>
							        		</td>
							        	</tr>
							        	
							        </table>
						              <br/><br/>
						        </div>
						   </div>
		  </div>
          </div>

<div id="success_msg" style="display: none;">
	<div style="text-align:right;">
		<a href='#' onclick="closeSuccess_msg()"> <i  class="bx bx-message-square-x bx-sm"></i></a>
				
	</div>
	<table style="text-align:left;margin-left:15px;width:100%;">
		<tr style="height:0px;"></tr>
		<tr>
			<td style="text-align:left;width:50px;"><i style="font-size:40px;" class='bx bx-loader bx-spin'></i></td>
			<td>
				<p id="jobID_show" style="font-size:20px;text-align:center;"></p>
			</td>
			
		</tr>
	</table>
</div>



        </div>

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
  
<script type="text/javascript" language="javascript" src="js/base/jquery.dataTables.min.js"></script>
<script type="text/javascript" language="javascript" src="js/base/dataTables.buttons.min.js"></script>
<script type="text/javascript" language="javascript" src="js/base/buttons.html5.min.js"></script>
<!-- //plotly d3 -->
<script type="text/javascript" language="javascript" src="js/base/plotly-2.6.3.min.js"></script>
<script type="text/javascript" language="javascript" src="js/base/d3.min.js"></script>
  <!-- Template Main JS File -->
<script src="assets/js/main.js"></script>
<script type="text/javascript" language="javascript" src="js/layui.js"></script>
<script src="js/layer.js"></script>
<script src="js/layui.js"></script>
<script src="js/xm-select.js" type="text/javascript" charset="utf-8"></script>
<script src="js/echarts.js" type="text/javascript" charset="utf-8"></script>
<script src="js/MyecharsUse.js" type="text/javascript" charset="utf-8"></script>
<script src="js/MyTableUse.js" type="text/javascript" charset="utf-8"></script>
<script src="js/MyfuctionUse.js" type="text/javascript" charset="utf-8"></script>
<script src="js/MySubmitFuction.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript">
var timer=0;
//email
$('#choose_emil_select').hover(function(){
    $('#email_anno').show();
    },function(){
    timer=setTimeout(function(){
        $('#email_anno').hide();
    },100);
});
$('#email_anno').mouseover(function(){
    //clearTimeout(timer);
    $('#email_anno').hide();
});
//file
$('#FileAnno').hover(function(){
    $('#file_anno').show();
    },function(){
    timer=setTimeout(function(){
        $('#file_anno').hide();
    },100);
});
$('#file_anno').mouseover(function(){
    //clearTimeout(timer);
    $('#file_anno').hide();
});
</script>
</body>
</html>