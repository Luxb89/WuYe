<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    	String path = request.getContextPath();
		String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="user-scalable=no, width=device-width, initial-scale=1.0" />
<link rel="stylesheet" type="text/css" href="<c:url value='/bootstrap/css/bootstrap.css'></c:url>" media="all" />
<link rel="stylesheet" type="text/css" href="<c:url value='/bootstrap/css/bootstrap-responsive.css'></c:url>" media="all" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/style.css'></c:url>" media="all">
<link rel="stylesheet" type="text/css" href="<c:url value='/bootstrap/css/todc_bootstrap.css'></c:url>" media="all">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/themes.css'></c:url>" media="all">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/font/css/font-awesome.css'></c:url>" media="all" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/inside.css'></c:url>" media="all">
<link rel="stylesheet" type="text/css" href="<c:url value='/component/message-dialog-comp/css/message-dialog.css'></c:url>" media="all">

<title>公告管理</title>
</head>
<body ng-app="noticeManagerApp" ng-controller="noticeManagerController">



<script type="text/javascript" src="<c:url value='/js/jquery-1.9.1.min.js'></c:url>"></script>
<script type="text/javascript" src="<c:url value='/bootstrap/js/bootstrap.min.js'></c:url>"></script>
<script type="text/javascript" src="<c:url value='/angularJS/angular-ie8-1.4.7.min.js'></c:url>"></script>
<script type="text/javascript" src="<c:url value='/js/modal.js'></c:url>"></script>
<script type="text/javascript" src="<c:url value='/js/json2.js'></c:url>"></script>
<script type="text/javascript" src="<c:url value='/js/public/defined-checkbox.js'></c:url>"></script>
<script type="text/javascript" src="<c:url value='/js/jquery.myPagination.js'></c:url>"></script>
<script type="text/javascript" src="<c:url value='/component/message-dialog-comp/js/message-dialog.js'></c:url>"></script>
<script type="text/javascript" src="<c:url value='/js/common/common.js'></c:url>"></script>
<script type="text/javascript" src="<c:url value='/jsp/notice/notice-service.js'></c:url>"></script>
<script type="text/javascript" src="<c:url value='/jsp/notice/notice-manager/notice-manager-controller.js'></c:url>"></script>
</body>
</html>