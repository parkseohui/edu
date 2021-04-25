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
	#notice_default{
		margin-top: 80px;
		margin-left: 100px;
		margin-right: 100px;
	}
	
	#notice-head{
	margin-bottom: 30px;
	}
	
	#bbsDetail .bbsNotice h2 {
    width: 88%;
    font-size: 25px;
    color: #292929;
}
	
	#bbsDetail .bbsNotice.date {
    width: 20%;
    padding-bottom: 7px;
    text-align: right;
}
em{
    font-size: 15px;
    line-height: 1;
    color: #808080;
}
#bbsDetail .bbsNotice > * {
    display: table-cell;
    vertical-align: bottom;
}
#bbsDetail .bbsNotice {
    display: table;
    width: 100%;
    padding-bottom: 30px;
    border-bottom: 5px solid #292929;
}
#bbsDetail .bbsNotice .date em + em:before {
    display: inline-block;
    content: '';
    width: 1px;
    height: 18px;
    margin: -2px 13px 0 15px;
    background: #d1d1d1;
    vertical-align: middle;
}
#bbsDetail .bbsCon {
    padding: 50px 0 60px;
    border-bottom: 1px solid #292929;
}
.btnbox{
margin-top: 12px; 
margin-left: 89%;
}
</style>
</head>

<body id="page-top">

	<!-- Page Wrapper -->
	<div id="wrapper">
		<jsp:include page="managerMenu.jsp"></jsp:include>
		<!-- End of Topbar -->

		<!-- Begin Page Content -->
		<div class="row">
			<!-- start row -->
			<div class="col-lg-12" id="bbsDetail">
				<div class="panel panel-default" id="notice_default">
					<strong><div class="panel panel-heading" id="notice-head">공지사항</div></strong>
						<div class="panel-body" id="notice-body">

						<!-- form 시작 -->
						
						<div class="bbsNotice"> 
							<h2>
							<c:out value="${notice.title }"/>
							</h2>
							<span class="date">
								<em>
									<fmt:formatDate pattern="yyyy-MM-dd" value="${notice.regdate}" />
								</em>
							
								<em>
								<c:out value="${notice.hits }"/>
								</em>
							</span>
						</div>

						<div class="bbsCon">
							<c:out value="${notice.content }" />
						</div>
						
						
						<div class="btnbox">
						<button data-oper='modify' class="btn btn-light">Modify</button>
						<button data-oper='list' class="btn btn-outline-secondary">List</button>
						</div>
					</div>
					<!-- end  panel-body -->
				</div>
				<!-- end panel -->
			</div>
		</div>
		<!-- end row -->

		<!-- Page Heading -->

		<!-- End of Main Content -->


		<form id='operForm' action="/keeper/modifyNoticeKeeper" method="get">
			<input type='hidden' id='noticeSeq' name='noticeSeq'
				value='<c:out value="${notice.noticeSeq}"/>'> <input
				type='hidden' name='pageNum' value='<c:out value="${cri.pageNum}"/>'>
			<input type='hidden' name='amount'
				value='<c:out value="${cri.amount}"/>'>
		</form>



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

	<script>
	$(document).ready(function() {
		var operForm = $("#operForm");
		$("button[data-oper='modify']").on("click", function(e) {
			operForm.attr("action", "/keeper/modifyNoticeKeeper").submit();
		});
		$("button[data-oper='list']").on("click", function(e) {
			operForm.find("#noticeSeq").remove();
			operForm.attr("action", "/keeper/listNoticeKeeper")
			operForm.submit();
		});
	});
</script>


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