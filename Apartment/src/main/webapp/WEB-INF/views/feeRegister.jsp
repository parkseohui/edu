<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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
					<div
						class="d-sm-flex align-items-center justify-content-between mb-4">
						<h1 class="h3 mb-0 text-gray-800">[APTOGETHER 관리비 부과]</h1>
					</div>
					

					<!-- Content Row -->
					<div class="row">
						<div class="container-fluid">
						<select class="custom-select" id="selectDong"></select>
						<strong><c:out value="${levyD}"/></strong>
						<p id="unitPriceSeq"></p>
						<div id="householdlist" hidden="hidden"></div>
						<button id="unitPrice" class="d-none d-sm-inline-block btn btn-sm btn-danger shadow-sm">
										단가조정</button>
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
									      <th scope="col" colspan="3">세대정보</th>
									      <th scope="col" colspan="7">요금항목</th>
									    </tr>
									    <tr>
									    <th scope="col">동</th>
									    <th scope="col">호</th>
									    <th scope="col">공급면적</th>
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
					
					<!-- 관리비 단가 조정 모달창 -->
					<div class="modal fade" id="calModal" tabindex="-1" role="dialog" aria-labelledby="calModalLabel" aria-hidden="true">
					  <div class="modal-dialog">
					    <div id="calJob1" class="modal-content">
					      <div class="modal-header">
					        <h5 class="modal-title" id="calModalLabel">관리비 단가조정</h5>
					        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
					          <span aria-hidden="true">&times;</span>
					        </button>
					      </div>
					      <div class="modal-body">
							<form>
								<div class="form-group row">
									<label for="generalPrice" class="col-sm-2 col-form-label">일반관리비</label>
									<div class="col-sm-10">
										<input type="text" class="form-control unitP" id="generalPrice">
									</div>
								</div>
								<div class="form-group row">
									<label for="securityPrice" class="col-sm-2 col-form-label">경비비</label>
									<div class="col-sm-10">
										<input type="text" class="form-control unitP" id="securityPrice">
									</div>
								</div>
								<div class="form-group row">
									<label for="cleaningPrice" class="col-sm-2 col-form-label">청소비</label>
									<div class="col-sm-10">
										<input type="text" class="form-control unitP" id="cleaningPrice">
									</div>
								</div>
								<div class="form-group row">
									<label for="fumigationPrice" class="col-sm-2 col-form-label">소독비</label>
									<div class="col-sm-10">
										<input type="text" class="form-control unitP" id="fumigationPrice">
									</div>
								</div>
								<div class="form-group row">
									<label for="elevatorPrice"
										class="col-sm-2 col-form-label">승강기유지비</label>
									<div class="col-sm-10">
										<input type="text" class="form-control unitP" id="elevatorPrice">
									</div>
								</div>
								<div class="form-group row">
									<label for="electricityPrice" class="col-sm-2 col-form-label">전기세</label>
									<div class="col-sm-10">
										<input type="text" class="form-control unitP" id="electricityPrice">
									</div>
								</div>
								<div class="form-group row">
									<label for="waterPrice" class="col-sm-2 col-form-label">수도세</label>
									<div class="col-sm-10">
										<input type="text" class="form-control unitP" id="waterPrice">
									</div>
								</div>
							</form> 
					      </div>
					      <div  class="modal-footer">
					      	<button type="button" id="ModJob" class="btn btn-danger">저장</button>
					      	<button type="button" id="unitPriceMod" class="btn btn-success">단가 수정</button>
					        <button type="button" id="unitPriceReg" class="btn btn-primary">다음</button>
					        <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
					      </div>
					    </div>
					  </div>
					</div>
					
					
					<!-- 개별사용관리비 검침 모달창 -->
					<div class="modal fade" id="meterModal" tabindex="-1" role="dialog" aria-labelledby="meterModalLabel" aria-hidden="true">
					  <div class="modal-dialog">
					    <div id="calJob2" class="modal-content">
					      <div class="modal-header">
					        <h5 class="modal-title" id="meterModalLabel">개별사용료 검침</h5>
					        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
					          <span aria-hidden="true">&times;</span>
					        </button>
					      </div>
					      <div class="modal-body">
							<table class="table">
								  <thead>
								    <tr>
								      <th scope="col">호</th>
								      <th scope="col">전기 사용량</th>
								      <th scope="col">수도 사용량</th>
								    </tr>
								  </thead>
								  <tbody id="meterTable">
								  </tbody>
							</table> 
					      </div>
					      <div  class="modal-footer">
					      	<button type="button" id="previousModal" class="btn btn-primary">이전</button>
					      	<button type="button" id="meterReadJob" class="btn btn-danger" hidden="hidden">저장</button>
					      	<button type="button" id="meterMod" class="btn btn-success">수정</button>
					        <button type="button" id="meterReg" class="btn btn-primary">요금계산</button>
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
			console.log(feeService);
		
			function Commas(val){
			    return val.toString().replace(/\B(?=(\d{3})+(?!\d))/g,",");
			}
			
			
			feeService.findUnitPriceSeq("<c:out value="${levyD}"/>", function(data) {
				var unitPriceSeq = data.unitPriceSeq;
				$("#unitPriceSeq").html(unitPriceSeq).attr("hidden", true);
				console.log("단가번호 : " +  unitPriceSeq);
			});
		
			
			feeService.listDong(function(list) {
					
					for(var i = 0, len = list.length||0; i <len; i++){
						$("#selectDong").append('<option value="'+list[i].dong+'">'+list[i].dong+' 동'+'</option>');
					} 
					
					$.getJSON("/keeper/listFeeReg/"+ list[0].dong + ".json",
						function(data) {
						console.log(data);
							$("#feeTable").append('<tr>' +'<td class="dongtd" style="vertical-align: middle;">'+  $("#selectDong option:selected").val() + '</td>' + '</tr>');
						 		for(var i = 0, len = data.length||0; i <len; i++){
 										$("#feeTable").append('<tr>'
											   									+'<td>'+ data[i].feeList[0].ho+ '</td>'
											   									+'<td>'+ data[i].feeList[0].roomSize+ 'm²'+ '</td>'
 																			   	+'<td>'+ Commas(data[i].feeList[0].generalBill) + '</td>'
																			   	+'<td>'+ Commas(data[i].feeList[0].securityBill)+ '</td>'
																			   	+'<td>'+ Commas(data[i].feeList[0].cleaningBill)+ '</td>'
																			   	+'<td>'+ Commas(data[i].feeList[0].fumigationBill)+ '</td>'
																			   	+'<td>'+ Commas(data[i].feeList[0].elevatorBill)+ '</td>'
																			   	+'<td>'+ Commas(data[i].feeList[0].electricityBill)+ '</td>'
																			   	+'<td>'+ Commas(data[i].feeList[0].waterBill)+ '</td>' 
																			  +'</tr>');
 										
 										
 										
 										$("#meterTable").append('<tr>'
 											   	+'<td id="householdHo' + i +'">'+ data[i].feeList[0].ho+ '</td>'
 											   	+'<td>'+ '<input type="text" class="form-control meter" id="electricMeter' + i +'">'+ '</td>'
 											   	+'<td>'+ '<input type="text" class="form-control meter" id="waterMeter' + i +'">'+ '</td>'
 											   	+'<td id="householdSeq' + i +'" hidden>'+ data[i].householdSeq + '</td>'
 											 +'</tr>'); 
 										
 										
  										
	  	  									 									
 											$("#meterReg").on("click", function () {
 												
   	  										var meter = {
	  	  												unitPriceSeq : parseInt($("#unitPriceSeq").html()),
	  	  												householdSeq : parseInt($('#householdSeq'+i).html()),
	  	  												electricMeter : parseInt($('#electricMeter'+i).val()),
	  	  												waterMeter : parseInt($('#waterMeter'+i).val()),
	  	  										};
   	  										
											console.log(meter);
	
 												
/* 	   											feeService.addMeter(meter, function(result) {
	   												alert("관리비 요금계산이 완료되었습니다.");
	  	  										});   */
											});
								} 
						 		 $(".dongtd").attr('rowspan',i+1); 
								
							}).fail(function(xhr, status, err) {
								if(error){
									error();
								}
							});
				}); 
			
			

			$("#selectDong").on("change", function() {
				
				var thisLevyDate = "<c:out value="${levyD}"/>";
				var selectedDong = $("#selectDong option:selected").val();
				console.log(thisLevyDate);
				
			 	feeService.listFeeReg({dong : selectedDong},
			 			function(list) {
			 		console.log(list);
			 		$("#feeTable").html('');
			 		$("#meterTable").empty();
			 		$("#feeTable").append('<tr>'
						   	+'<td class="dongtd" style="vertical-align: middle;">'+ selectedDong + '</td>' + '</tr>');
			 		for(var i = 0, len = list.length||0; i <len; i++){
							$("#feeTable").append('<tr>'
																   	+'<td>'+ list[i].feeList[0].ho+ '</td>'
																   	+'<td>'+ list[i].feeList[0].roomSize+'m²'+ '</td>'
																   	+'<td>'+ Commas(list[i].feeList[0].generalBill)+ '</td>'
																   	+'<td>'+ Commas(list[i].feeList[0].securityBill)+ '</td>'
																   	+'<td>'+ Commas(list[i].feeList[0].cleaningBill)+ '</td>'
																   	+'<td>'+ Commas(list[i].feeList[0].fumigationBill)+ '</td>'
																   	+'<td>'+ Commas(list[i].feeList[0].elevatorBill)+ '</td>'
																   	+'<td>'+ Commas(list[i].feeList[0].electricityBill)+ '</td>'
																   	+'<td>'+ Commas(list[i].feeList[0].waterBill)+ '</td>'
																 +'</tr>');
							
							
								
								$("#meterTable").append('<tr>'
									   	+'<td id="householdHo' + i +'">'+ list[i].feeList[0].ho+ '</td>'
									   	+'<td>'+ '<input type="text" class="form-control meter" id="electricMeter' + i +'">'+ '</td>'
									   	+'<td>'+ '<input type="text" class="form-control meter" id="waterMeter' + i +'">'+ '</td>'
									 +'</tr>'); 
								
								

								
/* 								$("#householdlist").append('<p id="getHousehold' + i +'">'+list[i].householdSeq+'</p>'); */
									
/*   								$('#electricMeter'+i).val(meter.electricMeter);
								$('#waterMeter'+i).val(meter.waterMeter); */
								
/* 										$("#meterReg").on("click", function () {
											
											var meter = {
													unitPriceSeq : parseInt($("#unitPriceSeq").html()),
													householdSeq : list[i].householdSeq,
													electricMeter : $('#electricMeter'+i).val(),
													waterMeter : $('#waterMeter'+i).val(),
											};
											console.log(meter); 
												
   											feeService.addMeter(meter, function(result) {
   												alert("관리비 요금계산이 완료되었습니다.");
  	  										});  
										}); */
								
								

					} 
			 		$(".dongtd").attr('rowspan',i+1);
						}) ;
			});
			
			

			
			$("#unitPrice").on("click", function() {
				$("#calModal").modal('show');
	 			$(".unitP").attr("readonly", true);
				
	 			var unitPriceSeq = $("#unitPriceSeq").html();
	 			
	 			feeService.getUnitPrice(unitPriceSeq, function(data) {
	 				$("#generalPrice").val(data.generalPrice);
	 				$("#securityPrice").val(data.securityPrice);
	 				$("#cleaningPrice").val(data.cleaningPrice);
	 				$("#fumigationPrice").val(data.fumigationPrice);
	 				$("#elevatorPrice").val(data.elevatorPrice);
	 				$("#electricityPrice").val(data.electricityPrice);
	 				$("#waterPrice").val(data.waterPrice);
				}); 
	 			
				$("#ModJob").attr("hidden", true);
				$("#unitPriceMod").attr("hidden", false);
			});
			
			$("#unitPriceMod").on("click", function() {
				$(this).attr("hidden", true);
				$("#ModJob").attr("hidden", false);
				$(".unitP").attr("readonly", false);
			});
			
			$("#ModJob").on("click", function() {
				$(this).attr("hidden", true);
				$("#unitPriceMod").attr("hidden", false);
				$(".unitP").attr("readonly", true);
				
				var unitPriceSeq = $("#unitPriceSeq").html();
				
				var updateInfo = {
						unitPriceSeq : unitPriceSeq,
						generalPrice : $("#generalPrice").val(),
						securityPrice : $("#securityPrice").val(),
						cleaningPrice : $("#cleaningPrice").val(),
						fumigationPrice : $("#fumigationPrice").val(),
						elevatorPrice : $("#elevatorPrice").val(),
						electricityPrice : $("#electricityPrice").val(),
						waterPrice : $("#waterPrice").val()
				};
				
				feeService.updateUnitPrice(updateInfo, function (data) {
					console.log(data);
				});
			});
			
			$("#unitPriceReg").on("click", function() {
				$("#calModal").modal('hide');
				$("#meterModal").modal('show');
				
				
			});
			
			$("#previousModal").on("click", function() {
				$("#meterModal").modal('hide');
				$("#calModal").modal('show');
			});
			
			
			
			
 			$("#meterReadJob").on("click", function() {
				for(var i = 0, len = updateM.length||0; i <len; i++){
					
					var meter = {
							electricMeter : $('#electricMeter'+i).val(),
							waterMeter : $('#waterMeter'+i).val(),
							householdSeq : $('#getHousehold'+i).html()
					};
					
				feeService.updateMeter(meter, function(updateM) {
						
					});
					
				
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
