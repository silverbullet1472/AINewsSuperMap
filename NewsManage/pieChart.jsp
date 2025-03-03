<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML>
<html>
<head>
<base href="<%=basePath%>">

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<link href="vendor/font-awesome/css/font-awesome.min.css"
	rel="stylesheet" type="text/css">
<link href="css/sb-admin.css" rel="stylesheet">

<script src="js/echarts.common.min.js"></script>

<script src="js/jquery.js"></script>

<title>新闻信息</title>
</head>
<style>
.ol-popup-closer {
	text-decoration: none;
	position: absolute;
	top: 2px;
	right: 8px;
}

.ol-popup-closer:after {
	content: "✖";
}
</style>
<body style="height: 100%; margin: 0;background:rgba(255,255,255,0)">






	<div class="card mb-3" style="background:rgba(255,255,255,0.8)">
		<a href="#" id="pie-popup-closer" class="ol-popup-closer"></a>
		<div class="card-header">
			<i class="fa fa-area-chart"></i> 各省分布饼状统计图
		</div>
		<div style="width:100%;">
			<div id="main1"
				style="width:33%;height: 550px; float:left;overflow:hidden;"></div>
			<div id="main2"
				style="width:33%;height: 550px;float:right;overflow:hidden;"></div>
			<div id="main3"
				style="width:33%;height: 550px;float:right;overflow:hidden;"></div>
		</div>
	</div>


	<script src="vendor/jquery/jquery.min.js"></script>
	<script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
	<script src="vendor/jquery-easing/jquery.easing.min.js"></script>
	<script src="js/sb-admin.min.js"></script>


</body>
</html>
<script type="text/javascript">

	var piePopupCloser = document.getElementById("pie-popup-closer");

	function loadData(option, sta_class) {
		$.ajax({
			type : 'post', //传输类型
			async : false, //同步执行
			url : 'loadChart', //web.xml中注册的Servlet的url-pattern

			dataType : 'json', //返回数据形式为json
			success : function(result) {
				if (result) {

					option.series[0].data = [];

					var myArr = new Array();
					for (var i = 0; i < result.length; i++) {
						var sInfo;
						if (sta_class == 'summary') {
							sInfo = {
								"name" : result[i].province,
								"value" : result[i].summary,
							};
						}
						if (sta_class == 'superNum') {
							sInfo = {
								"name" : result[i].province,
								"value" : result[i].superNum,
							};
						}
						if (sta_class == 'destinationNum') {
							sInfo = {
								"name" : result[i].province,
								"value" : result[i].destinationNum,
							};
						}

						myArr.push(sInfo);
						option.series[0].data.push(myArr[i]);
						console.log(myArr[i]);
					}
				}
			},
			error : function(errorMsg) {
				alert("加载数据失败");
			}
		}); //AJAX
	} //loadData()



	// 绘制图表
	var myChart1 = echarts.init(document.getElementById('main1'));
	var myChart2 = echarts.init(document.getElementById('main2'));
	var myChart3 = echarts.init(document.getElementById('main3'));
	var option1 = {
		title : {
			text : '新闻信息',

			left : 'center',
			padding : 30
		},
		tooltip : {
			formatter : "{b} : {c} ({d}%)"
		},
		series : [
			{
				type : 'pie',
				radius : '55%',
				center : [ '50%', '60%' ],
				itemStyle : {
					emphasis : {
						shadowBlur : 10,
						shadowOffsetX : 0,
						shadowColor : 'rgba(0, 0, 0, 0.5)'
					}
				}
			}
		]
	};

	var option2 = {
		title : {
			text : '冷',

			left : 'center',
			padding : 30
		},
		tooltip : {
			formatter : "{b} : {c} ({d}%)"
		},
		series : [
			{
				type : 'pie',
				radius : '55%',
				center : [ '50%', '60%' ],
				itemStyle : {
					emphasis : {
						shadowBlur : 10,
						shadowOffsetX : 0,
						shadowColor : 'rgba(0, 0, 0, 0.5)'
					}
				}
			}
		]
	};
	var option3 = {
		title : {
			text : '总数',

			left : 'center',
			padding : 30
		},
		tooltip : {
			formatter : "{b} : {c} ({d}%)"
		},
		series : [
			{
				type : 'pie',
				radius : '55%',
				center : [ '50%', '60%' ],
				itemStyle : {
					emphasis : {
						shadowBlur : 10,
						shadowOffsetX : 0,
						shadowColor : 'rgba(0, 0, 0, 0.5)'
					}
				}
			}
		]
	};
	loadData(option1, 'superNum');
	loadData(option2, 'destinationNum');
	loadData(option3, 'summary');
	myChart1.setOption(option1);
	myChart2.setOption(option3);
	myChart3.setOption(option2);

	piePopupCloser.onclick = function() {
		parent.document.getElementById("pie").style.display = "none";
	};
</script>