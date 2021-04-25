<%@page import="org.springframework.security.core.Authentication"%>
<%@page import="org.apartment.domain.CustomKeeper"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<sec:authentication var="principal" property="principal" />


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
	#selectDong{
		width: 120px;
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
					<div class="d-sm-flex align-items-center justify-content-between mb-4">
						<fmt:parseDate var="date" value="${levyD}" pattern="yyyy-MM-dd" />
						<h1 class="h3 mb-0 text-gray-800"><strong style="color: royalblue;"><fmt:formatDate value="${date}" pattern="yyyy년 MM월 관리비 부과" /></strong></h1>
					
					</div>
					

					<!-- Content Row -->
					<div class="row">
						<div class="container-fluid">
							<div class="card mb-4">
								<div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
									<h6 class="m-0 font-weight-bold text-primary">관리비 부과기초작업</h6>
									<select class="custom-select" id="selectDong"></select>
								
								</div>
								
								<div class="card-body">
									<table class="table table-bordered table-hover">
									  <thead class="table-primary">
									    <tr>
									      <th scope="col" colspan="2">세대정보</th>
									      <th scope="col" colspan="7">요금항목</th>
									      <th scope="col" rowspan="2">부과작업</th>
									    </tr>
									    <tr>
									    <th scope="col">동</th>
									    <th scope="col">호</th>
									   <!--  <th scope="col">공급면적</th> -->
									    <th scope="col">일반관리비</th>
									    <th scope="col">경비비</th>
									    <th scope="col">청소비</th>
									    <th scope="col">소독비</th>
									    <th scope="col">승강기유지비</th>
									    <th scope="col">전기료</th>
									    <th scope="col">수도료</th>
									    </tr>
									  </thead>
									  <tbody id="feeTable">
									  </tbody>
									</table>
									
								</div>
							</div>
						</div>
					</div>
									
					

				</div>
				<!-- /.container-fluid -->
				
				<!-- 업데이트 확인모달 -->
				<div class="modal fade" id="UpdateCheck" tabindex="-1" role="dialog" aria-hidden="true">
				  <div class="modal-dialog modal-dialog-centered" role="document">
				    <div class="modal-content">
				      <div class="modal-header">
				        <h5 class="modal-title">관리비 부과 업데이트</h5>
				        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
				          <span aria-hidden="true">&times;</span>
				        </button>
				      </div>
				      <div class="modal-body" id="feeUpdateContent">
				        
				      </div>
				      <div class="modal-footer">
				        <button type="button" class="btn btn-primary" id="save">확인</button>
				        <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
				      </div>
				    </div>
				  </div>
				</div>
				<!-- 업데이트 확인모달 끝-->
				
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
					<a class="btn btn-primary" href="/apartment/member/logout.do">Logout</a>
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
			console.log(feeService);
		
			function Commas(val){
			    return val.toString().replace(/\B(?=(\d{3})+(?!\d))/g,",");
			}
			
			feeService.listDong(function(list) {
					console.log(list);
					for(var i = 0, len = list.length||0; i <len; i++){
						$("#selectDong").append('<option value="'+list[i].dong+'">'+list[i].dong+' 동'+'</option>');
					} 
				 feeService.levyInfo({levyDate : "<c:out value="${levyD}"/>", aptSeq : ${principal.aptSeq} }, function(levinfo) {
					console.log(levinfo);
				
					
					$.getJSON("/keeper/listFeeReg/"+ levinfo.levySeq +"/"+list[0].dong + ".json",
						function(data) {
						console.log(data);
							$("#feeTable").append('<tr>' +'<td class="dongtd" style="vertical-align: middle;">'+  $("#selectDong option:selected").val() + '</td>' + '</tr>');
						 		for(var i = 0, len = data.length||0; i <len; i++){
 										$("#feeTable").append('<tr>'
											   									+'<td>'+ data[i].feeList[0].ho+ '</td>'
 																			   	+'<td>'+ '<input type="text" class="form-control fee'+data[i].householdSeq+'" value="'+Commas(data[i].feeList[0].generalBill)+'"readonly>'+ '</td>'
 																			   	+'<td>'+ '<input type="text" class="form-control fee'+data[i].householdSeq+'" value="'+Commas(data[i].feeList[0].securityBill)+'"readonly>'+ '</td>'
 																			   	+'<td>'+ '<input type="text" class="form-control fee'+data[i].householdSeq+'" value="'+Commas(data[i].feeList[0].fumigationBill)+'"readonly>'+ '</td>'
 																			   	+'<td>'+ '<input type="text" class="form-control fee'+data[i].householdSeq+'" value="'+Commas(data[i].feeList[0].elevatorBill)+'"readonly>'+ '</td>'
 																			   	+'<td>'+ '<input type="text" class="form-control fee'+data[i].householdSeq+'" value="'+Commas(data[i].feeList[0].electricityBill)+'"readonly>'+ '</td>'
 																			   	+'<td>'+ '<input type="text" class="form-control fee'+data[i].householdSeq+'" value="'+Commas(data[i].feeList[0].waterBill)+'"readonly>'+ '</td>'
 																			   	+'<td>'+ '<input type="text" class="form-control fee'+data[i].householdSeq+'" value="'+Commas(data[i].feeList[0].electricityBill)+'"readonly>'+ '</td>'
																			   	+'<td id="modFeeTd'+data[i].householdSeq+'">'+ '<button name="living'+data[i].feeList[0].ho+'" id="modFee'+data[i].householdSeq+'" class="d-none d-sm-inline-block btn btn-sm btn-success shadow-sm modFeeBtn">'
																			   	+'관리비조정'+ '</button>'
																			   	+ '</td>' 
																			   	+'<td  id="modFeeSaveTd'+data[i].householdSeq+'" hidden>'+ '<button  id="modFeeSave'+data[i].householdSeq+'" class="d-none d-sm-inline-block btn btn-sm btn-danger shadow-sm modFeeBtnSave" data-toggle="modal" data-target="#UpdateCheck">'
																			   	+'저장'+ '</button>'
																			   	+ '</td>' 
																			  +'</tr>');
										
 										
 										$(".fee"+data[i].householdSeq).css("width","110px")
 													   .css("text-align", "center")
 													   .css("display", "block")
 													   .css("margin","0 auto");
 										
								} 
						 		 $(".dongtd").attr('rowspan',i+1); 
						 		 
						 		
									$(".modFeeBtn").on("click", function() {
										var ho = $(this).attr("name").replace(/[^0-9]/g,'');
										var householdSeq = $(this).attr("id").replace(/[^0-9]/g,'');
										$(".fee"+householdSeq).attr("readonly", false);
										$("#modFeeTd"+householdSeq).attr("hidden", true);
										$("#modFeeSaveTd"+householdSeq).attr("hidden", false);
										
										
									$("#modFeeSave"+householdSeq).on("click", function() {
										$("#feeUpdateContent").html($("#selectDong option:selected").val() +"동 " + ho + "호의 관리비 내역을 수정합니다.");
										$("#save").on("click", function () {
											
											$(".fee"+householdSeq).attr("readonly", true);
											$("#modFeeTd"+householdSeq).attr("hidden", false);
											$("#modFeeSaveTd"+householdSeq).attr("hidden", true);	
											
										
											
											var feeItem = $(".fee"+householdSeq);
	 										var fee = {
													generalBill : feeItem.eq(0).val(),
													securityBill : feeItem.eq(1).val(),
													cleaningBill : feeItem.eq(2).val(),
													fumigationBill : feeItem.eq(3).val(),
													elevatorBill : feeItem.eq(4).val(),
													electricityBill : feeItem.eq(5).val(),
													waterBill : feeItem.eq(6).val(),
													householdSeq : householdSeq,
													levySeq : data[0].feeList[0].levySeq
											};
											
												feeService.updateFee(fee, function() {
												}); 
												$("#UpdateCheck").modal("hide");
												$("#feeUpdateContent").html('');
										});
										
										});
										
									});
									
								
							}).fail(function(xhr, status, err) {
								if(error){
									error();
								}
							});
						}) ;
				}); 
			
			
			$("#selectDong").on("change", function() {
				
				var thisLevyDate = "<c:out value="${levyD}"/>";
				var selectedDong = $("#selectDong option:selected").val();
				console.log(thisLevyDate);
				
				feeService.levyInfo({levyDate : "<c:out value="${levyD}"/>", aptSeq : ${principal.aptSeq} }, function(levinfo) {
					console.log(levinfo);
				
			 	feeService.listFeeReg({levySeq: levinfo.levySeq ,dong : selectedDong}, function(list) {
			 		console.log(list);
			 		$("#feeTable").html('');
			 		$("#feeTable").append('<tr>'
						   	+'<td class="dongtd" style="vertical-align: middle;">'+ selectedDong + '</td>' + '</tr>');
			 		
			 		
			 		for(var i = 0, len = list.length||0; i <len; i++){
							$("#feeTable").append('<tr>'
																   	+'<td>'+ list[i].feeList[0].ho+ '</td>'
																   	+'<td>'+ '<input type="text" class="form-control fee'+list[i].householdSeq+'" value="'+Commas(list[i].feeList[0].generalBill)+'"readonly>'+ '</td>'
																   	+'<td>'+ '<input type="text" class="form-control fee'+list[i].householdSeq+'" value="'+Commas(list[i].feeList[0].securityBill)+'"readonly>'+ '</td>'
																   	+'<td>'+ '<input type="text" class="form-control fee'+list[i].householdSeq+'" value="'+Commas(list[i].feeList[0].fumigationBill)+'"readonly>'+ '</td>'
																   	+'<td>'+ '<input type="text" class="form-control fee'+list[i].householdSeq+'" value="'+Commas(list[i].feeList[0].elevatorBill)+'"readonly>'+ '</td>'
																   	+'<td>'+ '<input type="text" class="form-control fee'+list[i].householdSeq+'" value="'+Commas(list[i].feeList[0].electricityBill)+'"readonly>'+ '</td>'
																   	+'<td>'+ '<input type="text" class="form-control fee'+list[i].householdSeq+'" value="'+Commas(list[i].feeList[0].waterBill)+'"readonly>'+ '</td>'
																   	+'<td>'+ '<input type="text" class="form-control fee'+list[i].householdSeq+'" value="'+Commas(list[i].feeList[0].electricityBill)+'"readonly>'+ '</td>'
																   	+'<td id="modFeeTd'+list[i].householdSeq+'">'+ '<button name="living'+list[i].feeList[0].ho+'" id="modFee'+list[i].householdSeq+'" class="d-none d-sm-inline-block btn btn-sm btn-success shadow-sm modFeeBtn">'
																   	+'관리비조정'+ '</button>'
																   	+ '</td>' 
																   	+'<td  id="modFeeSaveTd'+list[i].householdSeq+'" hidden>'+ '<button id="modFeeSave'+list[i].householdSeq+'" class="d-none d-sm-inline-block btn btn-sm btn-danger shadow-sm modFeeBtnSave" data-toggle="modal" data-target="#UpdateCheck">'
																   	+'저장'+ '</button>'
																   	+ '</td>' 
																 +'</tr>');
							
								$(".fee"+list[i].householdSeq).css("width","110px")
								   .css("text-align", "center")
								   .css("display", "block")
								   .css("margin","0 auto");
							
					} 
			 		$(".dongtd").attr('rowspan',i+1);
			 		
			 		
					$(".modFeeBtn").on("click", function() {
						var ho = $(this).attr("name").replace(/[^0-9]/g,'');
						var householdSeq = $(this).attr("id").replace(/[^0-9]/g,'');
						$(".fee"+householdSeq).attr("readonly", false);
						$("#modFeeTd"+householdSeq).attr("hidden", true);
						$("#modFeeSaveTd"+householdSeq).attr("hidden", false);
						
						
					$("#modFeeSave"+householdSeq).on("click", function() {
						$("#feeUpdateContent").html($("#selectDong option:selected").val() +"동 " + ho + "호의 관리비 내역을 수정합니다.");
						$("#save").on("click", function () {
							
						$(".fee"+householdSeq).attr("readonly", true);
						$("#modFeeTd"+householdSeq).attr("hidden", false);
						$("#modFeeSaveTd"+householdSeq).attr("hidden", true);	
							
						
							
							var feeItem = $(".fee"+householdSeq);
								var fee = {
									generalBill : feeItem.eq(0).val(),
									securityBill : feeItem.eq(1).val(),
									cleaningBill : feeItem.eq(2).val(),
									fumigationBill : feeItem.eq(3).val(),
									elevatorBill : feeItem.eq(4).val(),
									electricityBill : feeItem.eq(5).val(),
									waterBill : feeItem.eq(6).val(),
									householdSeq : householdSeq,
									levySeq : list[0].feeList[0].levySeq
							};
							
								feeService.updateFee(fee, function() {
								}); 
								$("#UpdateCheck").modal("hide");
								$("#feeUpdateContent").html('');
						});
						
						});
						
					});
						
			});
			
			});
			
		
		
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