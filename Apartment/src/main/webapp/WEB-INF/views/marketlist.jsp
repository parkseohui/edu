
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
<script src="http://code.jquery.com/jquery.min.js"></script>
<style type="text/css">
#mybutton{
float:right;
}
a {
   text-decoration: none;
   color: inherit;
}
.paginate_button a {
	text-align:center;
   display: inline-block;
   width: 30px;
   height: 30px;
   margin: 0 3px;
   vertical-align: top;
   border: 1px solid #d1d1d1;
   border-radius: 5px;
   background: #fff;
}
</style>
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

<script type="text/javascript">
	var i = 1;
	function addimg() {
		var imaddimg = document.getElementById("hey");
		imaddimg.innerHTML += '<input type="file" name="fname'+i+'"><br>';
		i++;

	}
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
<script type="text/javascript">
	$(document).ready(function() {
		var actionForm = $("#actionForm");
		console.log('시발');
		
		$(".paginate_button a").on("click", function(e) {

			e.preventDefault();

			console.log('click');

			actionForm.find("input[name='pageNum']").val($(this).attr("href"));
			actionForm.submit();
		});

	});
</script>

	<!-- Page Wrapper -->
	<div id="wrapper">
<jsp:include page="userMenu.jsp"></jsp:include>
				<!-- Begin Page Content -->
				<div class="container-fluid">
					<!-- Content Row -->
					<div class="row"></div>
					<div class="row"></div>
						<h1 class="mt-4">중고거래${pageMaker.total} <button id="mybutton" class="btn btn-primary" onClick="location.href='/tenant/market/insertform'">글쓰기</button></h1>
						<!--  -->
						<div class="card mb-4">
							<div class="card-body">
								<div id="columns">
									<c:forEach var="board" items="${list}">
										<figure>
										<img src="<spring:url value='/tenant/download?fileName=${board.fname}'/>">
											<a href="get?seq=${board.seq}">
												<figcaption>물품명:${board.productName}</figcaption>
											</a>
										</figure>
									</c:forEach>

								</div>
									<form id='actionForm' action="/tenant/market/list" method='get'>
										<input type='hidden' name='pageNum'
											value='${pageMarker.cri.pageNum}'> <input
											type='hidden' name='amount' value='${pageMarker.cri.amount}'>
									</form>
									<div class='pull-right'>
										<ul class="pagination">

											<c:if test="${pageMarker.prev}">
												<li class="paginate_button previous"><a
													href="${pageMarker.startPage-1}">[이전]</a>
											</c:if>
											<c:forEach var="pageNo" begin="${pageMarker.startPage }"
												end="${pageMarker.endPage }">
												<li
													class="paginate_button  ${pageMarker.cri.pageNum == num ? "active":""} ">
													<a href="${pageNo}">${pageNo}</a>
													<!-- /tenant/market/list?pageNum= -->
											</c:forEach>

											<c:if test="${pageMarker.next }">
												<li class="paginate_button next"><a
													href="${pageMarker.endPage+1}">[이후]</a>
											</c:if>
										</ul>
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
						<h5 class="modal-title" id="exampleModalLabel">Ready to
							Leave?</h5>
						<button class="close" type="button" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">×</span>
						</button>
					</div>
					<div class="modal-body">Select "Logout" below if you are
						ready to end your current session.</div>
					<div class="modal-footer">
						<button class="btn btn-secondary" type="button"
							data-dismiss="modal">Cancel</button>
						<a class="btn btn-primary" href="login.html">Logout</a>
					</div>
				</div>
			</div>
		</div>

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
	
	<style>
#wannacenter {
	text-align: center;
}

#columns {
	column-width: 200px;
	column-gap: 80px;
	
}

#columns figure {
	display: inline-block;
	border: 1px solid rgba(0, 0, 0, 0.2);
	margin-right: 10px;
	margin-bottom: 15px;
	padding: 10px;
	box-shadow: 2px 2px 5px rgba(0, 0, 0, 0.5);;
}

#columns figure img {
	width: 225px;
	height: 225px;
}

#columns figure figcaption {
	border-top: 1px solid rgba(0, 0, 0, 0.2);
	padding: 10px;
	margin-top: 11px;
}

#paginglist {
	text-align: center;
	margin: 10px auto;
}
</style>


</body>

</html>
