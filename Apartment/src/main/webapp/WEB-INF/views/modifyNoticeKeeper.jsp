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
<script src="/resources/vendor/jquery/jquery.js"></script>
<style type="text/css">
#notice_default {
	margin-top: 80px;
	margin-left: 250px;
	margin-right: 250px;
}
#notice-head {
	margin-bottom: 30px;
}
.bbsNotice > * {
    display: table-cell;
    vertical-align: bottom;
}
.bbsNotice {
    display: table;
    width: 100%;
    padding-bottom: 20px;
    margin-bottom: 20px;
    border-bottom: 3px solid #292929;
}
.bbs.content{
	margin-top: 10px;
}
.btnbox{
margin-top: 12px; 
margin-left: 78%;
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
					<div class="panel panel-heading" id="notice-head">수정</div>
					<div class="panel-body" id="notice-body">

						<!-- form 시작 -->
						<form role="form" action="/keeper/modifyNoticeKeeper" method="post">

							<input type='hidden' name='pageNum'
								value='<c:out value="${cri.pageNum }"/>'> <input
								type='hidden' name='amount'
								value='<c:out value="${cri.amount }"/>'>

							<div class="form-group">
								<input class="form-control" name="noticeSeq" type="hidden"
									value='<c:out value="${notice.noticeSeq }"/>'
									readonly="readonly">
							</div>
							
							<div class="bbsNotice">
								<label>제목</label><input class="col-lg-6" name="title" id="bbsNotice.title"  style="margin-right: 400px;"
									value='<c:out value="${notice.title }"/>'>
									<div>
									<label for="category">구분</label> 
								<select class="inputForm" type="text" name="category" id="category">
									<option value="일반">일반</option>
									<option value="공지">공지</option>
								</select>
								</div>
							</div>

							<div class="form-group" id="bbsNotice.content">
								<label class="bbs.content">text area</label>
								<textarea class="form-control" rows="3" name="content"><c:out
										value="${notice.content }" /></textarea>
							</div>
							
							<div class="btnbox"> 
							<button type="submit" data-oper='remove' class="btn btn-outline-secondary">Delete</button>
								<button type="submit" data-oper='modify' class="btn btn-outline-secondary">Modify</button>
								<button type="submit" data-oper='list' class="btn btn-outline-dark">List</button>
							</div>
						</form>
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
			$(function() {
				var formObj = $("form");
				$('button').on("click",function(e) {
							e.preventDefault();
							var operation = $(this).data("oper");
							console.log(operation);
							if (operation === 'remove') {
								formObj.attr("action", "/keeper/removeNoticeKeeper");
							} else if (operation === 'list') {
								//move to list
								// 						self.location = "/keeper/listNotice";
								formObj.attr("action", "/keeper/listNoticeKeeper").attr("method", "get");
								var pageNumTag = $("input[name='pageNum']").clone();
								var amountTag = $("input[name='amount']").clone();
								formObj.empty();
								formObj.append(pageNumTag);
								formObj.append(amountTag);
							}
							formObj.submit();
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