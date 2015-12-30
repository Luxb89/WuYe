<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css"
	href="<c:url value='/bootstrap/css/bootstrap.css'></c:url>" media="all" />
<link rel="stylesheet" type="text/css"
	href="<c:url value='/bootstrap/css/bootstrap-responsive.css'></c:url>"
	media="all" />
<link rel="stylesheet" type="text/css"
	href="<c:url value='/css/style.css'></c:url>" media="all">
<link rel="stylesheet" type="text/css"
	href="<c:url value='/bootstrap/css/todc_bootstrap.css'></c:url>"
	media="all">
<link rel="stylesheet" type="text/css"
	href="<c:url value='/css/themes.css'></c:url>" media="all">
<link rel="stylesheet" type="text/css"
	href="<c:url value='/css/tight-style.css'></c:url>" media="all">
<link rel="stylesheet" type="text/css"
	href="<c:url value='/css/font/css/font-awesome.css'></c:url>"
	media="all" />
<link rel="stylesheet" type="text/css"
	href="<c:url value='/css/inside.css'></c:url>" media="all">
<link rel="stylesheet" type="text/css"
	href="<c:url value='/css/defined-style.css'></c:url>" media="all">
<link rel="stylesheet" type="text/css"
	href="<c:url value='/css/public/jquery-ui.css'></c:url>" media="all">


<script type="text/javascript"
	src="<c:url value='/js/jquery-1.9.1.min.js'></c:url>"></script>
<script type="text/javascript"
	src="<c:url value='/bootstrap/js/bootstrap.min.js'></c:url>"></script>
<script type="text/javascript"
	src="<c:url value='/js/public/jquery-ui.js'></c:url>"></script>
<script type="text/javascript"
	src="<c:url value='/js/modal.js'></c:url>"></script>
<script type="text/javascript"
	src="<c:url value='/js/public/selectSearchCom.js'></c:url>"></script>
<script type="text/javascript"
	src="<c:url value='/js/costsetting/acctItemRelAdd.js'></c:url>"></script>
		<title>费用类型设置</title>
		<style type="text/css">
.defind-label{
	margin-left:15px;
	margin-right:0px;
	display: inline;
}
.defind-div{
 	display: inline-block;
}

.defined-select {
	width: 228px;
}
.box .box-content {*zoom:1;
	padding: 20px;
	/* background: #fff; */
}
</style>
	</head>
	<body>
		<div id="main">
			<div class="container-fluid">
				<div class="row-fluid">
					<div class="span12">
						<div class="box">
							<div class="box-title">
								<div class="span10">
									<h3>
										费用设置
									</h3>
								</div>
								<div class="span2">
									<a class="btn pull-right"
										href="Javascript:window.history.go(-1)">返回</a>
								</div>
							</div>
							<div class="row-fluid">
								<div class="span12">
									<div class="box-content pull-right">
										<div class="defind-div">
											<label class="defind-label"> 物业公司</label>
											<input type="text" id="pp_company" class="input-medium  search-query" placeholder="输入选择物业公司"> 
										</div>
										<div class="defind-div">
											<label class="defind-label">小区</label>
											<input type="text" id="community" class="input-medium search-query" placeholder="输入选择小区">
										</div>
										<div class="defind-div">
											<label class="defind-label">楼栋/单元</label>
											<input type="text" id="buillding" class="input-medium search-query" placeholder="输入选择楼栋/单元">
										</div>
										<div class="defind-div">	
											<input type="button" value="确定" id="search" class="btn" onclick="clickOk()">
										</div>
									</div>			
								</div>
							</div>
							<div class="row-fluid">
								<div class="span12" style="margin-left:50px;">
									<div>
										<h4> 基本信息</h4>
									</div>
									<div class="defind-div">
										<div class="box-content pull-left">
											<span>所属物业公司：</span><span id="desCompany"></span>
											<span>所属小区：</span><span id="desCommunity"></span>
											<span>所属楼栋：</span><span id="desBudding"></span>
										</div>
									</div>
								</div>
							</div>
							<div class="box-content">
								<form id="communityform" method="post"
									class="form-horizontal form-validate" novalidate>
									<div id="acctItemTypes" class="control-group" style="margin-bottom: 100px;">
										<div class="row-fluid accItemRelRow" id="acctItemType1">
											<div class="span12" style="margin-bottom: 10px;">
												<div class="defind-div span2">
													<label class="defind-label">费用大类</label>
													<select id="acctItemTypeUpName" style="width: 50%"></select> 
												</div>
												<div class="defind-div span2" >
													<label class="defind-label">费用细类</label>
													<select id="acctItemTypeName" style="width: 50%"></select> 
												</div>
												<div class="defind-div span3" >
													<label class="defind-label">收费标准</label>
													<input type="text" id="price" style="width: 50%">
												</div>
												<div class="defind-div span3">
													<label class="defind-label">计算方法</label>
													<select id="acctItemTypeName" style="width: 60%"></select>  
												</div>
												<div class="defind-div span2">
													<a class="btn" href="javascript:void(0)" onclick="addRow(this)">
														<i class="icon-plus"></i>新增
													</a>
													<a class="btn" href="javascript:void(0)" onclick="removeRow(this)">
														<i class="icon-minus"></i>删除
													</a>
												</div>
											</div>
										</div>
									</div>
									<div class="controls">
											<input id="submit_btn" type="button" class="btn btn-primary"
												value="提交">
										</div>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div id="fallr-overlay"></div>
	</body>
</html>