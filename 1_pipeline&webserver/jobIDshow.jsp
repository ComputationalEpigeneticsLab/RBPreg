<%@ page language="java" contentType="text/html; charset=utf-8"
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
<!--   <link href="assets/img/apple-touch-icon.png" rel="apple-touch-icon"> -->

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
<link rel="stylesheet" type="text/css" href="css/jobidshow.css" />
<link rel="stylesheet" type="text/css" href="css/layui.css" />
<title>Tutorials</title>

</head>
<style>


</style>
<body>
<%
//get  JobID 
String JobID="";
JobID=request.getParameter("task_id");
%>
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

        
        <h2>Job Result</h2>

      </div>
    </section><!-- End Breadcrumbs -->

    <!-- ======= Blog Section ======= -->
    <section id="blog" class="blog">
      <div class="container">

        <div class="row">

          <div class="col-lg-12 ">
		  <div id="whole_results" class="sidebar">
          	<div id="parameter_details" >
          		<div> <h3><strong>I. Basic information</strong></h3>  </div>
          		<div id="parameter_left">
          			<div style="width:98%;margin-left:1%;text-align:center;font-size:18px;">
						<strong style="font-size:18px;"><p id="explain_left_content">Parameters used in analysis</p></strong>
					</div>
						<div style="height:50px;width:98%;margin-left:1%;"></div>
						<div style="width:98%;margin-left:1%;text-align:center;font-size:15px;min-height:50px;">
							<table class="table table-bordered table-hover dataTable" >
								<thead>
									<tr >
										<td>UploadFile name</td>
										<td>Job ID</td>
										<td >MinCountsPerGene </td>
										<td >MinSamples</td>
										</tr>
								</thead>
									<tr>
										<td id="select_filename">LC_cancer.txt</td>
										<td id="select_JobId">example</td>
										<td id="select_MinCountsPerGene">0.03</td>
										<td id="select_MinSamples">0.01</td>
									</tr>
							</table>
						</div>
          		</div>
          		<div id="parameter_right">
          			<div id="parameter_right_pieGene"></div>
          		</div>
          	</div>
          	
          	<div id="whole_re_details" >
          		<div> <h3><strong>II. Global RBP-gene regulation</strong></h3>  </div>
          		<br/>
          		<div id="main_table" >
          			<table style="margin:auto;width:100%;">
          				<tr>
          					<td>
          						<div style="text-align:center;">
          							<table id="scenic_re_table" class="table table-bordered table-hover dataTable" style="margin:auto;text-align:center;font-size:15px;">
          								<thead >
          									<tr>
          										<th>RBP</th>
          										<th>Target</th>
<!--           										<th>HighAnnot</th> -->
          										<th>nMotifs</th>
          										<th>bestMotif</th>
          										<th>NES</th>
          										<th>highConfAnnot</th>        										
          										<th>CoexWeight</th>
          										<th>spearCor</th>
          									</tr>
          								</thead>
          							</table>
          						</div>
          					</td>
          					<td style="width:5px;"></td>
          					<td valign="top">
          						<div >
									<a id="scenic_re_table_download" href="" title="download table"><i class="bx bx-cloud-download bx-sm"></i></a>									     		
								</div>
          					</td>
          				</tr>
          			</table>
          			<div id="MotifPlot" style="display:none ;">
						<table style="text-align:center;margin-left:5px;">
							<tr>
								<td>
									<img id="motifplot" src='base/motif_picture/DDX58_GCGCGC_473.png' style='margin-left:0px;height:240px;'>
								</td>
								<td valign="top">
									<a href='#main_table' onclick="closeMotif()"> <i  class="bx bx-message-square-x bx-sm"></i></a>
									
								</td>
							</tr>
						</table>
					</div>
          		</div>	
          		<br/>
          		<div> <p style="font-size:25px;"><strong>Activities of RBP regulators</strong></p>  </div>
          		<br/>
          		<div id="scenic_violin_all" class="layui-tab layui-tab-card" >
					<ul class="layui-tab-title">
						<li class="layui-this" id="Scenic_AUCviolin">  <p style="font-size:18px;width:250px;">AUC activities </p>  </li>
						<li id="Scenic_EXPviolin"> <p id="showEXPviolin_plot" style="font-size:18px;width:250px;" >Expression activities </p></li>
					</ul>
					<div class="layui-tab-content" style="height:">
						<div id="" class="layui-tab-item layui-show">
							<div id="Scenic_AUCviolin_plot"></div>
						</div>
						<div id="" class="layui-tab-item layui">
							<div id="Scenic_EXPviolin_plot"></div>
						</div>
					</div>
				</div>
          		<br/>
          		<div> <p style="font-size:25px;"><strong>Pathways enriched by RBP targets</strong></p>  </div>
          		<br/>
          		<div id="scenic_heatmap_all" class="layui-tab layui-tab-card" >
					<ul class="layui-tab-title">
						<li class="layui-this" id="Scenic_CancerHallmark">  <p style="font-size:18px;width:250px;">Cancer hallmarks</p>  </li>
						<li id="Scenic_imm"> <p style="font-size:18px;width:250px;" id="" >Immune pathways </p></li>
					</ul>
					<div class="layui-tab-content" style="height:">
						<div id="" class="layui-tab-item layui-show">
							<div id="Scenic_CancerHallmark_plot" style="font-size:20px;"></div>
						</div>
						<div id="" class="layui-tab-item ">
							<div id="Scenic_imm_plot" style="font-size:20px;"></div>
						</div>
					</div>
				</div>
          	</div>
          	<br/>
<!-- ###############################  single ################################ -->
          	<div id="single_re_details" >
          		<div> <h3><strong>III. Regulation for RBP of interest</strong></h3>  </div>
          		<br/>
          		<div class="shadow_ues_option" style= "width:100%;height:51px;text-align:center;">
					<div style= "height:9px;"></div>
					<table style="margin-left:20px;">
						<tr>
							<td>
								<P> <strong style="font-size:20px;">Details of the RBP regulation :</strong> </P>
							</td>
							<td style="width:30px;"></td>
							<td>
								<div id="single_regulons_options" style="width:400px;height:35px;"></div>
							</td>
						</tr>
					</table>
				</div>
				<div id="single_all" class="layui-tab layui-tab-card" >
					<ul class="layui-tab-title">
						<li class="layui-this" id="single_table">  <p style="font-size:18px;width:250px;">RBP-gene</p>  </li>
						<li id="single_circos"> <p style="font-size:18px;width:250px;" id="" >Regulatory network </p></li>
						<li id="single_tsen" > <p style="font-size:18px;width:250px;" >RBP activities </p></li>
					</ul>
					<div class="layui-tab-content" style="height:">
						<div id="" class="layui-tab-item layui-show">
							<div style="width:96%;text-align:center;margin-left:2%;">
								<table id="single_re_table" class="table table-bordered table-hover dataTable" style="font-size:15px;vertical-align: middle;margin:auto;">
          								<thead >
          									<tr>
          										<th>RBP</th>
          										<th>Target</th>
          										<th>NES</th>
          										<th>spearCor</th>
          										<th>CoexWeight</th>
          										<th>bestMotif</th>
          									</tr>
          								</thead>
          						</table>
							</div>
							<div id="MotifPlot_single" style="display:none ;">
								<table style="text-align:center;margin-left:5px;">
									<tr>
										<td>
											<img id="motifplot_single" src='base/motif_picture/DDX58_GCGCGC_473.png' style='margin-left:0px;height:240px;'>
										</td>
										<td valign="top">
											<a href='#single_all' onclick="closeMotif_single()"> <i  class="bx bx-message-square-x bx-sm"></i></a>
											
										</td>
									</tr>
								</table>
							</div>
						</div>
						<div id="single_re_circos" class="layui-tab-item layui ">
							<div id="singleRBP_circos_plot"></div>
						</div>
						<div id="single_re_tsen" class="layui-tab-item layui " >
							<div id="">
								<div id="single_regAUC_left">
									<img id="img_auc_left" src=""  style='margin-left:0px;height:480px;'>
								</div>
								<div id="single_regAUC_right">
									<img id="img_auc_right" src=""  style='margin-left:0px;height:480px;'>
								</div>
							</div>
						</div>
					</div>
				</div>
				
          	</div>
		  </div>
          </div><!-- End blog entries list -->


        </div>

      </div>
    </section><!-- End Blog Section -->

  </main><!-- End #main -->

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
<!-- read result file -->
<script  type="text/javascript" charset="utf-8">
var JobID='<%=JobID %>';
var path="";
if (JobID=="example"){
	path="example/example.txt";
}else{
	path="upload/"+JobID+"/job_re.txt";
}
//console.log(path);
$.getJSON(path, "", function(data) {
//console.log(data);
	webPath=data.basefolder;

		if (data.UserUploadFileName.length>20){
	 		var uploadFileName_out=data.UserUploadFileName.substring(0,10)+"...";
			document.getElementById("select_filename").innerHTML=uploadFileName_out;
	 		}else{
			document.getElementById("select_filename").innerHTML=data.UserUploadFileName;
			}
		var job_id=data.JobId;
		if(job_id.length>20){
			document.getElementById("select_JobId").innerHTML=job_id.substring(0,15)+"...";
		}else{
			document.getElementById("select_JobId").innerHTML=job_id;
		}		
		document.getElementById("select_MinCountsPerGene").innerHTML=data.select_MinCountsPerGene;
		document.getElementById("select_MinSamples").innerHTML=data.select_MinSamples;

//gene
	var pie_gene=data.parameter_right_pieGene.split(",");
	echars_pie_gene(Number(pie_gene[0]),Number(pie_gene[1]));
//scenic_re_table
	//console.log(webPath+"/"+data.ScenicReMainTable);
	WholeReMainTable(webPath+"/"+data.ScenicReMainTable);
//download scenic_re_table_download
	var downloadPath="download_loading.jsp?path="+webPath+"/"+data.ScenicReMainTable_download+"&name=RegulonInfo.txt";
	document.getElementById("scenic_re_table_download").href = downloadPath;
// AUC violin 
	var filepath=webPath+"/"+data.Scenic_AUCviolin_file;
	var celltype_all=data.Scenic_AUCviolin_regName.split(",");
	var color_all=data.Scenic_AUCviolin_regColor.split(",");
	var style_all=[];				    				    
	for (var i=0;i<celltype_all.length;i++)
				{ 	var json0={};
					var json_value={};
			    	var json_color={};
			    	json_color["color"]=color_all[i];
					json_value["line"]=json_color;		
					json0["target"]=celltype_all[i];		
					json0["value"]=json_value;		
					style_all.push(json0);							
				}
				
	plotly_violin_auc(filepath,style_all);
//exp violin 

var filepath=webPath+"/"+data.Scenic_EXPviolin_file;
		var celltype_all=data.Scenic_EXPviolin_regName.split(",");
		var color_all=data.Scenic_EXPviolin_regColor.split(",");
		var style_all=[];				    				    
		for (var i=0;i<celltype_all.length;i++)
					{ 	var json0={};
						var json_value={};
				    	var json_color={};
				    	json_color["color"]=color_all[i];
						json_value["line"]=json_color;		
						json0["target"]=celltype_all[i];		
						json0["value"]=json_value;		
						style_all.push(json0);							
					}
					
		plotly_violin_exp(filepath,style_all);
///enrich scatter
var hallmark_scatter=data.hallmark_scatter;
if (hallmark_scatter=="error"){
	//Scenic_CancerHallmark_plot
	document.getElementById("Scenic_CancerHallmark_plot").innerHTML="No significant results !";
}else{
var scatter_data=data.hallmark_scatter_value_s_data;
		scatter_data=scatter_data.split(";");
		var scatter_data_valuearray = [];				
		for (var i=0;i<scatter_data.length;i++)
			{ 
				var a=scatter_data[i].split(",");
				var b=[];
				for (var j=0;j<a.length;j++){
					if(j<=1){
						b.push(a[j]);
					}else{
						b.push(Number(a[j]));
					}
					}
			scatter_data_valuearray.push(b);
			}
		var x_data=data.hallmark_scatter_x_s_data.split(",");
		var y_data=data.hallmark_scatter_y_s_data.split(",");
		var point_min=Number(data.hallmark_scatter_inter_v_min);
		var point_max=Number(data.hallmark_scatter_inter_v_max);
		var color_min=Number(data.hallmark_scatter_p_v_min);
		var color_max=Number(data.hallmark_scatter_p_v_max);
		echars_hallmark_scatter(scatter_data_valuearray,x_data,y_data,point_min,point_max,color_min,color_max);
}
//scatter imm
var imm_scatter=data.imm_scatter;
if (imm_scatter=="error"){
	//Scenic_CancerHallmark_plot
	document.getElementById("Scenic_imm_plot").innerHTML="No significant results !";
}else{
var scatter_data=data.imm_scatter_value_s_data;
		scatter_data=scatter_data.split(";");
		var scatter_data_valuearray = [];				
		for (var i=0;i<scatter_data.length;i++)
			{ 
				var a=scatter_data[i].split(",");
				var b=[];
				for (var j=0;j<a.length;j++){
					if(j<=1){
						b.push(a[j]);
					}else{
						b.push(Number(a[j]));
					}
					}
			scatter_data_valuearray.push(b);
			}
		var x_data=data.imm_scatter_x_s_data.split(",");
		var y_data=data.imm_scatter_y_s_data.split(",");
		var point_min=Number(data.imm_scatter_inter_v_min);
		var point_max=Number(data.imm_scatter_inter_v_max);
		var color_min=Number(data.imm_scatter_p_v_min);
		var color_max=Number(data.imm_scatter_p_v_max);
		echars_imm_scatter(scatter_data_valuearray,x_data,y_data,point_min,point_max,color_min,color_max);
}
//////single//////
//reg select
var data_option=data.Regulons.split(",");
		var data_option_valuearray = [];
		for (var i=0;i<data_option.length;i++)
					{ 
						json={}
						json['name']=data_option[i];
						json['value']=data_option[i];
						data_option_valuearray.push(json);
					}
					var demo1_gene = xmSelect.render({
						el: '#single_regulons_options', 
						size: 'small',//选中的之后显示的字的大小
					    theme: {color: '#f37b1d',},//主题颜色
						radio: true,
						clickClose: true,
						data: [],
						on: function(data){//监听
							var arr = data.arr;
							var change = data.change;
							//isAdd, 此次操作是新增还是删除
							var isAdd = data.isAdd;
							var slectvalue=arr[0]["value"].split(" ")[0];//rbp name
							var slectvalue_Tablefile=slectvalue+".txt";//rbp.txt 
							//console.log(slectvalue_Tablefile);
						//reload table
							var table = $('#single_re_table').DataTable();
							table.ajax.url( webPath+"/"+slectvalue_Tablefile).load();
						//read circos
							var circos_path=webPath+"/"+slectvalue+".json";
							var circos_color="#FF3030,#8CC1D6".split(",");
							echars_circos_singleRBP(circos_path,circos_color);
						// auc img
							var img_dir=webPath+"/"+"output/Step3_RegulonActivity_tSNE_colByActivity"+"/";
						    var rbp_option=arr[0]["value"];
							document.getElementById("img_auc_left").src = img_dir+rbp_option+"_AUC.png";
							document.getElementById("img_auc_right").src = img_dir+rbp_option+"_histogram.png";
						}
					})
				 
					demo1_gene.update({
					data: data_option_valuearray
					})
		// 赋值
			demo1_gene.setValue([
			{name: data_option[0], value: data_option[0]},
			])

//table singReMainTable
	var single_file_name=data_option[0].split(" ")[0]+".txt";
	singReMainTable(webPath+"/"+single_file_name);		
//circos
	var circos_path=webPath+"/"+data.SingleRBP_circos_file;
	var circos_color=data.SingleRBP_circos_color.split(",");
	echars_circos_singleRBP(circos_path,circos_color);
//img
var first_img=data_option[0];
//console.log(first_img);
var img_dir=webPath+"/"+"output/Step3_RegulonActivity_tSNE_colByActivity"+"/";
document.getElementById("img_auc_left").src = img_dir+first_img+"_AUC.png";
document.getElementById("img_auc_right").src = img_dir+first_img+"_histogram.png";
	
});


</script>

</body>
</html>