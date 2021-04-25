<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">
<title></title>
<!-- Custom fonts for this template-->
<link href="/resources/vendor/fontawesome-free/css/all.min.css"
	rel="stylesheet" type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">

<!-- Custom styles for this template-->
<link href="/resources/css/sb-admin-2.min.css" rel="stylesheet">
<script src="/resources/vendor/jquery.min.js"></script>


<style type="text/css">
.btnPaging {
	margin-top: 60px;
	text-align: center;
}
.pagination {
	margin-left: 570px;
	margin-right: 570px;
}
.paginate_button a {
	display: inline-block;
	width: 30px;
	height: 30px;
	margin: 0 3px;
	vertical-align: top;
	border: 1px solid #d1d1d1;
	border-radius: 5px;
	background: #fff;
}
.paginate_button a [aria-selected="true"] {
	border-color: #ffbc0d;
	background-color: #ffbc0d;
}
a {
	text-decoration: none;
	color: inherit;
}
ul, li {
	list-style: none outside;
}
.notice_Date {
	display: table-cell;
	width: 19%;
	text-align: center;
}
.notice_Title {
	display: table-cell;
	padding: 0 45px;
}
.notice_Seq {
	display: table-cell;
	width: 11%;
	text-align: center;
}
#notice-body {
	margin-top: 10px;
}
#notice_default {
	margin-left: 40px;
	margin-right: 40px;
	font-family: SpeedeeK, Malgun Gothic, '맑은 고딕', Dotum, '돋움', Arial, sans-serif;
}
#notice_header {
	margin-left: 40px;
	margin-right: 40px;
	font-family: SpeedeeK, Malgun Gothic, '맑은 고딕', Dotum, '돋움', Arial,
		sans-serif;
}
#regBtn{
margin-left: 96%;
}
li.paginate_button.active > a {
	background-color: #6e707e26;
}
/* #notice-body .ico { */
/*     display: inline-block; */
/*     width: 25px; */
/*     height: 23px; */
/*     overflow: hidden; */
/*     text-indent: -9999px; */
/*     vertical-align: middle; */
/*     background: url(/resources/img/favorite-24px.svg) 0 0 no-repeat; */
/* } */
</style>


</head>

<body id="page-top">

	<!-- Page Wrapper -->
	<div id="wrapper">
		<jsp:include page="managerMenu.jsp"></jsp:include>
		<!-- End of Topbar -->

		<div class="row">
			<div class="col-lg-12">
				<strong><h1 class="page-header" id="notice_header">NOTICE</h1></strong>
			</div>
		</div>

		<!-- Begin Page Content -->
		<div class="row">
			<!-- start row -->
			<div class="col-lg-12">
				<div class="panel panel-default" id="notice_default">
					<div class="panel panel-heading">
						총 <strong>${pageMaker.total }개</strong>의 게시물이 있습니다.
					</div>

					<button type="button" class="btn btn-outline-secondary btn-sm" id="regBtn">notice</button>
						
						
					<div class="panel-body" id="notice-body">
						<table class="table table-hover">
							<thead>
								<tr>
									<th scope="col" class="notice_Seq">글번호</th>
									<th scope="col" class="notice_Title">제목</th>
									<th scope="col" class="notice_Date">작성일</th>
								</tr>
							</thead>
							<c:forEach items="${list }" var="notice">
								<tbody>
									<tr>
										<td class="notice_Seq"><c:out value="${notice.noticeSeq }" />
											<b class="ico"><c:out value="${notice.category }" /></b>
										</td>
										<td class="notice_Title"><a class="move"
											href='<c:out value="${notice.noticeSeq }"/>'> 
											<c:out value="${notice.title }" /></a></td>
										<td class="notice_Date"><fmt:formatDate
												pattern="yyyy-MM-dd" value="${notice.regdate}" /></td>
									</tr>
								</tbody>
							</c:forEach>

						</table>

						<div class='btnPaging'>
							<ul class="pagination">

								<c:if test="${pageMaker.prev}">
									<li class="paginate_button previous"><a
										href="${pageMaker.startPage -1}">Previous</a></li>
								</c:if>

								<c:forEach var="num" begin="${pageMaker.startPage}"
									end="${pageMaker.endPage}">
									<li class="paginate_button  ${pageMaker.cri.pageNum == num ? "active":""}">
										<a href="${num}">${num}</a>
									</li>
								</c:forEach>

								<c:if test="${pageMaker.next}">
									<li class="paginate_button next"><a
										href='${pageMaker.endPage +1 }'>Next</a></li>
								</c:if>

							</ul>
						</div>
						<!--  end Pagination -->

						<form id='actionForm' action="/tenant/listNotice" method='get'>
							<input type='hidden' name='pageNum'
								value='${pageMaker.cri.pageNum}'> <input type='hidden'
								name='amount' value='${pageMaker.cri.amount}'>
						</form>

						<!-- Modal  추가 -->
						<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
							aria-labelledby="myModalLabel" aria-hidden="true">
							<div class="modal-dialog">
								<div class="modal-content">
									<div class="modal-header">
										<button type="button" class="close" data-dismiss="modal"
											aria-hidden="true">&times;</button>
										<h4 class="modal-title" id="myModalLabel">Modal title</h4>
									</div>
									<div class="modal-body">처리가 완료되었습니다.</div>
									<div class="modal-footer">
										<button type="button" class="btn btn-default"
											data-dismiss="modal">Close</button>
										<button type="button" class="btn btn-primary">Save
											changes</button>
									</div>
								</div>
								<!-- /.modal-content -->
							</div>
							<!-- /.modal-dialog -->
						</div>
						<!-- /.modal -->


					</div>
					<!-- end  panel-body -->
				</div>
				<!-- end panel -->
			</div>
		</div>
		<!-- end row -->

		<!-- Page Heading -->

		<!-- End of Main Content -->

		<script>
			$(document)
					.ready(
							function() {
								var result = '<c:out value="${result}"/>';
								checkModal(result);
								// 						history.replaceState({},null,null);
								function checkModal(result) {
									// 							if (result === '' history.state) {
									// 								return;
									// 							}
									console.log(result);
									if (parseInt(result) > 0) {
										$(".modal-body").html(
												"게시글 " + parseInt(result)
														+ " 번이 등록되었습니다.");
										$("#myModal").modal("show");
									}
									return;
								}
								$("#regBtn").on("click", function() {
									self.location = "/keeper/registerNotice";
								});
								var actionForm = $("#actionForm");
								$(".paginate_button a").on(
										"click",
										function(e) {
											e.preventDefault();
											console.log('click');
											actionForm.find(
													"input[name='pageNum']")
													.val($(this).attr("href"));
											actionForm.submit();
										});
								$(".move")
										.on(
												"click",
												function(e) {
													e.preventDefault();
													actionForm
															.append("<input type='hidden' name='noticeSeq' value='"
																	+ $(this)
																			.attr(
																					"href")
																	+ "'> ");
													actionForm
															.attr("action",
																	"/tenant/getNotice");
													actionForm.submit();
												});
							});
		</script>



		<!-- /.container-fluid -->
		<div class="modal fade" id="logoutModal" tabindex="-1" role="dialog"
			aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="exampleModalLabel">Ready to
							Leave?</h5>
						<button class="close" type="button" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true"></span>
						</button>
					</div>
					<div class="modal-body">정말 로그아웃 하시겠습니까?</div>
					<div class="modal-footer">
						<button class="btn btn-secondary" type="button"
							data-dismiss="modal">Cancel</button>
						<a class="btn btn-primary" href="/Aptogether/member/logout.do">Logout</a>
					</div>
				</div>
			</div>
		</div>
	</div>



	<!-- Footer -->
	<jsp:include page="footer.jsp"></jsp:include>
	<!-- End of Footer -->

	<!-- End of Content Wrapper -->

	<!-- End of Page Wrapper -->

	<!-- Scroll to Top Button-->
	<a class="scroll-to-top rounded" href="#page-top"> <i
		class="fas fa-angle-up"></i>
	</a>


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
	<script src="/resources/vendor/datatables/jquery.dataTables.min.js"></script>
	<script src="/resources/vendor/datatables/dataTables.bootstrap4.min.js"></script>
	<script src="/resources/js/demo/datatables-demo.js"></script>
	<script type="text/javascript"
		src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
</body>
</html>