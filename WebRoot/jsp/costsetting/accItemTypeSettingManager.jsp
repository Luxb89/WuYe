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
<link rel="stylesheet" type="text/css" href="<c:url value='/bootstrap/css/bootstrap.css'></c:url>" media="all" />
<link rel="stylesheet" type="text/css" href="<c:url value='/bootstrap/css/bootstrap-responsive.css'></c:url>" media="all" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/style.css'></c:url>" media="all">
<link rel="stylesheet" type="text/css" href="<c:url value='/bootstrap/css/todc_bootstrap.css'></c:url>" media="all">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/themes.css'></c:url>" media="all">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/tight-style.css'></c:url>" media="all">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/font/css/font-awesome.css'></c:url>" media="all" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/inside.css'></c:url>" media="all">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/defined-style.css'></c:url>" media="all">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/public/jquery-ui.css'></c:url>" media="all">
<title>物业管理-物业类型设置</title>
<style type="text/css">
.defind-label{
	margin-left:10px;
	margin-right: 0px;
	display: inline;
}
.defind-div{
 	display: inline-block;
}
</style>
</head>
<body ng-app="acctItemRelMainApp" ng-controller="acctItemRelMainController">
<div id="main">
  <div class="container-fluid">
    <div class="row-fluid">
      <div class="span12">
        <div class="box">
          <div class="box-title">
            <div class="span4">
              <h3><i class="fa fa-key"></i>物业费用类型设置</h3>
            </div>
            <div class="span8">
              <form id="form1" name="form1">
                <div class="form-horizontal pull-right">
                	<label class="defind-label">请输入定位条件:</label>
                	<input type="text" id="temp_pp_company" class="input-medium  search-query" placeholder="输入选择物业公司"
											ng-model="propertyCompany.value"
											ng-change="resetCommpanyChild()"
											ui-event="{autocompletecreate:'changeClass(propertyCompanys)'}"
											ui-autocomplete="propertyCompanys">
					<input type="text" id="temp_community" class="input-medium search-query" placeholder="输入选择小区"
											ng-model="community.companyName"
											ng-change="resetBuildingChild()"
											ui-event="{autocompletecreate:'changeClass(communitys)'}"
											ui-autocomplete="communitys" >
					<input type="text" id="buillding" class="input-medium search-query" placeholder="输入选择楼栋/单元"
											ng-model="building.buildingName"
											ui-event="{autocompletecreate:'changeClass(buildings)'}"
											ui-autocomplete="buildings">                  
					<input type="button" class="btn" id="search" ng-click="queryAcctItemRels()" value="查询">
                </div>
              </form>
            </div>
          </div>
          <div class="box-content">
            <div class="row-fluid">
              <div class="span12 control-group">
                <div> <a class="btn" href="addAcctItemRelInfo.jsp"><i class="icon-plus"></i>新增费用类型</a> 
                 <a class="btn" ng-click="removeAcctItemRel()" ><i class="icon-remove"></i>删除费用类型</a> 
                <a class="btn" href="javascript:location.reload()"><i class="icon-refresh"></i>刷新</a> </div>
              </div>
            </div>
            <div class="row-fluid dataTables_wrapper">
              <table id="listTable" class="table table-bordered table-hover dataTable table-striped ajax-checkbox" 
              ajax-url="/Wemedical/Diagnosis" ajax-length="0">
                <thead>
                  <tr>
                  	<th class="with-checkbox"><input ng-model="selectAll"
												type="checkbox"></th>
					<th>费用大类</th>
                  	<th >费用细类</th>
                  	<th >收费标准</th>
                  	<th >收费方式</th>
                    <th class="span2">操作</th>
                  </tr>
                </thead>
                <tbody>
                	<tr ng-repeat="acctItemRel in acctItemRels">
                		<td >
                			<input type="checkbox" ng-checked="selectAll" ng-model="acctItemRel.selected"></td>
                		<td>{{acctItemRel.parentAcctItemTypeName}}</td>
                		<td>{{acctItemRel.acctItemTypeName}}</td>
                		<td>{{acctItemRel.price}}</td>
                		<td>{{acctItemRel.caculateMethodName}}</td>
                		<td><button ng-click="mod(acctItemRel)" class="btn defined-role-btn">修改</button></td>
                	</tr>
                </tbody>
              </table>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
<div class="modal fade hide" id="myModal" tabindex="-1" role="dialog"
	   aria-labelledby="myModalLabel" aria-hidden="true">
	   <div class="modal-dialog">
	      <div class="modal-content">
	         <div class="modal-header">
	            <form class="form-horizontal" name="myForm" novalidate>
	            	<div class="form-group">
	            		<label class="col-sm-2 control-label">费用大类：</label>
					  	<select class="col-sm-10" ng-model="acctItemRel.parentAcctTypeId" 
					  	disabled="true"
								               	ng-change="queryAcctItemType(acctItemRel.parentAcctTypeId)"
								               	ng-options="acctItemRel.acctItemTypeId as 
												acctItemRel.acctTypeName for acctItemRel in acctItemTypeUps" required></select>
						<span style="color:red" >*</span>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label">费用细类：</label>
					  	<select class="col-sm-10" disabled="true"
												ng-model="acctItemRel.acctItemTypeId"
												ng-options="acctItemRel.acctItemTypeId as
												acctItemRel.acctTypeName for acctItemRel in acctItemTypes{{acctItemRel.acciItemRelId}}"
												required></select> 
					  	<span style="color:red" >*</span>
					</div>
					<div class="form-group">
	            		<label class="col-sm-2 control-label">收费标准：</label>
	            		<input class="col-sm-10" style="width: 38.1%" type="number" step="any" id="price" min="0" ng-model="acctItemRel.price"  required>
						<span style="color:red" >*</span>
					</div>
					<div class="form-group">
	            		<label class="col-sm-2 control-label">计算方式：</label>
					  	<select class="col-sm-10" id="acctItemTypeName" 
													ng-model="acctItemRel.caculateMethod" 
													ng-options="acctItemRel.attrValue as
													acctItemRel.attrValueName for acctItemRel in caculateMethods"
													></select>  
						<span style="color:red" >*</span>
					</div>
				</form>
			</div>
	         <div class="modal-footer" >
	            <button class="btn btn-primary" ng-disabled="!myForm.$valid" ng-click="onSave()">
  					确定
	            </button>
	         </div>
	      </div>
	   </div>
	</div>
</body>
<script type="text/javascript" src="<c:url value='/js/jquery-1.9.1.min.js'></c:url>"></script>
<script type="text/javascript" src="<c:url value='/js/public/jquery-ui.js'></c:url>"></script>
<script type="text/javascript" src="<c:url value='/bootstrap/js/bootstrap.min.js'></c:url>"></script>
<script type="text/javascript" src="<c:url value='/angularJS/angular-ie8-1.4.7.min.js'></c:url>"></script>
<script type="text/javascript" src="<c:url value='/js/modal.js'></c:url>"></script>
<script type="text/javascript" src="<c:url value='/js/json2.js'></c:url>"></script>
<script type="text/javascript" src="<c:url value='/js/public/defined-checkbox.js'></c:url>"></script>
<script type="text/javascript" src="<c:url value='/js/jquery.myPagination.js'></c:url>"></script>
<script type="text/javascript" src="<c:url value='/component/message-dialog-comp/js/message-dialog.js'></c:url>"></script>
<script type="text/javascript" src="<c:url value='/js/common/common.js'></c:url>"></script>
<script type="text/javascript" src="<c:url value='/js/costsetting/costsetting-service.js'></c:url>"></script>
<script type="text/javascript" src="<c:url value='/jsp/mobile/property/property-service.js'></c:url>"></script>
<script type="text/javascript" src="<c:url value='/js/costsetting/acctitemrel-manager-controller.js'></c:url>"></script>
<script type="text/javascript" src="<c:url value='/js/costsetting/autocomplete.js'></c:url>"></script>
<script type="text/javascript" src="<c:url value='/js/costsetting/event.js'></c:url>"></script>
</html>