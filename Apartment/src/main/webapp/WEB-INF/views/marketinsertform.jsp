<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
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

<script type="text/javascript">
	var i = 1;
	function addimg() {
		var imaddimg = document.getElementById("hey");
		imaddimg.innerHTML += '<input type="file" name="fname'+i+'"><br>';
		i++;
	}
</script>

	<script src="https://code.jquery.com/jquery-3.3.1.min.js"
		integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
		crossorigin="anonymous"></script>


<script type="text/javascript">
$(document).ready(function(){
	var filename='';
	$("#uploadBtn").on("click",function(e){
		var formData=new FormData();
		var inputFile=$("input[name='fnames']");
		console.log(inputFile)
		var files=inputFile[0].files;
		/* console.log(files); */
		for(var i=0;i<files.length;i++){
			/* console.log(files[i]); */
 			formData.append("fnames",files[i]);
		}
		console.log("밑:"+formData.get("fnames"));	
		$.ajax({
			url:'/tenant/uploadAjaxAction',
			processData:false,
			contentType:false,
			enctype:'multipart/form-data',
			data:formData,
			type:'POST',
			success:function(result){
				alert('upload');
			}
		});
		filename=formData.get("fnames");
		console.log((files[0].name))
		$("input[name='fname']").val((files[0].name));
		/* console.log(formData.get("fname")); */
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
					<div class="row"></div>
						<h1 class="mt-4">중고거래</h1>
	


						<!--  -->
						<div class="card mb-4">
									<div class="card-body">
										<form action="/tenant/market/register" method="post" enctype="multipart/form-data">
											<div class="card-body">
												작성자: &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
												<sec:authentication property='principal.username'/>
												<input
													type="hidden" name="writer" value="<sec:authentication property='principal.username'/>"><br>
												<br> 판매물품 :&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<input
													type="text" name="productName"><br>
												<br>
												가격:&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<input
													type="text" name="price"><br>
												<br>
											</div>


											<div class="card-body">
												사진:
												<p></p>
												<input type="file" name="fnames" multiple>
													<br>
													<input id="here" type="hidden" name="fname" >
											</div>
											
											<div class="card-body">
												내용 <br>
												<textarea rows="6" cols="70" name="contents" style="width:100%;height:100;border:1;overflow:visible;text-overflow:ellipsis;"></textarea>
												<br> 판매중:<input type="text" name="isSale"> <input id='uploadBtn2'
													type="submit" value="등록">
											</div>
										</form>
										<button id='uploadBtn'>upload</button>
									</div>
								</div>
							</div>
							</main>
							</div></div>	</div>
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

			</div>
</body>

</html>
















