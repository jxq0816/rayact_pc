<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<title></title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
	<meta name="apple-mobile-web-app-capable" content="yes">
	<meta name="apple-mobile-web-app-status-bar-style" content="black">
	<script src="${ctxStatic}/jquery/jquery-1.8.3.min.js" type="text/javascript"></script>
	<link href="${ctxStatic}/jquery-mobile/list.css" type="text/css" rel="stylesheet" />
	<link href="${ctxStatic}/bootstrap/2.3.1/css_default/bootstrap.min.css" type="text/css" rel="stylesheet" />

</head>
<body style="width:100%;font-family: Microsoft Yahei">
<style>
	.row{
		margin-left: 0;
	}
	.round {
		width:60px; height:60px;
		-moz-border-radius: 30px;      /* Gecko browsers */
		-webkit-border-radius: 30px;   /* Webkit browsers */
		border-radius:30px;            /* W3C syntax */
	}
	.subject{
		font-size:25px;
		line-height:28px;
		width: 83%;
		margin:2px 2px;
		display: inline-block;
		word-wrap: break-word;
		font-weight:bold;
		float: right;
	}
	.postli{
		list-style-type:none;
		padding-bottom: 2px;
		padding-top: 2px;
		border-bottom: 1px solid #C8C8C8;
	}
	.after_img{
		display: inline-block;position: relative;bottom: -10px;line-height: 20px
	}
	.post_content{
		margin-left:60px;
		line-height: 150%;
		font-size: 15px
	}
	.ptp_name{
		color:#7a7a7a;
		margin-top:5px;
		font-size: 10px;
		display: inline-block
	}
	.ptp_content{
		font-size: 15px;
		display: inline-block;
		color:#1e1e1e;
	}
</style>
<div class="row main_content">
	<div class="row">
		<div style="margin:2px 0px;display: inline-block">
			<img class="round" src="${postMain.createBy.photo}" name="${postMain.createBy.id}" onclick="jumpToInfo(this)">
		</div>
		<div class="subject">${postMain.subject}</div>
		<div style="display: inline-block;line-height: 35px;border-bottom: 1px solid #c8c8c8;width: 100%">
			<span style="color: #f0860c;font-size: 15px">${postMain.createBy.name}</span>
			<span style="color:#8C8C8C;font-size: 15px">&nbsp;&nbsp;&nbsp;&nbsp;<fmt:formatDate value="${postMain.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></span>
		</div>
		<div style="line-height: 150%;font-size: 20px;color:#555555;margin-top: 15px;word-wrap:break-word;word-break:break-all;">${postMain.content}</div>
		<c:forEach items="${imgs}" var="url">
			<img src="${url}" width="100%" style="margin: 2px"/>
		</c:forEach>
	</div>
</div>
<div class="postSubject"><div style="border-left:5px solid #f0860c;border-right:2px solid #f0860c;display:inline-block;margin-right: 3px">&nbsp;</div>回帖(${count})</div>
<div id="wrapper" style="position: relative;top: 20px;background: #ffffff">
	<ul style="margin-left: 0">
		<c:forEach items="${ptm}" var="post" varStatus="status">
			<li class="row postli" name="${post.createBy.name}" id="${post.id}">
				<div class="row" style="display: block;">
					<div style="display: inline-block">
						<img src="${post.createBy.photo}" class="round" name="${post.createBy.id}" onclick="jumpToInfo(this)">
					</div>
					<div class="after_img">
						<span style="color: #f0860c;font-size: 15px">${post.createBy.name}</span>
						<br>
						<span style="color:#7a7a7a; font-size: 15px"> 第${status.index + 1}楼 &nbsp;&nbsp;&nbsp;&nbsp;<fmt:formatDate value="${post.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></span>
					</div>
					<img src="${ctxStatic}/images/btn-huifu-h@2x.png" height="25px" width="40px" style="float: right;display: inline-block;" onclick="postToForm(this);"/>
					<div class="post_content">${post.content}</div>
				</div>
				<div  name="${post.id}" class="ptp"  style="margin-left:60px;line-height:30px">

				</div>
			</li>
		</c:forEach>
	</ul>
</div>
<div style="width: 100%;height:35px;background: #ffffff;">
</div>
<div style="position: fixed;bottom: 0;width: 100%;z-index: 100;height:35px;background: #ffffff;font-size: 17px ">
	<form name="post">
	<input type="text" style="width: 80%" name="content"/>
	<input type="hidden" name="remarks"/>
	<input type="hidden" name="postId"/>
	<input type="hidden" name="ptpId"/>
	<input type="hidden" name="postMain.id" value="${postMain.id}"/>
		<div style="width: 15%;display: inline-block;border: 1px solid #cccccc;border-radius: 4px;text-align: center;margin-bottom: 13px;height: 26px;position: relative;bottom: 4px" onclick="postToMain();">发送</div>
	</form>

</div>

<script type="text/javascript">
	function ptpToForm(dom){
		var name = $(dom).attr("name");
		var postId = $(dom).closest("li").attr("id");
		var ptpId = $(dom).attr("id");
		$("input[name='content']").val("@"+name+":");
		$("input[name='postId']").val(postId);
		$("input[name='ptpId']").val(ptpId);
		$("input[name='content']").focus();
	}
	function postToForm(dom){
		var name = $(dom).closest("li").attr("name");
		var postId = $(dom).closest("li").attr("id");
		$("input[name='content']").val("@"+name+":");
		$("input[name='postId']").val(postId);
		$("input[name='content']").focus();
	}
	function postToMain(){
		$.post("${ctx}/cms/post/app/save;JSESSIONID=${sid}",$("form[name='post']").serialize(),function(data){
			alert(data.msg);
			location.reload();
		});
	}
	$(function(){
		$(".ptp").each(function(){
			var postId = $(this).attr("name");
			var $dom = $(this);
			$.get("${ctx}/cms/post/app/list?postId="+postId,function(data){
				var vo = eval(data);
				if (vo&&vo.length>0){
					for(var i = 0 ; i < vo.length ; i++){
						$dom.append("<div class='ptp_name' name='"+vo[i].pname+"' onclick='ptpToForm(this);' id='"+vo[i].id+"'>"+vo[i].pname+":<span class='ptp_content'>"+vo[i].content+"</span></div>");
					}
				}
			});
		});
	});
	var pageNo = 1;
	var count = 5;
	var postMainId = "${postMain.id}";
	$(window).scroll(function(){
		console.log($("body").height());
		console.log($(window).scrollTop());
		console.log(screen.height);
		var scrollTop = $(window).scrollTop();
		var scrollHeight =screen.height;
		var windowHeight = $("body").height();
		if(scrollTop + scrollHeight - 20 + 35 >= windowHeight){
			pageNo++;
			$.post("${ctx}/cms/post/app/list?postMain.id="+postMainId,{pageNo:pageNo,pageSize:5},function(data){
				var rtn = eval(data);
				var length = rtn.length;
				for(var i = 0;i<length;i++){
					count++;
					var tmp = rtn[i];
					var tmpInner = tmp.pop;
					var htmlInner = "";
					if(tmpInner){
						for(var j=0;j<tmpInner.length;j++){
							htmlInner+="<div class='ptp_name' name='"+tmpInner[j].createByName+"' onclick='ptpToForm(this);' id='"+tmpInner[j].id+"'>"+tmpInner[j].createByName+":<span class='ptp_content'>"+tmpInner[j].content+"</span></div>";
						}
					}
					var html="<li class='row postli' name='"+tmp.pname+"' id='"+tmp.id+"'>"+
							"<div class='row' style='display: block'>"+
							"<div style='display: inline-block'>"+
							"<img src='"+tmp.photo+"' class='round' name='"+tmp.pid+"' onclick='jumpToInfo(this)'>"+
							"</div>"+
							"<div class='after_img'>"+
							"<span style='color: #f0860c;font-size: 15px'>"+tmp.pname+"</span>"+
							"<br>"+
							"<span style='color:#7a7a7a; font-size: 15px'> 第"+count+"楼 &nbsp;&nbsp;&nbsp;&nbsp;"+tmp.time+"</span>"+
							"</div>"+
							"<img src='${ctxStatic}/images/btn-huifu-h@2x.png' height='25px' width='40px' style='float: right;display: inline-block;' onclick='postToForm(this);'/>"+
							"<div class='post_content'>"+tmp.content+"</div>"+
							"</div>"+
							"<div  name='"+tmp.id+"' class='ptp'  style='margin-left:60px;line-height:30px'>"+htmlInner+
							"</div>"+
							"</li>";
					$("#wrapper ul").append(html);
				}
			});

		}
	});
</script>
</body>
</html>