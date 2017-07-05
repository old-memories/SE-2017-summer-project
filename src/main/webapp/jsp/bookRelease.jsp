<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@include file="../header.jsp"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>Release Book</title>
	<link href="<%=path%>/css/fileinput.css" rel="stylesheet" type="text/css"/>
	<link href="<%=path%>/css/fileinput.min.css" rel="stylesheet" type="text/css"/>
	<style>
#wrapper {
    background-color: #5D4B33;
    margin-right:70%;
}
@media ( min-width :768px) {
	.sidebar {
		z-index: 1;
		position: absolute;
		width:100%;
		margin-top: 51px;
		background-color: #5D4B33;
	}
}
#bookinfo
{
    margin-top: 51px;
    margin-left:30%;
    margin-right:10%;
}
.form-control-noNewline {
    width:100px;
    display:inline;
}
.form-horizontal .form-group-auto {
  margin-right: 0px;
  margin-left: 0px;
}
#confirm
{
	text-align:right;
}
	</style>
</head>
<body>

	<div id="wrapper">
		<!-- Navigation -->
		<nav class="navbar navbar-default navbar-static-top" role="navigation"
			style="margin-bottom: 0">

		<div class="navbar-header">
			<a class="navbar-brand" href="#">图书发布</a>
		</div>
		<div class="navbar-default sidebar" role="navigation">
			<div class="sidebar-nav navbar-collapse">
				<ul class="nav" id="side-menu">
					<li><a href="#"><i class="fa fa-user fa-fw"></i>
							全部图书</a></li>
					<li><a href="#"><i class="fa fa-book fa-fw"></i>
							个人信息</a></li>
					<li><a href="#" class="active"><i
							class="fa fa-reorder fa-fw"></i>我的发布</a></li>
					<li><a href="#"><i
							class="fa fa-table fa-fw"></i> 我的借阅</a></li>
					<li><a href="#"><i class="fa fa-user fa-fw"></i>
							我的交换</a></li>
					<li><a href="#"><i class="fa fa-user fa-fw"></i>
							我的订单</a></li>
				</ul>
			</div>
			<!-- /.sidebar-collapse -->
		</div>
		<!-- /.navbar-static-side --> </nav>
	</div>
	
	<div id=bookinfo>
		<form id="form" action="<%=path%>/bookAction/uploadBook" method=post enctype="multipart/form-data" role=form class="form-horizontal">
			<div class="form-group form-group-auto">
				<label>图书封面</label><font color="#FF0000">*</font><input name=coverPicture type=file class=file>
			</div>
			<div class="form-group form-group-auto">
				<label>书名</label><font color="#FF0000">*</font><input name=bookName type=text class=form-control>
			</div>
			<div class="form-group form-group-auto">
				<label>作者</label><font color="#FF0000">*</font><input name=author type=text class=form-control>
			</div>
			<div class="form-group form-group-auto">
				<label>ISBN</label><font color="#FF0000">*</font><input name=isbn type=text class=form-control>
			</div>
			<div class="form-group form-group-auto">
				<label>出版社</label><font color="#FF0000">*</font><input name=press type=text class=form-control>
			</div>
			<div class="form-group form-group-auto">
				<label>出版时间</label><font color="#FF0000">*</font>&nbsp;
            		<input name=publishYear type=text class="form-control form-control-noNewline">&nbsp;<label>年</label>&nbsp;
            		<input name=publishMonth type=text class="form-control form-control-noNewline">&nbsp;<label>月</label>
            </div>
            <div class="form-group form-group-auto">
			    <label>版次</label><font color="#FF0000">*</font>&nbsp;
            	<input name=editionYear type=text class="form-control form-control-noNewline">&nbsp;<label>年</label>&nbsp;
            	<input name=editionMonth type=text class="form-control form-control-noNewline">&nbsp;<label>月</label>&nbsp;
            	<label>第</label>&nbsp;<input name=editionVersion type=text class="form-control form-control-noNewline">&nbsp;<label>版</label>
            </div>
            <div class="form-group form-group-auto">
			    <label>类别</label><font color="#FF0000">*</font>&nbsp;
				<select id=cate name=category1 class="form-control form-control-noNewline">
					<option value=0>小说</option>
            		<option value=1>文学</option>
            		<option value=2>管理</option>
            		<option value=4>其他</option>
        		</select>&nbsp;
        		<select id=category name=category2 class="form-control form-control-noNewline">
        			<option value="00">言情</option>
            		<option value="01">玄幻</option>
            		<option value="02">武侠</option>
            		<option value="03">其他</option>
        		</select>
        	</div>
        	<div class="form-group form-group-auto">	
            	<label>页数</label><font color="#FF0000">*</font>&nbsp;
            		<input name=page type=number step=1 min=0 class="form-control form-control-noNewline">&nbsp;&nbsp;&nbsp;
            	<label>装帧</label><font color="#FF0000">*</font>&nbsp;
            		<select name=bookBinding class="form-control form-control-noNewline">
						<option value="0">线装</option>
            			<option value="1">平装</option>
            			<option value="2">精装</option>
        			</select>&nbsp;&nbsp;&nbsp;
        		<label>开本</label><font color="#FF0000">*</font>&nbsp;
            		<select name=bookFormat class="form-control form-control-noNewline">
						<option value="0">正度</option>
            			<option value="1">对开</option>
            			<option value="2">4开</option>
            			<option value="3">8开</option>
            			<option value="4">16开</option>
            			<option value="5">32开</option>
        			</select>&nbsp;&nbsp;&nbsp;
        		<label>成色</label><font color="#FF0000">*</font>&nbsp;
            		<select name=bookQuality class="form-control form-control-noNewline">
						<option value="10">全新</option>
            			<option value="9">9成新</option>
            			<option value="7">7成新</option>
            			<option value="5">5成新</option>
            			<option value="3">3成新</option>
            			<option value="1">1成新</option>
        			</select>
        	</div>
        	<div class="form-group form-group-auto">
        		<label>购买所需积分</label><font color="#FF0000">*</font>&nbsp;
        			<input name=buyCredit type=number step=1 min=0 name=buyCredit class="form-control form-control-noNewline">&nbsp;&nbsp;&nbsp;
        		<label>是否可交换</label><font color="#FF0000">*</font>&nbsp;
        		<input type=radio name=canExchange value=1><label>是</label>&nbsp;
        		<input type=radio name=canExchange value=0><label>否</label>
        	</div>
        	<div class="form-group form-group-auto">
        		<label>是否可借阅</label><font color="#FF0000">*</font>&nbsp;
        			<input id=cb1 type=radio name=canBorrow value=1><label>是</label>&nbsp;
        			<input id=cb0 type=radio name=canBorrow value=0><label>否</label>&nbsp;&nbsp;&nbsp;
        		<div id=borrowCredit style='display:none;'>
        			<label>借阅所需积分</label><font color="#FF0000">*</font>&nbsp;
        			<input type=number step=1 min=0 name=borrowCredit class="form-control form-control-noNewline">
        		</div>
        	</div>
        	<div class="form-group form-group-auto">
        		<label>简介</label><font color="#FF0000">*</font><textarea id=introduction name=intro class="form-control" rows="3"></textarea>
        	</div>
        </form>
        <div class="form-group form-group-auto">
        	<label id=warning></label>
        </div>
        <div id=confirm>
        	<button id=commit class="btn btn-primary">确认发布</button>
        </div>
    </div>
	
	<script src="<%=path%>/js/fileinput.js"></script>
	<script src="<%=path%>/js/fileinput.min.js"></script>
	<script>
	function showTip(tip,type){
        var $tip = $('#tip');
        $tip.attr('class', 'alert alert-' + type).text(tip).css('margin-left', - $tip.outerWidth() / 2).fadeIn(500).delay(1000).fadeOut(500);
    }
	$("#cate").change(function(){
		$("#category").empty();
		switch ($("#cate").val())
		{
			case '0':$("#category").append($("<option>").val(00).text("言情"));
				     $("#category").append($("<option>").val(01).text("玄幻"));
			         $("#category").append($("<option>").val(00).text("武侠"));
			         $("#category").append($("<option>").val(00).text("其他"));
			         break;
			case '1':$("#category").append($("<option>").val(10).text("影视文学"));
			         $("#category").append($("<option>").val(11).text("散文随笔"));
			         $("#category").append($("<option>").val(12).text("其他"));
			         break;
			case '2':$("#category").append($("<option>").val(20).text("管理学"));
		             $("#category").append($("<option>").val(21).text("财务管理"));
		             $("#category").append($("<option>").val(22).text("其他"));
		             break;
		    default:$("#category").append($("<option>").val(40).text("其他"));
		}
	});
	$("#cb1").click(function(){
		$("#borrowCredit").show();
	});
	$("#cb0").click(function(){
		$("#borrowCredit").hide();
	});
	$("#ce1").click(function(){
		$("#exchangeCredit").show();
	});
	$("#ce2").click(function(){
		$("#exchangeCredit").hide();
	});
	$("#commit").click(function(){
		var obj=document.getElementById("warning");
		if($("input[name='coverPicture']").val()=="")
			{obj.innerText="图书封面必须上传";return;}
		if($("input[name='bookName']").val()=="")
			{obj.innerText="图书名称必须填写";return;}
		if($("input[name='author']").val()=="")
			{obj.innerText="图书作者必须填写";return;}
		if($("input[name='isbn']").val()=="")
			{obj.innerText="图书ISBN必须填写";return;}
		if($("input[name='press']").val()=="")
			{obj.innerText="图书出版社必须填写";return;}
		if($("input[name='publishYear']").val()=="")
			{obj.innerText="图书出版年份必须填写";return;}
		if($("input[name='publishMonth']").val()=="")
			{obj.innerText="图书出版月份必须填写";return;}
		if($("input[name='editionMonth']").val()==""||$("input[name='editionYear']").val()==""
				||$("input[name='editionVersion']").val()=="")
			{obj.innerText="图书版次信息不全";return;}
		if($("input[name='page']").val()=="")
			{obj.innerText="图书页数必须填写";return;}
		if($("input[name='buyCredit']").val()=="")
			{obj.innerText="图书页数必须填写";return;}
		if($("input[name='canBorrow']").val()=="")
			{obj.innerText="请确认是否可借阅";return;}
		if($("input[name='canBorrow']").val()=='1'&&$("input[name='borrowCredit']").val()=='')
			{obj.innerText="请输入借阅所需积分";return;}
		if($("input[name='canExchange']").val()=='')
			{obj.innerText="请确认是否可交换";return;}
		if($("#introduction").val()=='')
			{obj.innerText="请输入简介";return;}
		obj.innerText="提交中...";
		$("#form").submit();
	});
	</script>
</body>
</html>