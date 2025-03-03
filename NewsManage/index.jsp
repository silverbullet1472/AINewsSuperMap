<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>
<%
    Object email = session.getAttribute("email");
    if (email == null) {
        email = "游客";
        System.out.println("空");
    } else {
        System.out.println(email);
    }
%>
<!doctype html>
<html style="overflow:hidden;">
<head>
    <meta charset="utf-8" http-equiv="Access-Control-Allow-Oringin"
          content="http://localhost">
    <link rel="stylesheet" href="css/ol.css" type="text/css">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport"
          content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <script src="js/ol.js" type="text/javascript"></script>
    <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="vendor/font-awesome/css/font-awesome.min.css"
          rel="stylesheet" type="text/css">
    <link href="css/sb-admin.css" rel="stylesheet">
    <link rel="stylesheet" href="css/measuretool.css">
    <link rel="shortcut icon" type="image/x-icon" href="images/tesla.png"/>
    <script src="js/measuretool.js" type="text/javascript"></script>


    <style>
        .map {
            height: 100%;
            width: 100%;
        }
    </style>
    <style type="text/css">
        .ol-custom-overviewmap, .ol-custom-overviewmap.ol-uncollapsible {
            bottom: 8px;
            left: auto;
            right: 50px;
            top: auto;
        }

        .ol-custom-overviewmap
        :not
 
(
.ol-collapsed
 
) {
            border: 1px solid black;


        }

        .ol-custom-overviewmap .ol-overviewmap-map {
            border: none;
            width: 200px;
            height: 200px;
        }

        .ol-custom-overviewmap .ol-overviewmap-box {
            border: 2px solid blue;
        }

        .ol-custom-overviewmap:not (.ol-collapsed ) button {
            bottom: auto;
            left: auto;
            right: 1px;
            top: 1px;
        }

        .ol-measuretool {
            right: 500px;
            left: 50px;
        }

        .ol-popup {
            position: absolute;
            background-color: #FFFFFF;
            -webkit-filter: drop-shadow(0 1px 4px rgba(0, 0, 0, 0.2));
            filter: drop-shadow(0 1px 4px rgba(0, 0, 0, 0.2));
            padding: 15px;
            border-radius: 10px;
            border: 1px solid #cccccc;
            bottom: 12px;
            left: -50px;
            width: 350px;
        }

        .ol-popup:after, .ol-popup:before {
            top: 100%;
            border: solid transparent;
            content: " ";
            height: 0;
            width: 0;
            position: absolute;
            pointer-events: none;
        }

        .ol-popup:after {
            border-top-color: #eeeeee;
            border-width: 10px;
            left: 48px;
            margin-left: -10px;
        }

        .ol-popup:before {
            border-top-color: #cccccc;
            border-width: 11px;
            left: 48px;
            margin-left: -11px;
        }

        .ol-popup-closer {
            text-decoration: none;
            position: absolute;
            top: 2px;
            right: 8px;
        }

        .ol-popup-closer:after {
            content: "✖";
        }

        input[type="radio"] {
            width: 20px;
            height: 20px;
            opacity: 0;
        }

        label[for="item1"] {
            position: absolute;
            left: 5px;
            top: 8px;
            width: 20px;
            height: 20px;
            border-radius: 50%;
            border: 1px solid #999;
        }

        label[for="item2"] {
            position: absolute;
            left: 5px;
            top: 8px;
            width: 20px;
            height: 20px;
            border-radius: 50%;
            border: 1px solid #999;
        }

        label[for="item3"] {
            position: absolute;
            left: 5px;
            top: 8px;
            width: 20px;
            height: 20px;
            border-radius: 50%;
            border: 1px solid #999;
        }

        /*设置选中的input的样式*/
        /* + 是兄弟选择器,获取选中后的label元素*/
        input:checked + label {
            background-color: #006eb2;
            border: 1px solid #006eb2;
        }

        input:checked + label::after {
            position: absolute;
            content: "";
            width: 5px;
            height: 10px;
            top: 3px;
            left: 6px;
            border: 2px solid #fff;
            border-top: none;
            border-left: none;
            transform: rotate(45deg)
        }

        #cursorIm {
            position: absolute;
        }

        .dropbtn {
            background-color: rgba(0, 0, 0, 0);
            color: black;
            font-weight: bold;
            padding: 16px;
            font-size: 16px;
            border: none;
            cursor: pointer;
        }

        .dropdown {
            position: relative;
            display: inline-block;
        }

        .dropdown-content {
            display: none;
            position: absolute;
            background-color: #f9f9f9;
            min-width: 160px;
            box-shadow: 0px 8px 16px 0px rgba(0, 0, 0, 0.2);
        }

        .dropdown-content a {
            color: black;
            padding: 12px 16px;
            text-decoration: none;
            display: block;
        }

        .dropdown-content a:hover {
            background-color: #f1f1f1
        }

        .dropdown:hover .dropdown-content {
            display: block;
        }

        .dropdown:hover .dropbtn {
            background-color: rgba(0, 0, 0, 0);
        }
    </style>
    <script
            src="http://cdn.static.runoob.com/libs/jquery/2.1.1/jquery.min.js"></script>
    <script type="text/javascript" src="js/jquery.sliphover.min.js"></script>
    <script type="text/javascript" src="js/jquery.form.js"></script>


    <title>即时新闻信息管理系统</title>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top"
     id="mainNav">
    <a class="navbar-brand" href="index.jsp">即时新闻信息管理系统 &nbsp <img
            src="images/tesla.png" width="32" height="29" alt=""/></a>

    <button class="navbar-toggler navbar-toggler-right" type="button"
            data-toggle="collapse" data-target="#navbarResponsive"
            aria-controls="navbarResponsive" aria-expanded="false"
            aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarResponsive">
        <ul class="navbar-nav navbar-sidenav" id="exampleAccordion">
            <li class="nav-item" data-toggle="tooltip" data-placement="right"
                title="地图"><a class="nav-link" href="index.jsp"> <i
                    class="fa fa-fw fa-map"></i> <span class="nav-link-text">地图</span>
            </a></li>
            <!-- 				<li class="nav-item" data-toggle="tooltip" data-placement="right" -->
            <!-- 					title="省界图"><a class="nav-link" href="javascript:loadWMS()"> -->

            <!-- 						<i class="fa fa-fw fa-sitemap"></i> <span class="nav-link-text">省界图</span> -->
            <!-- 				</a></li> -->
            <li class="nav-item" data-toggle="tooltip" data-placement="right"
                title="热力图"><a class="nav-link"
                               href="javascript:loadheatmap()"> <i
                    class="fa fa-fw fa-thermometer"></i> <span class="nav-link-text">热力图</span>
            </a></li>
            <li class="nav-item" data-toggle="tooltip" data-placement="right"
                title="柱状图"><a class="nav-link"
                               href="javascript:showColumnchart()"> <i
                    class="fa fa-fw fa-bar-chart"></i> <span class="nav-link-text">柱状图</span>
            </a></li>
            <li class="nav-item" data-toggle="tooltip" data-placement="right"
                title="饼状图"><a class="nav-link"
                               href="javascript:showPiechart()"> <i
                    class="fa fa-fw fa-pie-chart"></i> <span class="nav-link-text">饼状图</span>
            </a></li>

            <li class="nav-item" data-toggle="tooltip" data-placement="right"
                title="新闻介绍"><a class="nav-link nav-link-collapse collapsed"
                                 data-toggle="collapse" href="#collapseExamplePages"
                                 data-parent="#exampleAccordion"> <i class="fa fa-fw fa-file"></i>
                <span class="nav-link-text">新闻介绍</span>
            </a>
                <ul class="sidenav-second-level collapse" id="collapseExamplePages">
                    <li><a href="javascript:showDestinationIntro()">暖调新闻</a></li>
                    <li><a href="javascript:showSuperIntro()">冷调新闻</a></li>
                </ul>
            </li>
        </ul>
        <ul class="navbar-nav sidenav-toggler">
            <li class="nav-item"><a class="nav-link text-center"
                                    id="sidenavToggler"> <i class="fa fa-fw fa-angle-left"></i>
            </a></li>
        </ul>
        <ul class="navbar-nav ml-auto">

            <li class="nav-item">
                <form class="form-inline my-2 my-lg-0 mr-lg-2">
                    <div class="input-group">
                        <input class="form-control" type="text" id="searchkey"
                               placeholder="请输入主题名..."> <span class="input-group-btn">
								<button class="btn btn-primary" onclick="search()" type="button">
									<i class="fa fa-search"></i>
								</button>
							</span>
                    </div>
                </form>
            </li>
            <li class="nav-item"><a class="nav-link">欢迎：<%=email%>
            </a></li>
            <form id="loginout" action="login_out.jsp" method="post">
                <li class="nav-item"><a class="nav-link"
                                        href="javascript:loginOut()"> <i class="fa fa-fw fa-sign-out"></i>退出
                </a></li>
            </form>
        </ul>
    </div>
</nav>
<div id="map" class="map"></div>
<div id="column" style="display:none">
    <iframe src="" id="columnchart" name="iframe_a"
            style="position:absolute;top:100px;right:100px;
  		line-height: 30px;"
            allowtransparency="true"
            onload="this.height=iframe_a.document.body.scrollHeight" width=1100
            scrolling="no" frameborder="0"></iframe>
</div>

<div id="pie" style="display:none">
    <iframe src="" id="piechart" name="iframe_b"
            style="position:absolute;top:100px;right:100px;
  		line-height: 30px;"
            allowtransparency="true"
            onload="this.height=iframe_b.document.body.scrollHeight" width=1100
            scrolling="no" frameborder="0"></iframe>
</div>

<div id="super" style="display:none">
    <iframe src="" id="superIntro" name="iframe_c"
            style="position:absolute;top:150px;right:100px;
  		line-height: 30px;"
            allowtransparency="true"
            onload="this.height=iframe_c.document.body.scrollHeight" width=1100
            scrolling="no" frameborder="0"></iframe>
</div>

<div id="destination" style="display:none">
    <iframe src="" id="destinationIntro" name="iframe_d"
            style="position:absolute;top:150px;right:100px;
  		line-height: 30px;"
            allowtransparency="true"
            onload="this.height=iframe_d.document.body.scrollHeight" width=1100
            scrolling="no" frameborder="0"></iframe>
</div>


<form>
    <div
            style="position:absolute;top:70px;right:200px;
  line-height: 30px;">
        <input id="item1" type="radio" name="item" value="暖调新闻" checked>
        <label for="item1"></label> <span
            style="margin-left: 10px;font-weight:bold">暖调新闻</span>
    </div>
    <div
            style="position:absolute;top:70px;right:50px;
  line-height: 30px;">
        <input id="item2" type="radio" name="item" value="冷调新闻"> <label
            for="item2"></label> <span
            style="margin-left: 10px;font-weight:bold">冷调新闻</span>
    </div>

</form>

<div class="dropdown" id="addStationBt" style="position:absolute;top:54px;right:530px;
  line-height: 30px;">
    <button class="dropbtn">添加信息</button>
    <div class="dropdown-content">
        <a href="javascript:addSuperSta()">暖</a>
        <a href="javascript:addDestinationSta()">冷</a>
    </div>
</div>

<div class="dropdown"
     style="position:absolute;top:54px;right:350px;
  line-height: 30px;">
    <button class="dropbtn">前往最近POI</button>
    <div class="dropdown-content">
        <a href="javascript:findClosestStation()">选择当前位置</a> <a
            href="javascript:removeRoute()">清理当前路径</a>
    </div>
</div>


<div id="info"></div>
<div id="popup" class="ol-popup">
    <a href="#" id="popup-closer" class="ol-popup-closer"></a>
    <div id="popup-content">
        <table>
            <tr>
                <th id="name" name="editInfo" align="left">主题名</th>
            </tr>
        </table>
        <hr noshade=true/>
        <table rules="rows">
            <tr>
                <td><i class="fa fa-fw fa-map-marker"></i></td>
                <td><label id="address" name="editInfo">地址</label></td>
            </tr>
            <tr>
                <td><i class="fa fa-fw fa-phone"></i></td>
                <td><label id="phone" name="editInfo">电话</label></td>
            </tr>
        </table>
        <hr noshade=true/>
        <table rules="rows">
            <tr>
                <th style="text-align:left">新闻信息</th>
            </tr>

            <tr align="center">
                <td width=150>时间</td>
                <td width=150>地点</td>
                <td width=150>介绍</td>
            </tr>
            <tr align="center">
                <td name="editInfo" id="time">--</td>
                <td name="editInfo" id="price">--</td>
                <td name="editInfo" id="port">--</td>
            </tr>
        </table>
        <hr noshade=true/>
        <table>
            <tr>
                <th>街景</th>
            </tr>
        </table>
        <table>
            <tr>
                <div id="hover" align="center">
                    <a href="javascript:fileSelect();"><img id="stationImg"
                                                            src="images/addImage.png"
                                                            onerror="this.src='images/addImage.png'" width=100px
                                                            height=100px
                                                            title="<h5>上传图片</h5>"/> </a>
                    <form id="updateImage" action="updateImage" method="post"
                          enctype="multipart/form-data">
                        <input type="file" name="image" id="image"
                               onchange="fileSelected(this);" style="display:none;"/><br/>
                        <input type="text" name="std_id" id="std_id"
                               style="display:none;"/>
                        <button type="submit" id="submitImage">上传</button>
                    </form>


                </div>
            </tr>

        </table>


        <hr noshade=true/>

        <table>
            <tr>
                <td><a id="edit" href="#">编辑</a></td>
                <td><a id="delete" href="#">删除该点</a></td>
            </tr>

        </table>
    </div>
</div>

<script>
    var email = '<%=session.getAttribute("email")%>';
    console.log(email);
    if (email == "null") {

        $("#addStationBt").hide();
        $("#edit").hide();
        $("#delete").hide();
        $("#submitImage").hide();
    }
    var baseLayer = new ol.layer.Tile({
        source: new ol.source.XYZ({
            url: 'http://webrd01.is.autonavi.com/appmaptile?x={x}&y={y}&z={z}&lang=zh_cn&size=1&scale=1&style=8'
        })
    });
    //自定义鸟瞰图
    var overviewMapControl = new ol.control.OverviewMap({
        className: 'ol-overviewmap ol-custom-overviewmap',
        layers: [baseLayer],
        label: '\u00AB',
        collapsed: true,
        view: new ol.View({
            projection: 'EPSG:4326',
            center: [104, 35],
            zoom: 4
        })
    });
    //测距测面积
    var MeasureTool = new ol.control.MeasureTool({
        sphereradius: 6378137, //sphereradius
        className: 'ol-measuretool',
    });


    var geojsonObject;
    var vectorLayer;
    var vectorSource;
    var feature;
    var heatmap;
    var container = document.getElementById("popup");
    var popupCloser = document.getElementById("popup-closer");
    var oldstyle = new ol.style.Style({
        image: new ol.style.Circle({
            radius: 4,
            fill: null,
            stroke: new ol.style.Stroke({
                color: 'green',
                width: 3
            })
        })
    });
    var superStyle = new ol.style.Style({
        image: new ol.style.Icon({
            opacity: 1,
            src: 'images/super.png',
            scale: 0.4
        })
    });
    var destinationStyle = new ol.style.Style({
        image: new ol.style.Icon({
            opacity: 1,
            src: 'images/destination.png',
            scale: 0.4
        })
    });


    var overlay = new ol.Overlay({
        element: container,
        autoPan: true
    });


    var map = new ol.Map({
        controls: ol.control.defaults().extend([

            overviewMapControl,


        ]),
        layers: [baseLayer],
        target: document.getElementById('map'),
        overlays: [overlay],
        view: new ol.View({
            center: [114.3, 30.6],
            projection: 'EPSG:4326',
            maxZoom: 19,
            zoom: 12
        })
    });


    var Iconstyle = new ol.style.Style({
        image: new ol.style.Icon({
            src: 'images/marker.png',
            scale: 0.4
        })
    });

    var ClosestStationIconstyle = new ol.style.Style({
        image: new ol.style.Icon({
            src: 'images/closeStation.png',
            scale: 0.4
        })
    });


    function loadData(station_class) {
        $.ajax({
            type: "post",
            url: "loadData",
            data: {
                "class": station_class
            },

            success: function $(data) {


                geojsonObject = data;
                if (typeof geojsonObject != "undefined") {
                    vectorSource = new ol.source.Vector({
                        features: (new ol.format.GeoJSON()).readFeatures(geojsonObject)
                    });


                    var imgurl = null;
                    if (station_class == 'super') {
                        imgurl = 'images/super.png';
                    } else if (station_class == 'destination') {
                        imgurl = 'images/destination.png';
                    }

                    vectorLayer = new ol.layer.Vector({
                        source: vectorSource,
                        style: new ol.style.Style({
                            image: new ol.style.Icon({
                                opacity: 1,
                                src: imgurl,
                                scale: 0.4
                            }),
                        })
                    });
                    map.addLayer(vectorLayer);
                    console.log("加载" + station_class);

                }

            }
        });


    }

    loadData('super');


    var statu = 0;
    var addSta = 0;
    var newStaPro = null;
    var findClosestSta = 0;
    var sta_class = 1;
    var currentStaClass = 2;
    var std_id = "null";
    var coordinate;


    map.on('click', function (evt) {

        coordinate = evt.coordinate;

        console.log(coordinate);
        console.log(coordinate[0]);
        console.log(coordinate[1]);

        if (findClosestSta == 1) {

            showRoute(coordinate);
            document.getElementById("map").style.cursor = "default";
        }


        if (addSta == 1) {

            addStation(coordinate);
            document.getElementById("map").style.cursor = "default";
        }
        // 			addStation(coordinate);
        else {


            var pixel = map.getEventPixel(evt.originalEvent);
            feature = map.forEachFeatureAtPixel(pixel, function (feature, vectorLayer) {

                return feature;
            });

            var std_Im = document.getElementById('stationImg');

            if (feature != undefined) {
                feature.setStyle(Iconstyle);
                overlay.setPosition(coordinate);
                if (email != "null") {
                    $("#delete").show();
                }
                std_id = feature.get("f1");

                console.log(feature.get("f1"));
                console.log(std_id);
                std_Im.src = 'loadImage.jsp?STD_ID=' + std_id;

                document.getElementById("std_id").value = std_id;
                document.getElementById("name").innerHTML = feature.get("f2");
                document.getElementById("address").innerHTML = feature.get("f3");
                document.getElementById("phone").innerHTML = feature.get("f5");
                document.getElementById("time").innerHTML = feature.get("f6");
                document.getElementById("price").innerHTML = feature.get("f7");
                document.getElementById("port").innerHTML = feature.get("f8");


                container.style.display = 'block';

            }
            popupCloser.onclick = function () {
                popupClose();
            };
        }
    });

    function loadWMS() {
        var wmsLayer = new ol.layer.Tile({
            source: new ol.source.TileWMS({
                url: 'http://localhost:8080/geoserver/chinamap/wms',
                projection: 'EPSG:4326',
                params: {
                    'LAYERS': "chinamap:bou2_4l",
                    'TILED': false
                },
                serverType: 'geoserver'
            })
        });
        map.addLayer(wmsLayer);
    }

    function popupClose() {
        if (feature.get("f4") == 2) {
            feature.setStyle(superStyle);
        } else {
            feature.setStyle(destinationStyle);
        }
        container.style.display = 'none';
        popupCloser.blur();
        var edit = document.getElementById('edit');
        edit.innerHTML = '编辑';
        statu = 0;
        return false;
    }

    function loadheatmap() {
        heatmap = new ol.layer.Heatmap({
            source: vectorSource,
            blur: parseInt(16, 10),
            radius: parseInt(10, 10),
        });
        map.addLayer(heatmap);
        map.removeLayer(vectorLayer);
    }

    function update() {
        var NAME = document.getElementById("name").innerHTML;
        var ADDRESS = document.getElementById("address").innerHTML;
        var PHONE = document.getElementById("phone").innerHTML;
        var TIME = document.getElementById("time").innerHTML;
        var PRICE = document.getElementById("price").innerHTML;
        var PORT = document.getElementById("port").innerHTML;

        $.ajax({
            type: "post",
            url: "editData",
            async: false,
            data: {
                "ID": std_id,
                "NAME": NAME,
                "ADDRESS": ADDRESS,
                "PHONE": PHONE,
                "TIME": TIME,
                "PRICE": PRICE,
                "PORT": PORT
            },
            success: function (data) {
                alert("保存成功");
            }
        });

        vectorLayer.getSource().clear();
        map.removeLayer(vectorLayer);
        vectorLayer = null;
        if (feature.get("f4") == 1) {
            loadData('destination');
        } else {
            loadData('super');
        }


    }

    function addData() {
        var NAME = document.getElementById("name").innerHTML;
        var ADDRESS = document.getElementById("address").innerHTML;
        var PHONE = document.getElementById("phone").innerHTML;
        var TIME = document.getElementById("time").innerHTML;
        var PRICE = document.getElementById("price").innerHTML;
        var PORT = document.getElementById("port").innerHTML;
        console.log(newStaPro);
        $.ajax({
            type: "post",
            url: "addData",
            async: false,
            data: {
                "NAME": NAME,
                "ADDRESS": ADDRESS,
                "PHONE": PHONE,
                "TIME": TIME,
                "PRICE": PRICE,
                "PORT": PORT,
                "CLASS": sta_class,
                "LONGITUDE": coordinate[0],
                "LATITUDE": coordinate[1]
            },
            success: function (data) {
                alert("添加成功");
            }
        });

        addSta = 0;

    }


    var isFind = 0;

    function search() {
        if (vectorLayer == null) {
            alert("请先加载要素图层");
        }
        var features = vectorLayer.getSource().getFeatures();

        var value = $("#searchkey").val();

        if (value == null || value == "") {
            alert("请输入搜索关键字！");
            return;
        }


        var property = 'f2';
        for (var i = 0, ii = features.length; i < ii; i++) {

            if (features[i].get(property).indexOf(value) >= 0) {
                feature = features[i];
                isFind = 1;
                break;
            }
        }

        if (isFind == 0) {
            alert("请输入正确名称！");
        }
        feature.setStyle(Iconstyle); //高亮查询到的feature

        var coordinate = ol.extent.getCenter(feature.getGeometry().getExtent());
        console.log(ol.extent.getCenter(feature.getGeometry().getExtent()));
        overlay.setPosition(coordinate);
        var std_Im = document.getElementById('stationImg');
        std_id = feature.get("f1");
        std_Im.src = 'loadImage.jsp?STD_ID=' + std_id;
        document.getElementById("std_id").value = std_id;
        document.getElementById("name").innerHTML = feature.get("f2");
        document.getElementById("address").innerHTML = feature.get("f3");
        document.getElementById("phone").innerHTML = feature.get("f5");
        document.getElementById("time").innerHTML = feature.get("f6");
        document.getElementById("price").innerHTML = feature.get("f7");
        document.getElementById("port").innerHTML = feature.get("f8");

        container.style.display = 'block';
        console.log("lal");
        popupCloser.onclick = function () {
            popupClose();
        };

    }

    var edit = document.getElementById('edit');
    var item = document.getElementsByName('editInfo');
    var item_length = item.length
    var item_value = new Array(item_length);
    var deleteSta = document.getElementById('delete');

    deleteSta.onclick = function () {

        $.ajax({
            type: "get",
            url: "editData",
            async: false,
            data: {
                "ID": std_id,
            },
            success: function (data) {
                alert("删除成功");
            }
        });

        container.style.display = 'none';
        popupCloser.blur();

        vectorLayer.getSource().clear();
        map.removeLayer(vectorLayer);
        vectorLayer = null;
        if (feature.get("f4") == 1) {
            loadData('destination');
        } else {
            loadData('super');
        }

    }

    edit.onclick = function () {


        for (var i = 0; i < item_length; i++) {
            item_value[i] = item[i].innerHTML;
        }

        if (statu == 0) {
            edit.innerHTML = '保存';
            item[0].innerHTML = '<input type="txt" size="30" class="item_input"  value="' + item_value[0] + '">';
            item[1].innerHTML = '<input type="txt" size="30" class="item_input"  value="' + item_value[1] + '">';
            item[2].innerHTML = '<input type="txt" size="30" class="item_input"  value="' + item_value[2] + '">';
            for (i = 3; i < item_length; i++) {
                item[i].innerHTML = '<input type="txt" size="5" class="item_input"  value="' + item_value[i] + '">';
            }
            statu = 1;
        } else {
            edit.innerHTML = '编辑';
            var item_input = document.getElementsByClassName('item_input');
            for (i = 0; i < item_length; i++) {
                item_value[i] = item_input[i].value;
            }
            for (i = 0; i < item_length; i++) {
                item[i].innerHTML = item_value[i];
            }
            statu = 0;
            if (addSta == 1) {
                addData();
            } else {
                update();
            }
        }
        return false;

    }


    $(document).ready(function (e) {
        $('#hover').sliphover({
            backgroundColor: 'rgba(128,128,128,0.7)'
        });
    });


    function fileSelect() {
        if (email == "null") {
            alert("您现在是游客身份，不能上传图片！");
        } else if (std_id == '') {
            alert("请先保存信息后再进行上传图片操作！");

        } else {
            document.getElementById("image").click();
        }
    }

    function fileSelected(file) {
        var stationImg = document.getElementById('stationImg');
        if (file.files && file.files[0]) {
            stationImg.src = window.URL.createObjectURL(file.files[0]);
        }
    }

    $(document).ready(function () {
        $("#updateImage").ajaxForm(function (data) {
            if (data == "上传成功") {
                alert("上传成功!");
            } else {
                alert("上传失败！");
            }
        });
    });

    $(document).ready(function () {
        $('input[type=radio][name=item]').change(function () {


            if (this.value == "超级充电站") {

                map.removeLayer(vectorLayer);
                vectorLayer = null;
                currentStaClass = 2;

                loadData('super');
            } else if (this.value == '目的地充电站') {
                map.removeLayer(vectorLayer);
                vectorLayer = null;

                currentStaClass = 1;


                loadData('destination');
            }
        });
    });

    function loginOut() {
        $("#loginout").submit();
    }


    function addStation(coordinate) {
        var newStation = new ol.Feature({
            geometry: new ol.geom.Point(coordinate)
        });
        newStation.setStyle(Iconstyle);
        var source = new ol.source.Vector({
            features: [newStation]
        });
        var layer = new ol.layer.Vector({
            source: source
        });

        map.addLayer(layer);

        overlay.setPosition(coordinate);
        container.style.display = 'block';

        $("#delete").hide();
        document.getElementById("name").innerHTML = '名称';
        document.getElementById("address").innerHTML = '地址';
        document.getElementById("phone").innerHTML = '电话';
        document.getElementById("time").innerHTML = '--';
        document.getElementById("price").innerHTML = '--';
        document.getElementById("port").innerHTML = '--';
        document.getElementById('stationImg').src = '';
        std_id = '';
        edit.onclick();
        popupCloser.onclick = function () {
            addSta = 0;
            layer.getSource().clear();
            map.removeLayer(layer);
            layer = null;

            container.style.display = 'none';
            popupCloser.blur();

            vectorLayer.getSource().clear();
            map.removeLayer(vectorLayer);
            vectorLayer = null;
            if (currentStaClass == 1) {
                loadData('destination');
            } else {
                loadData('super');
            }

        };

    }


    function findClosestStation() {
        findClosestSta = 1;
        document.getElementById("map").style.cursor = "crosshair";
    }

    function showColumnchart() {
        console.log("lalalallala");
        document.getElementById("columnchart").src = "columnChart.jsp";
        document.getElementById("column").style.display = "block";
    }

    function showPiechart() {
        console.log("lalalallala");
        document.getElementById("piechart").src = "pieChart.jsp";
        document.getElementById("pie").style.display = "block";
    }

    function showSuperIntro() {
        console.log("lalalallala");
        document.getElementById("superIntro").src = "superIntro.jsp";
        document.getElementById("super").style.display = "block";
    }

    function showDestinationIntro() {
        console.log("lalalallala");
        document.getElementById("destinationIntro").src = "destinationIntro.jsp";
        document.getElementById("destination").style.display = "block";
    }

    function addSuperSta() {
        document.getElementById("map").style.cursor = "crosshair";
        addSta = 1;
        sta_class = 2;
        console.log("super");

    }

    function addDestinationSta() {
        document.getElementById("map").style.cursor = "crosshair";
        addSta = 1;
        sta_class = 1;
        console.log("des");

    }

    var result = 0;
    var start;
    var end;
    var startName;
    var endName;
    var projection = ol.proj.get("EPSG:4326");


    //矢量图层数据源
    sourceVector = new ol.source.Vector();
    //矢量图层
    var vector = new ol.layer.Vector({
        source: sourceVector,
        style: function (feature) {
            var status = feature.get("status");


            var _color = "#8f8f8f";
            if (status === "拥堵")
                _color = "#e20000";
            else if (status === "缓行")
                _color = "#ff7324";
            else if (status === "畅通")
                _color = "#00b514";

            return new ol.style.Style({
                stroke: new ol.style.Stroke({
                    color: _color,
                    width: 5,
                    lineDash: [10, 8]
                }),
            })
        }
    });
    map.addLayer(vector);
    //菜单栏点击事件
    var closeFeature;

    function showRoute(startCoordate) {
        //起点
        //构造提交api起点坐标

        start = GetCoordate(startCoordate);
        console.log("起点" + start);
        startName = "起点";
        //矢量元素
        var featureStart = new ol.Feature({
            geometry: new ol.geom.Point(startCoordate),
            name: '起点', //自定义属性

        });
        featureStart.setStyle(createFeatureStyle(featureStart, startName));
        sourceVector.addFeature(featureStart);

        //终点
        //构造提交api终点坐标
        endName = "终点";
        closeFeature = vectorSource.getClosestFeatureToCoordinate(startCoordate);
        console.log(closeFeature);
        closeFeature.setStyle(ClosestStationIconstyle);


        var endCoordate = closeFeature.getGeometry().getCoordinates();
        end = GetCoordate(endCoordate);
        console.log("终点" + end);
        //矢量元素
        var featureEnd = new ol.Feature({
            geometry: new ol.geom.Point(endCoordate),
            name: '终点', //自定义属性

        });
        featureEnd.setStyle(createFeatureStyle(featureEnd, endName));
        sourceVector.addFeature(featureEnd);
        ////请求数据
        getRouteResult(start, end);
        findClosestSta = 0;
    }

    //获取路径规划
    function getRouteResult(start, end) {
        var data = {
            key: "180fb392cb229ddf33f87160c957ee9a", //申请的key值
            origin: start, //起点
            destination: end, //终点
            extensions: "all"
        };
        $.ajax({
            url: "https://restapi.amap.com/v3/direction/driving?",
            type: "post",
            dataType: "jsonp",
            data: data,
            success: function (result) {
                var routes = result["route"]["paths"][0];
                var steps = routes["steps"];
                for (var i = 0; i < steps.length; i++) {
                    var route = steps[i];
                    var path = route["tmcs"];
                    for (var k = 0; k < path.length; k++) {
                        var routePath = path[k];
                        var distance = routePath["distance"];
                        var polyline = routePath["polyline"].toString().split(";");
                        var status = routePath["status"];
                        var polylineData = [];
                        for (var j = 0; j < polyline.length; j++) {
                            //将字符串拆成数组
                            var realData = polyline[j].split(",");
                            var coordinate = [realData[0], realData[1]];
                            polylineData.push(coordinate);
                            //要素属性
                        }
                        var attribute = {
                            distance: distance,
                        };
                        //线此处注意一定要是坐标数组
                        var plygon = new ol.geom.LineString(polylineData);
                        //线要素类
                        var feature = new ol.Feature({
                            geometry: plygon,
                            attr: attribute,
                            status: status
                        });
                        sourceVector.addFeature(feature);
                    }
                }
            }
        });
    }
    ;

    //保存小数点后六位
    function GetCoordate(coordate) {
        var lng = coordate[0].toString();
        var lat = coordate[1].toString();
        var lngIndex = lng.indexOf(".") + 7;
        var latIndex = lat.indexOf(".") + 7;
        lng = lng.substring(0, lngIndex);
        lat = lat.substring(0, latIndex);
        var str = lng + "," + lat;
        console.log(str.toString());
        return str;
    }

    //样式函数
    function createFeatureStyle(feature, name) {
        var url;
        if (name == null) {
            url = "images/start.png";
        } else {
            if (name == "起点") {
                url = "images/start.png";
            } else {
                url = "end.png";
            }
        }
        return new ol.style.Style({
            image: new ol.style.Icon( /** @type {olx.style.IconOptions} */ ({
                anchor: [0.5, 60],
                anchorOrigin: 'top-right',
                anchorXUnits: 'fraction',
                anchorYUnits: 'pixels',
                offsetOrigin: 'top-right',
                //offset : [ 0, 10 ], //偏移量设置
                scale: 0.4, //图标缩放比例
                opacity: 1, //透明度
                src: url, //图标的url

            })),
        });

    }

    function removeRoute() {
        sourceVector.clear();
        if (closeFeature.get("f4") == 2) {
            closeFeature.setStyle(superStyle);
        } else {
            closeFeature.setStyle(destinationStyle);
        }

    }
</script>

<script type="text/javascript">
    WIDGET = {
        FID: 'ew4MDmXnBq'
    }
</script>
<script type="text/javascript"
        src="https://apip.weatherdt.com/float/static/js/r.js?v=1111"></script>

<script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>


<script src="js/sb-admin.min.js"></script>

</body>
</html>