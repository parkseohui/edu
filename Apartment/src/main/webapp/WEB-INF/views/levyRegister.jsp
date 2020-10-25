<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
<link href="/resources/vendor/fontawesome-free/css/all.min.css" rel="stylesheet"
	type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">

<!-- Custom styles for this template-->
<link href="/resources/css/sb-admin-2.min.css" rel="stylesheet">
<style>
	.table {
		text-align: center;
	}	
		
	.table thead th {
		display: table-cell;
		vertical-align: middle;
		color: black;
	}
	
	.levyModalL{
		margin-left: 20px;
		float: left;
	}
	
	.levyModalI{
		width: 37%;
		margin-left: 150px;
	}
	
	
</style>
</head>

<body id="page-top">

	<!-- Page Wrapper -->
	<div id="wrapper">
	<jsp:include page="managerMenu.jsp"></jsp:include>
				<!-- End of Topbar -->

				<!-- Begin Page Content -->
				<div class="container-fluid">

					<!-- Page Heading -->
					<div
						class="d-sm-flex align-items-center justify-content-between mb-4">
						<h1 class="h3 mb-0 text-gray-800">[APTOGETHER 관리비 부과]</h1>
						<p id="unitPriceSeq"></p>
					</div>


					<!-- Content Row -->
					<div class="row">
					
						<div class="container-fluid">
							<div class="card mb-4">
								<div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
									<h6 class="m-0 font-weight-bold text-primary">관리비 부과기초작업</h6>
									<button id="addLevy" class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm">
										추가</button>
								</div>
								<div class="card-body">
									<table class="table table-bordered table-hover">
									  <thead class="table-primary">
									    <tr>
									      <th scope="col" rowspan="2">상태</th>
									      <th scope="col" rowspan="2">부과년월</th>
									      <th scope="col" colspan="2">산출기간</th>
									      <th scope="col" rowspan="2">납부마감일</th>
									    </tr>
									    <tr>
									    <th scope="col">시작일</th>
									    <th scope="col">종료일</th>
									    </tr>
									  </thead>
									  <tbody id="levyTable">
									  </tbody>
									</table>
									<%--  <form action="" commandName="feeVO" method="post">
										<div class="form-group row">
											<label for="member_seq" class="col-sm-2 col-form-label">세대번호</label>
											<div class="col-sm-10">
												<input type="text" readonly class="form-control-plaintext"
													id="member_seq" value="${memberSeq}">
											</div>
										</div>
										<div class="form-group row">
											<label for="pay_date" class="col-sm-2 col-form-label">청구일자</label>
											<div class="col-sm-10">
												<input type="date" class="form-control" id="pay_date">
											</div>
										</div>
										<div class="form-group row">
											<label for="general_fee" class="col-sm-2 col-form-label">일반관리비</label>
											<div class="col-sm-10">
												<input type="text" class="form-control" id="general_fee">
											</div>
										</div>
										<div class="form-group row">
											<label for="security_fee" class="col-sm-2 col-form-label">경비비</label>
											<div class="col-sm-10">
												<input type="text" class="form-control" id="security_fee">
											</div>
										</div>
										<div class="form-group row">
											<label for="cleaning_fee" class="col-sm-2 col-form-label">청소비</label>
											<div class="col-sm-10">
												<input type="text" class="form-control" id="cleaning_fee">
											</div>
										</div>
										<div class="form-group row">
											<label for="fumigation_fee" class="col-sm-2 col-form-label">소독비</label>
											<div class="col-sm-10">
												<input type="text" class="form-control" id="fumigation_fee">
											</div>
										</div>
										<div class="form-group row">
											<label for="lift_maintenance_fee"
												class="col-sm-2 col-form-label">승강기유지비</label>
											<div class="col-sm-10">
												<input type="text" class="form-control"
													id="lift_maintenance_fee">
											</div>
										</div>
										<div class="form-group row">
											<label for="electricity_fee" class="col-sm-2 col-form-label">전기세</label>
											<div class="col-sm-10">
												<input type="text" class="form-control" id="electricity_fee">
											</div>
										</div>
										<div class="form-group row">
											<label for="water_fee" class="col-sm-2 col-form-label">수도세</label>
											<div class="col-sm-10">
												<input type="text" class="form-control" id="water_fee">
											</div>
										</div>
										<div class="form-group row">
											<label for="heating_fee" class="col-sm-2 col-form-label">난방비</label>
											<div class="col-sm-10">
												<input type="text" class="form-control" id="heating_fee">
											</div>
										</div>
									 </form> 
									<button class="btn btn-primary" id="manage_fee_register">관리비 등록</button> --%>
									
								</div>
							</div>
						</div>
					</div>
					
					<!-- 관리비 부과 추가 모달창 -->
					<div class="modal fade" id="levyModal" tabindex="-1" role="dialog" aria-labelledby="levyModalLabel" aria-hidden="true">
					  <div class="modal-dialog">
					    <div class="modal-content">
					      <div class="modal-header">
					        <h5 class="modal-title" id="levyModalLabel">관리비 부과기초작업</h5>
					        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
					          <span aria-hidden="true">&times;</span>
					        </button>
					      </div>
					      <div class="modal-body">
					        <form>
					          <div class="form-group">
					            <label for="levyDate" class="col-form-label levyModalL">부과년월</label>
					            <input type="month" class="form-control levyModalI" id="levyDate">
					          </div>
					          <div class="form-group">
					            <label for="deadlineDate" class="col-form-label levyModalL">납부마감일</label>
					            <input type="date" class="form-control levyModalI" id="deadlineDate">
					          </div>
					        </form>
					      </div>
					      <div class="modal-footer">
					        <button type="button" id="levyReg" class="btn btn-primary">등록</button>
					        <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
					      </div>
					    </div>
					  </div>
					</div>
					

				</div>
				<!-- /.container-fluid -->
					<div class="modal fade" id="logoutModal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">Ready to Leave?</h5>
					<button class="close" type="button" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true"></span>
					</button>
				</div>
				<div class="modal-body"> 정말 로그아웃 하시겠습니까? </div>
				<div class="modal-footer">
					<button class="btn btn-secondary" type="button"
						data-dismiss="modal">Cancel</button>
					<a class="btn btn-primary" href="/Aptogether/member/logout.do">Logout</a>
				</div>
			</div>
		</div>
	</div>
			</div>
			<!-- End of Main Content -->

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
	<script src="/resources/js/fee.js"></script>   
	<script src="/resources/vendor/datatables/jquery.dataTables.min.js"></script>
	<script src="/resources/vendor/datatables/dataTables.bootstrap4.min.js"></script>
	<script src="/resources/js/demo/datatables-demo.js"></script>
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
	<script>
	$(function() {
		
		$("#addLevy").on("click", function() {
			$(".levyModalI").val("");
			$("#levyModal").modal('show');
		});
		
 		var levyDate = $("#levyDate");
		var deadlineDate = $("#deadlineDate");		
		
		$("#levyReg").on("click", function(e) {
			
			var year = levyDate.val().replace(/-\d{2}/g,'');
			var month = levyDate.val().replace(/^\d{4}-/g,'');
			var date = new Date(year, month);
			var startDate =moment(new Date(year, month - 1)).format('YYYY.MM.DD');
		   	var endDate = moment(new Date(date - 1)).format('YYYY.MM.DD');
			
			if(levyDate.val() && deadlineDate.val() !=""){
				
					var levy = {
						levyDate : levyDate.val(),
						startCalDate : startDate,
						endCalDate : endDate,
						deadlineDate : deadlineDate.val()
					};
				
					feeService.addLevy(levy, function(result) {
						alert("관리비 부과정보 등록완료");
						$("#levyModal").modal('hide');
						 location.reload();

				});
			
			}else if(levyDate.val() == "", deadlineDate.val() != ""){
				alert("부과년월을 선택해주세요.");
			}else if(deadlineDate.val() == "", levyDate.val() != ""){
				alert("납부마감일을 선택해주세요.");
			}else{
				alert("부과정보를 입력해주세요.");
			}
			
			
			
		});
		
		
		
		
		feeService.listLevy(function(list) {
			
			for(var i = 0, len = list.length||0; i <len; i++){
				console.log(list[i]);
				$("#levyTable").append('<tr>'
														+'<td>'+ list[i].status+'</td>'
													 	+'<td>'+ '<a href="/keeper/feeRegister/'+ moment(list[i].levyDate).format('YYYYMM')+'">'+moment(list[i].levyDate).format('YYYY년 MM월')+'</a>'+'</td>' 
														+'<td>'+ moment(list[i].startCalDate).format('YYYY년 MM월 DD일')+'</td>'
														+'<td>'+ moment(list[i].endCalDate).format('YYYY년 MM월 DD일')+'</td>'
														+'<td>'+ moment(list[i].deadlineDate).format('YYYY년 MM월 DD일')+'</td>'
												    +'</tr>');
				
				
			} 
			
			
		}); 
		
		


		
		

		
		
		 

		
		
	});
	
	
	
	

	

	
/* 	var member_seq = $('#member_seq');
	var general_fee = $('#general_fee');
	var security_fee = $('#security_fee');
	var cleaning_fee = $('#cleaning_fee');
	var fumigation_fee = $('#fumigation_fee');
	var lift_maintenance_fee = $('#lift_maintenance_fee');
	var electricity_fee = $('#electricity_fee');
	var water_fee = $('#water_fee');
	var heating_fee = $('#heating_fee');
	var pay_date = $('#pay_date');

	$(function() {
		//숫자 세자리 수 마다 콤마 붙는 정규표현식 함수
		function AmountCommas(val){
		    return val.toString().replace(/\B(?=(\d{3})+(?!\d))/g,",");
		}
		
		createTable();
		function createTable() {
			$.ajax({
				url : "/keeper/listFee/"+ member_seq.val(),
				type : "get",
				dataType : "json",
				success : function(result) {
					console.log(result);
					 $('.fee-table').html('<tr><td></td><td>일반관리비</td><td>경비비</td><td>청소비</td><td>소독비</td><td>승강기유지비</td><td>전기세</td><td>수도세</td><td>난방비</td><td>합계</td></tr>');
					for (var i = 0; i < result.length; i++) {
						$('.fee-table').append(
										'<tr>'
											+'<td>'+ moment(result[i].payDate).format('YYYY년 MM월 관리비')+'<br>'+'<small>'+moment(result[i].payDate).format('납부기한 : YYYY년 MM월 DD일 까지') + '</small>'+ '</td>'
											+'<td>'+ AmountCommas(result[i].generalFee) + '원'+ '</td>'
											+'<td>'+ AmountCommas(result[i].securityFee) + '원'+ '</td>'
											+'<td>'+ AmountCommas(result[i].cleaningFee) + '원'+ '</td>'
											+'<td>'+ AmountCommas(result[i].fumigationFee) + '원'+ '</td>'
											+'<td>'+ AmountCommas(result[i].liftMaintenanceFee) + '원'+ '</td>'
											+'<td>'+ AmountCommas(result[i].electricityFee) + '원'+ '</td>'
											+'<td>'+ AmountCommas(result[i].waterFee) + '원'+ '</td>'
											+'<td>'+ AmountCommas(result[i].heatingFee) + '원'+ '</td>'
											+'<td>'+ AmountCommas(result[i].generalFee + result[i].securityFee + result[i].cleaningFee + 
																					   result[i].fumigationFee + result[i].liftMaintenanceFee + result[i].electricityFee+
																					   result[i].waterFee + result[i].heatingFee) + '원'
										    + '</td>'
									+ '</tr>');
									}
								}
							});
					}
		
		
		$("#manage_fee_register").on("click", function(e) {
			
			var fee = {
					memberSeq : member_seq.val(),
					generalFee : general_fee.val(),
					securityFee : security_fee.val(),
					cleaningFee : cleaning_fee.val(),
					fumigationFee : fumigation_fee.val(),
					liftMaintenanceFee : lift_maintenance_fee.val(),
					electricityFee : electricity_fee.val(),
					waterFee : water_fee.val(),
					heatingFee : heating_fee.val(),
					payDate : pay_date.val()
			};
			
			feeServcie.insertFee(fee, function(result) {
				console.log(result);
			});
		}); 
		
	}); */
	
	</script>

</body>

</html>
