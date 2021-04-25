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
		<jsp:include page="userMenu.jsp"></jsp:include>
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