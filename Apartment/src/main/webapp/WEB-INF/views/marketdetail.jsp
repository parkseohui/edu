<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<sec:authentication var='principal' property='principal'/>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">
<style type="text/css">
.market-list {
	width: 180px;
	min-height: 200px;
}

img {
	width: 180px;
	height: 180px;
}

#ptext {
	font-size: 10px;
}
</style>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript" src="/resources/js/reply.js"></script>
<script type="text/javascript">
	/* console.log("----");
	 console.log("js test");
	 var seqValue='<c:out value="${product.seq}"/>';

	 var replyUL=$(".chat");

	 showList(1);

	 replyserive.get(10,function(data){
	 console.log(data);
	 });

	 function showList(page){
	 replyservice.getList({seq:seqValue,page||1},function(list){
	 var str="";
	 if(list==null||list.length==0){
	 replyUL.html("");
	 return;
	 }
	 for(var i=0,len=list.length||0;i<len;i++){
	 str+="<li class='left clearfix' data-replyNo'"+list[i].replyNo+"'>";
	 str+="<div><div class='header'><strong class='primary-font'>"+list[i].replyWriter+"</strong>";
	 str+="<small class='pull-right text-muted'>"+list[i].reply 
	 str+="<p>"+list[i].replyContents+"</p></div></li>";
	 }
	 replyUL.html(str);
	 });
	 } */

	/* replyservice.getList({seq:seqValue,page:1 }, function(list) {

	 console.log("실행")
	 for (var i = 0, len = list.length || 0; i < len; i++) {
	 console.log(list[i]);
	 }
	 });
	 replyservice.add(
	 {replyContents:"js test", replyWriter:"tester",seq:seqValue}
	 ,function(result){
	 alert("result:"+result);
	 }
	 ); 
	 replyservice.remove(37,function(count){
	 console.log(count);
	 if(count==="success"){
	 alert("remove");
	 }
	 },function(err){
	 alert("error");
	 }); 
	 replyservice.update({
	 replyNo:38,
	 seq:seqValue,
	 replyContents:"modified reply"
	 },function(result){alert("수정완료");
	 });
	 replyservice.get(412,function(data){
	 console.log(data);
	 });*/

	/* 

	 replyservice add(
	 {replyContents:"js test", replyWriter:"tester",seq:seqValue}
	 ,function(result){
	 alert("result:"+result);
	 }
	 ); 
	 replyservice.get({seq:seqValue,page:1},function(list){
	 for(var i=0,len=list.length||0;i<len;i++){
	 console.log(list[i]);
	 }
	 });

	 */
</script>
<script type="text/javascript">
	$(document)
			.ready(
					function() {
						var seqValue = '<c:out value="${product.seq}"/>';

						var replyUL = $(".chat");

						showList(1);

						replyservice.get(10, function(data) {

						});

						function showList(page) {
							replyservice
									.getList(
											{
												seq : seqValue,
												page : page || 1
											},
											function(list) {
												var str = "";
												if (list == null
														|| list.length == 0) {
													replyUL.html("");
													return;
												}
												for (var i = 0, len = list.length || 0; i < len; i++) {
													str += "<li class='left clearfix' data-replyNo='"+list[i].replyNo+"'>";
													str += "<div><div class='header'><strong class='primary-font'>"
															+ list[i].replyWriter
															+ "</strong>";
													str += "<small class='pull-right text-muted'>"
															+ replyservice
																	.displayTime(list[i].replyRegdate)
															+ "</small></div>";
													str += "<p>"
															+ list[i].replyContents
															+ "</p></div></li>";
												}
												replyUL.html(str);
											});
						}

						var modal = $(".modal");
						var modalInputReply = modal
								.find("input[name='replyContents']");
						var modalInputReplyer =/* $("#principalId").val(); */
							 modal
								.find("input[name='replyWriter']"); 
						var modalInputReplyDate = modal
								.find("input[name='replyRegdate']");

						var modalModBtn = $("#modalModBtn");
						var modalRemoveBtn = $("#modalRemoveBtn");
						var modalRegisterBtn = $("#modalRegisterBtn");

						$("#modalCloseBtn").on("click", function(e) {

							modal.modal('hide');
						});

						$("#addReplyBtn").on("click", function(e) {

							modal.find("input").val("");
							modalInputReplyDate.closest("div").hide();
							modal.find("button[id !='modalCloseBtn']").hide();

							modalRegisterBtn.show();

							$(".replymodal").modal("show");

						});
						modalRegisterBtn.on("click", function(e) {
							console.log("123");
							var reply = {
								replyContents : modalInputReply.val(),
								replyWriter : modalInputReplyer.val(),
								seq : seqValue
							};
							replyservice.add(reply, function(result) {

								alert(result);

								modal.find("input").val("");
								modal.modal("hide");

								showList(1);
							});

						});

						$(".chat")
								.on(
										"click",
										"li",
										function(e) {

											console.log(this);
											var replyNo = $(this).data(
													"replyno");
											console.log(replyNo);
											replyservice
													.get(
															replyNo,
															function(reply) {
																modalInputReply
																		.val(reply.replyContents);
																modalInputReplyer
																		.val(reply.replyWriter);
																modalInputReplyDate
																		.val(
																				replyservice
																						.displayTime(reply.replyRegdate))
																		.attr(
																				"readonly",
																				"readonly");
																modal
																		.data(
																				"replyNo",
																				reply.replyNo);

																modal
																		.find(
																				"button[id !='modalCloseBtn']")
																		.hide();
																modalModBtn
																		.show();
																modalRemoveBtn
																		.show();

																$(".replymodal")
																		.modal(
																				"show");

															});
										});

						modalModBtn.on("click", function(e) {

							var reply = {
								replyNo : modal.data("replyNo"),
								replyContents : modalInputReply.val()
							};

							replyservice.update(reply, function(result) {

								alert(result);
								modal.modal("hide");
								showList(1);

							});

						});
						modalRemoveBtn.on("click", function(e) {

							var replyNo = modal.data("replyNo");

							replyservice.remove(replyNo, function(result) {

								alert(result);
								modal.modal("hide");
								showList(1);

							});

						});
					});
</script>
<title>SB Admin 2 - Dashboard</title>

<!-- Custom fonts for this template-->
<link href="/resources/vendor/fontawesome-free/css/all.min.css"
	rel="stylesheet" type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">

<!-- Custom styles for this template-->

<link href="/resources/css/sb-admin-2.min.css" rel="stylesheet">
</head>

<body id="page-top">

	<!-- Page Wrapper -->
	<div id="wrapper">

		<!-- Sidebar -->
		<ul
			class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion"
			id="accordionSidebar">

			<!-- Sidebar - Brand -->
			<a
				class="sidebar-brand d-flex align-items-center justify-content-center"
				href="index.html">
				<div class="sidebar-brand-icon rotate-n-15">
					<i class="fas fa-laugh-wink"></i>
				</div>
				<div class="sidebar-brand-text mx-3">
					SB Admin <sup>2</sup>
				</div>
			</a>

			<!-- Divider -->
			<hr class="sidebar-divider my-0">

			<!-- Nav Item - Dashboard -->
			<li class="nav-item active"><a class="nav-link"
				href="index.html"> <i class="fas fa-fw fa-tachometer-alt"></i> <span>Dashboard</span></a>
			</li>

			<!-- Divider -->
			<hr class="sidebar-divider">

			<!-- Heading -->
			<div class="sidebar-heading">Interface</div>

			<!-- Nav Item - Pages Collapse Menu -->
			<li class="nav-item"><a class="nav-link collapsed" href="#"
				data-toggle="collapse" data-target="#collapseTwo"
				aria-expanded="true" aria-controls="collapseTwo"> <i
					class="fas fa-fw fa-cog"></i> <span>Components</span>
			</a>
				<div id="collapseTwo" class="collapse" aria-labelledby="headingTwo"
					data-parent="#accordionSidebar">
					<div class="bg-white py-2 collapse-inner rounded">
						<h6 class="collapse-header">Custom Components:</h6>
						<a class="collapse-item" href="buttons.html">Buttons</a> <a
							class="collapse-item" href="cards.html">Cards</a>
					</div>
				</div></li>

			<!-- Nav Item - Utilities Collapse Menu -->
			<li class="nav-item"><a class="nav-link collapsed" href="#"
				data-toggle="collapse" data-target="#collapseUtilities"
				aria-expanded="true" aria-controls="collapseUtilities"> <i
					class="fas fa-fw fa-wrench"></i> <span>Utilities</span>
			</a>
				<div id="collapseUtilities" class="collapse"
					aria-labelledby="headingUtilities" data-parent="#accordionSidebar">
					<div class="bg-white py-2 collapse-inner rounded">
						<h6 class="collapse-header">Custom Utilities:</h6>
						<a class="collapse-item" href="utilities-color.html">Colors</a> <a
							class="collapse-item" href="utilities-border.html">Borders</a> <a
							class="collapse-item" href="utilities-animation.html">Animations</a>
						<a class="collapse-item" href="utilities-other.html">Other</a>
					</div>
				</div></li>

			<!-- Divider -->
			<hr class="sidebar-divider">

			<!-- Heading -->
			<div class="sidebar-heading">Addons</div>

			<!-- Nav Item - Pages Collapse Menu -->
			<li class="nav-item"><a class="nav-link collapsed" href="#"
				data-toggle="collapse" data-target="#collapsePages"
				aria-expanded="true" aria-controls="collapsePages"> <i
					class="fas fa-fw fa-folder"></i> <span>Pages</span>
			</a>
				<div id="collapsePages" class="collapse"
					aria-labelledby="headingPages" data-parent="#accordionSidebar">
					<div class="bg-white py-2 collapse-inner rounded">
						<h6 class="collapse-header">Login Screens:</h6>
						<a class="collapse-item" href="login.html">Login</a> <a
							class="collapse-item" href="register.html">Register</a> <a
							class="collapse-item" href="forgot-password.html">Forgot
							Password</a>
						<div class="collapse-divider"></div>
						<h6 class="collapse-header">Other Pages:</h6>
						<a class="collapse-item" href="404.html">404 Page</a> <a
							class="collapse-item" href="blank.html">Blank Page</a>
					</div>
				</div></li>

			<!-- Nav Item - Charts -->
			<li class="nav-item"><a class="nav-link" href="charts.html">
					<i class="fas fa-fw fa-chart-area"></i> <span>Charts</span>
			</a></li>

			<!-- Nav Item - Tables -->
			<li class="nav-item"><a class="nav-link" href="tables.html">
					<i class="fas fa-fw fa-table"></i> <span>Tables</span>
			</a></li>

			<!-- Divider -->
			<hr class="sidebar-divider d-none d-md-block">

			<!-- Sidebar Toggler (Sidebar) -->
			<div class="text-center d-none d-md-inline">
				<button class="rounded-circle border-0" id="sidebarToggle"></button>
			</div>

		</ul>
		<!-- End of Sidebar -->

		<!-- Content Wrapper -->
		<div id="content-wrapper" class="d-flex flex-column">

			<!-- Main Content -->
			<div id="content">

				<!-- Topbar -->
				<nav
					class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">

					<!-- Sidebar Toggle (Topbar) -->
					<button id="sidebarToggleTop"
						class="btn btn-link d-md-none rounded-circle mr-3">
						<i class="fa fa-bars"></i>
					</button>

					<!-- Topbar Search -->
					<form
						class="d-none d-sm-inline-block form-inline mr-auto ml-md-3 my-2 my-md-0 mw-100 navbar-search">
						<div class="input-group">
							<input type="text" class="form-control bg-light border-0 small"
								placeholder="Search for..." aria-label="Search"
								aria-describedby="basic-addon2">
							<div class="input-group-append">
								<button class="btn btn-primary" type="button">
									<i class="fas fa-search fa-sm"></i>
								</button>
							</div>
						</div>
					</form>

					<!-- Topbar Navbar -->
					<ul class="navbar-nav ml-auto">

						<!-- Nav Item - Search Dropdown (Visible Only XS) -->
						<li class="nav-item dropdown no-arrow d-sm-none"><a
							class="nav-link dropdown-toggle" href="#" id="searchDropdown"
							role="button" data-toggle="dropdown" aria-haspopup="true"
							aria-expanded="false"> <i class="fas fa-search fa-fw"></i>
						</a> <!-- Dropdown - Messages -->
							<div
								class="dropdown-menu dropdown-menu-right p-3 shadow animated--grow-in"
								aria-labelledby="searchDropdown">
								<form class="form-inline mr-auto w-100 navbar-search">
									<div class="input-group">
										<input type="text"
											class="form-control bg-light border-0 small"
											placeholder="Search for..." aria-label="Search"
											aria-describedby="basic-addon2">
										<div class="input-group-append">
											<button class="btn btn-primary" type="button">
												<i class="fas fa-search fa-sm"></i>
											</button>
										</div>
									</div>
								</form>
							</div></li>

						<!-- Nav Item - Alerts -->
						<li class="nav-item dropdown no-arrow mx-1"><a
							class="nav-link dropdown-toggle" href="#" id="alertsDropdown"
							role="button" data-toggle="dropdown" aria-haspopup="true"
							aria-expanded="false"> <i class="fas fa-bell fa-fw"></i> <!-- Counter - Alerts -->
								<span class="badge badge-danger badge-counter">3+</span>
						</a> <!-- Dropdown - Alerts -->
							<div
								class="dropdown-list dropdown-menu dropdown-menu-right shadow animated--grow-in"
								aria-labelledby="alertsDropdown">
								<h6 class="dropdown-header">Alerts Center</h6>
								<a class="dropdown-item d-flex align-items-center" href="#">
									<div class="mr-3">
										<div class="icon-circle bg-primary">
											<i class="fas fa-file-alt text-white"></i>
										</div>
									</div>
									<div>
										<div class="small text-gray-500">December 12, 2019</div>
										<span class="font-weight-bold">A new monthly report is
											ready to download!</span>
									</div>
								</a> <a class="dropdown-item d-flex align-items-center" href="#">
									<div class="mr-3">
										<div class="icon-circle bg-success">
											<i class="fas fa-donate text-white"></i>
										</div>
									</div>
									<div>
										<div class="small text-gray-500">December 7, 2019</div>
										$290.29 has been deposited into your account!
									</div>
								</a> <a class="dropdown-item d-flex align-items-center" href="#">
									<div class="mr-3">
										<div class="icon-circle bg-warning">
											<i class="fas fa-exclamation-triangle text-white"></i>
										</div>
									</div>
									<div>
										<div class="small text-gray-500">December 2, 2019</div>
										Spending Alert: We've noticed unusually high spending for your
										account.
									</div>
								</a> <a class="dropdown-item text-center small text-gray-500"
									href="#">Show All Alerts</a>
							</div></li>

						<!-- Nav Item - Messages -->
						<li class="nav-item dropdown no-arrow mx-1"><a
							class="nav-link dropdown-toggle" href="#" id="messagesDropdown"
							role="button" data-toggle="dropdown" aria-haspopup="true"
							aria-expanded="false"> <i class="fas fa-envelope fa-fw"></i>
								<!-- Counter - Messages --> <span
								class="badge badge-danger badge-counter">7</span>
						</a> <!-- Dropdown - Messages -->
							<div
								class="dropdown-list dropdown-menu dropdown-menu-right shadow animated--grow-in"
								aria-labelledby="messagesDropdown">
								<h6 class="dropdown-header">Message Center</h6>
								<a class="dropdown-item d-flex align-items-center" href="#">
									<div class="dropdown-list-image mr-3">
										<img class="rounded-circle"
											src="https://source.unsplash.com/fn_BT9fwg_E/60x60" alt="">
										<div class="status-indicator bg-success"></div>
									</div>
									<div class="font-weight-bold">
										<div class="text-truncate">Hi there! I am wondering if
											you can help me with a problem I've been having.</div>
										<div class="small text-gray-500">Emily Fowler · 58m</div>
									</div>
								</a> <a class="dropdown-item d-flex align-items-center" href="#">
									<div class="dropdown-list-image mr-3">
										<img class="rounded-circle"
											src="https://source.unsplash.com/AU4VPcFN4LE/60x60" alt="">
										<div class="status-indicator"></div>
									</div>
									<div>
										<div class="text-truncate">I have the photos that you
											ordered last month, how would you like them sent to you?</div>
										<div class="small text-gray-500">Jae Chun · 1d</div>
									</div>
								</a> <a class="dropdown-item d-flex align-items-center" href="#">
									<div class="dropdown-list-image mr-3">
										<img class="rounded-circle"
											src="https://source.unsplash.com/CS2uCrpNzJY/60x60" alt="">
										<div class="status-indicator bg-warning"></div>
									</div>
									<div>
										<div class="text-truncate">Last month's report looks
											great, I am very happy with the progress so far, keep up the
											good work!</div>
										<div class="small text-gray-500">Morgan Alvarez · 2d</div>
									</div>
								</a> <a class="dropdown-item d-flex align-items-center" href="#">
									<div class="dropdown-list-image mr-3">
										<img class="rounded-circle"
											src="https://source.unsplash.com/Mv9hjnEUHR4/60x60" alt="">
										<div class="status-indicator bg-success"></div>
									</div>
									<div>
										<div class="text-truncate">Am I a good boy? The reason I
											ask is because someone told me that people say this to all
											dogs, even if they aren't good...</div>
										<div class="small text-gray-500">Chicken the Dog · 2w</div>
									</div>
								</a> <a class="dropdown-item text-center small text-gray-500"
									href="#">Read More Messages</a>
							</div></li>

						<div class="topbar-divider d-none d-sm-block"></div>

						<!-- Nav Item - User Information -->
						<li class="nav-item dropdown no-arrow"><a
							class="nav-link dropdown-toggle" href="#" id="userDropdown"
							role="button" data-toggle="dropdown" aria-haspopup="true"
							aria-expanded="false"> <span
								class="mr-2 d-none d-lg-inline text-gray-600 small">Valerie
									Luna</span> <img class="img-profile rounded-circle"
								src="https://source.unsplash.com/QAB-WJcbgJk/60x60">
						</a> <!-- Dropdown - User Information -->
							<div
								class="dropdown-menu dropdown-menu-right shadow animated--grow-in"
								aria-labelledby="userDropdown">
								<a class="dropdown-item" href="#"> <i
									class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i> Profile
								</a> <a class="dropdown-item" href="#"> <i
									class="fas fa-cogs fa-sm fa-fw mr-2 text-gray-400"></i>
									Settings
								</a> <a class="dropdown-item" href="#"> <i
									class="fas fa-list fa-sm fa-fw mr-2 text-gray-400"></i>
									Activity Log
								</a>
								<div class="dropdown-divider"></div>
								<a class="dropdown-item" href="#" data-toggle="modal"
									data-target="#logoutModal"> <i
									class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
									Logout
								</a>
							</div></li>

					</ul>

				</nav>
				<!-- End of Topbar -->

				<!-- Begin Page Content -->
				<div class="container-fluid">
					<!-- Content Row -->
					<div class="row"></div>
					<div class="row">
						<h1 class="mt-4">중고거래  </h1>
						<input id="principalId" value="${principal.id}" hidden>

					</div>

					<!--  -->
					<hr>
					<div class="card mb-4">
						<div class="card-body">
							<div class="card-body">
								<div class="product">물품명: ${ product.productName }</div>
								<div class="writer">작성자: ${ product.writer }</div>
								<div>
									<!-- •2020-04-06 14:11:45 -->
									<fmt:parseDate var="date" value="${product.regdate }"
										pattern="yyyy-MM-dd HH:mm:ss" />
									<fmt:formatDate value="${ date}" pattern="yyyy.MM.dd. HH:mm:ss" />
								</div>

								<!-- <div class="card-body"> -->
								<%-- <a href="/Aptogether/download.jsp?filename=${product.fname}">${product.fname}</a> --%>
							<%-- 	<img src="<spring:url value='/resources/img/apt.jpg'/>"> --%>
								<img src="<spring:url value='/tenant/download?fileName=${product.fname}'/>">
								<%-- <c:if test="${product.fname != null }">
									<c:set var="head"
										value="${fn:substring(product.fname, 
												0, fn:length(product.fname)-4) }"></c:set>
									<c:set var="pattern"
										value="${fn:substring(product.fname, 
						fn:length(head) +1, fn:length(product.fname)) }"></c:set>
									<c:choose>
										<c:when
											test="${pattern == 'jpg' || pattern == 'gif'||pattern == 'png' }">
											<div class="hello">
												<img src="/Aptogether/upload/${head}.${pattern}">
											</div>
										</c:when>
										<c:otherwise>
											<c:out value="NO IMAGE"></c:out>
										</c:otherwise>
									</c:choose>
								</c:if> --%>


								<div>${ product.contents }</div>
							</div>


							<br>
							<%-- 	<%
							Member member = (Member) session.getAttribute("member");
							String name = member.getName();
						%> --%>
							<!-- r_writer -->
							<%-- <form action="insertReplyAction.do" method="post">
							<input type="hidden" name="seq" value="${product.seq}"> 
							<input
								type="hidden" name="r_writer" value="<%=name%>"><br>
							댓글쓰기:<%=name%><br>
							<input type="text" name="r_contents"><input
								type="submit" value="등록">

						</form> --%>
							<sec:authentication property="principal" var="principal" />
							<sec:authorize access="isAuthenticated()">
								<c:if test="${principal.username eq product.writer}">
			
									<a href="modify?seq=${ product.seq }">수정</a>
									<a href="remove?seq=${ product.seq }">삭제</a>
								</c:if>
							</sec:authorize>
						</div>

					</div>
					<div class="card mb-4">
						<div class="card-body">
							<div class="card-body">
								<div>

									<!-- 모달창의 시작 -->
									<!-- Modal -->
									<div class="modal fade replymodal" id="mymodal" tabindex="-1"
										role="dialog" aria-labelledby="myModalLabel"
										aria-hidden="true">
										<div class="modal-dialog">
											<div class="modal-content">
												<div class="modal-header">
													<button type="button" class="close" data-dismiss="modal"
														aria-hidden="true">&times;</button>
													<h4 class="modal-title" id="myModalLabel">REPLY MODAL</h4>
												</div>
												<div class="modal-body">
													<div class="form-group">
														<label>내용</label> <input class="form-control"
															name='replyContents' value='New Reply!!!!'>
													</div>
													<div class="form-group">
														<label></label> <input type="hidden" class="form-control"
															name='replyWriter' Value="<sec:authentication property='principal.username'/>">
													</div>
													<div class="form-group">
														<label>작성날짜</label> <input class="form-control"
															name='replyRegdate' value='2018-01-01 13:13'>
													</div>

												</div>
												<div class="modal-footer">
													<button id='modalModBtn' type="button"
														class="btn btn-warning">Modify</button>
													<button id='modalRemoveBtn' type="button"
														class="btn btn-danger">Remove</button>
													<button id='modalRegisterBtn' type="button"
														class="btn btn-primary">Register</button>
													<button id='modalCloseBtn' type="button"
														class="btn btn-default">Close</button>
												</div>
											</div>
											<!-- /.modal-content -->
										</div>
										<!-- /.modal-dialog -->
									</div>
									<!-- /.modal -->



									<h5>
										<p>댓글목록</p>
									</h5>

									<div class='row'>

										<div class="col-lg-12">

											<!-- /.panel -->
											<div class="panel panel-default">
												<!--       <div class="panel-heading">
        <i class="fa fa-comments fa-fw"></i> Reply
      </div> -->

												<div class="panel-heading">
													<i class="fa fa-comments fa-fw"></i> Reply
													<button id='addReplyBtn'
														class='btn btn-primary btn-xs pull-right'>New
														Reply</button>
												</div>


												<!-- /.panel-heading -->
												<div class="panel-body">

													<ul class="chat">
														<li class="left clearfix" data-replyNo='12'>
															<div>
																<div class="header">
																	<strong class="primary-font">user00</strong> <small
																		class="pull-right text-muted">2018-01-01 13:13</small>
																</div>
																<p>good job</p>
															</div>
														</li>
													</ul>
													<!-- ./ end ul -->
												</div>
												<!-- /.panel .chat-panel -->

												<div class="panel-footer"></div>


											</div>
										</div>
										<!-- ./ end row -->
									</div>

								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- Footer -->
			<footer class="sticky-footer bg-white">
				<div class="container my-auto">
					<div class="copyright text-center my-auto">
						<span>Copyright &copy; Your Website 2019</span>
					</div>
				</div>
			</footer>
			<!-- End of Footer -->

		</div>
	</div>
	<!-- End of Content Wrapper -->

	</div>
	<!-- End of Page Wrapper -->

	<!-- Scroll to Top Button-->
	<a class="scroll-to-top rounded" href="#page-top"> <i
		class="fas fa-angle-up"></i>
	</a>

	<!-- Logout Modal-->
	<div class="modal fade" id="logoutModal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">Ready to Leave?</h5>
					<button class="close" type="button" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">×</span>
					</button>
				</div>
				<div class="modal-body">Select "Logout" below if you are ready
					to end your current session.</div>
				<div class="modal-footer">
					<button class="btn btn-secondary" type="button"
						data-dismiss="modal">Cancel</button>
					<a class="btn btn-primary" href="login.html">Logout</a>
				</div>
			</div>
		</div>
	</div>

<script type="text/javascript">
$(document).ready(function () {
	var name= "${principal.id}";
	console.log(name);
})

</script>

	<!-- Bootstrap core JavaScript-->
	<script src="/resources/vendor/jquery/jquery.min.js"></script>
	<script src="/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

	<!-- Core plugin JavaScript-->
	<script src="/resources/vendor/jquery-easing/jquery.easing.min.js"></script>

	<!-- Custom scripts for all pages-->
	<script src="/resources/js/sb-admin-2.min.js"></script>

	<!-- Page level plugins -->
	<script src="/resources/vendor/chart.js/Chart.min.js"></script>

	<!-- Page level custom scripts -->
	<script src="/resources/js/demo/chart-area-demo.js"></script>
	<script src="/resources/js/demo/chart-pie-demo.js"></script>

	</div>
</body>

</html>