<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>
Apartment</title>
<link href="/resources/css/styles.css" rel="stylesheet" />
<link href="/resources/css/createApt.css" rel="stylesheet" />
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.11.2/js/all.min.js"
	crossorigin="anonymous"></script>
</head>
<main>
<nav class="navbar navbar-expand-lg navbar-light bg-light">
	<a class="navbar-brand" href="/Aptogether/">
Apartment</a>
	<button class="navbar-toggler" type="button" data-toggle="collapse"
		data-target="#navbarSupportedContent"
		aria-controls="navbarSupportedContent" aria-expanded="false"
		aria-label="Toggle navigation">
		<span class="navbar-toggler-icon"></span>
	</button>

	<div class="collapse navbar-collapse" id="navbarSupportedContent">
		<ul class="navbar-nav mr-auto">
		</ul>
		<a class="btn btn-outline-dark my-2 my-sm-0"
			href="/">메인으로 가기</a>
	</div>
</nav>
<div class="container-fluid" style="padding-top: 20px;">
	<ol class="breadcrumb mb-4">
		<li class="breadcrumb-item active">반갑습니다 아파트 등록 페이지입니다</li>
	</ol>
	<div class="row">
		<div class="col-xl-6">
			<div class="card mb-4">
				<div class="card-header">
					<i class="fas fa-chart-area mr-1"></i>아파트 등록
				</div>
				<div>
					<input type="text" id="sample3_postcode" placeholder="우편번호">
					<input type="button" onclick="sample3_execDaumPostcode()"
						value="우편번호 찾기"><br> <input type="text"
						id="sample3_address" placeholder="주소"><br> <input
						type="text" id="sample3_detailAddress" placeholder="상세주소">
					<input type="text" id="sample3_extraAddress" placeholder="참고항목">

					<div id="wrap"
						style="display: none; border: 1px solid; width: 500px; height: 300px; margin: 5px 0; position: relative">
						<img src="//t1.daumcdn.net/postcode/resource/images/close.png"
							id="btnFoldWrap"
							style="cursor: pointer; position: absolute; right: 0px; top: -1px; z-index: 1"
							onclick="foldDaumPostcode()" alt="접기 버튼">
					</div>
				</div>
			</div>
		</div>
		<div class="col-xl-6">
			<div class="card mb-4">
				<div class="card-header">
					<i class="fas fa-chart-bar mr-1"></i>법정동 코드를 기준으로 검색한 아파트 목록
				</div>
				<div class="apt-list"></div>

			</div>
		</div>

		<div class="modal">
			<div class="modal-content col-xl-6">
				<div class="apt-name"></div>
				<div class="apt-address"></div>
				<div class="apt-lat"></div>
				<div class="apt-long"></div>
				<input type="button" onclick="doAction()" value="저장하기 " /> <input
					type="button" onclick="closeModal()" value="닫기 ">
			</div>
		</div>
	</div>



	<script src="https://code.jquery.com/jquery-3.4.1.min.js"
		crossorigin="anonymous"></script>
	<script type="text/javascript">
		let bjdCode = "";
		let aptName = "";
		let kaptCode = "";
		let x = "";
		let y = "";
		let aptLocation = "";
		function doAction() {
			var tmpJson = {
				"kaptCode" : kaptCode,
				"aptName" : aptName,
				"location" : aptLocation,
				"x" : x,
				"y" : y
			};
			tmpJson = JSON.stringify(tmpJson);
			$.ajax({
				url : "/apt/aptInsert",
				type : "POST",
				dataType : "json",
				contentType: "application/json",
				data : tmpJson,
				success : function(data) {
					console.log(data);
					if (data.status == "true") {
						alert("입력에 성공하셨습니다.");
					} else if(data.status = "exist"){
						alert("이미 등록 된 아파트입니다.");
					} else{
						alert("잠시후 다시 시도해주세요.");
					}
				},
				error : function(request, status, error) {
					console.log(request, status, error);
					alert("요청에 실패하였습니다. 조금 있다 다시 요청해주세요.")
				}
			})
		}
		function apt_select_click(aptCode) {
			aptName = "";
			kaptCode = "";
			x = "";
			y = "";
			aptLocation = "";
			$('.modal').toggle();
			$.ajax({
				url : "/apt/aptdetail/" + aptCode,
				type : "GET",
				dataType : "text",
				success : function(data) {
					console.log(data);
					let json = JSON.parse(data);
					kaptCode = aptCode;
					aptName = json.aptDetailInfo.aptName;
					aptLocation = json.aptDetailInfo.doroJuso;

					$('.apt-name').html(json.aptDetailInfo.aptName);
					$('.apt-address').html(json.aptDetailInfo.doroJuso);
					$.ajax({
						url : '/apt/location/' + aptLocation,
						type : "GET",
						dataType : "text",
						success : function(data) {
							console.log(data);
							let locationJson = JSON.parse(data);
							$('.apt-long').html(locationJson.documents[0].x);
							$('.apt-lat').html(locationJson.documents[0].y);
							x = locationJson.documents[0].x;
							y = locationJson.documents[0].y;
						},
						error : function(data) {
							$('.apt-long').html("좌표정보 획득에 실패하였습니다.");
						}
					})
				},
				error : function(request, status, error) {
					console.log(error);
					console.log(status);
					console.log("error");
				}
			});
		}
		function closeModal() {
			$('.modal').toggle();
		}
	</script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.bundle.min.js"
		crossorigin="anonymous"></script>
	<script src="js/scripts.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js"
		crossorigin="anonymous"></script>
	<script
		src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>
		// 우편번호 찾기 찾기 화면을 넣을 element
		var element_wrap = document.getElementById('wrap');

		function foldDaumPostcode() {
			// iframe을 넣은 element를 안보이게 한다.
			element_wrap.style.display = 'none';
		}

		function sample3_execDaumPostcode() {
			// 현재 scroll 위치를 저장해놓는다.
			var currentScroll = Math.max(document.body.scrollTop,
					document.documentElement.scrollTop);
			new daum.Postcode(
					{
						oncomplete : function(data) {
							// 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

							// 각 주소의 노출 규칙에 따라 주소를 조합한다.
							// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
							var addr = ''; // 주소 변수
							var extraAddr = ''; // 참고항목 변수
							console.log(data.bcode, data.bname, data.bname1,
									data.bname2);
							bjdCode = data.bcode;
							console.log(bjdCode);
							$.ajax({
										url : "/apt/showAptList/" + bjdCode,
										type : "GET",
										success : function(bjd) {
											console.log(bjd);
											let json = bjd;
											console.log(json);
											
											$('.apt-list').html("");
											for ( var prop in json.aptInfo) {
												console.log(json.aptInfo[prop]);
												$('.apt-list')
														.append(
																'<div class="apt-list-detail">'
																		+ json.aptInfo[prop].aptName
																		+ '('
																		+ json.aptInfo[prop].kaptcode
																		+ ')'
																		+ '<input type="button" id="button1" onclick="apt_select_click('
																		+ "'"
																		+ json.aptInfo[prop].kaptcode
																		+ "'"
																		+ ')" value="선택" />'
																		+ '<div>')
											}

										},

										error : function(request, status, error) {
											console.log(error);
											alert("에러가 발생했습니다. 다시한번 시도해주세요.");
											console.log(status);
											console.log("error");
										}

									});

							//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
							if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
								addr = data.roadAddress;
							} else { // 사용자가 지번 주소를 선택했을 경우(J)
								addr = data.jibunAddress;
							}

							// 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
							if (data.userSelectedType === 'R') {
								// 법정동명이 있을 경우 추가한다. (법정리는 제외)
								// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
								if (data.bname !== ''
										&& /[동|로|가]$/g.test(data.bname)) {
									extraAddr += data.bname;
								}
								// 건물명이 있고, 공동주택일 경우 추가한다.
								if (data.buildingName !== ''
										&& data.apartment === 'Y') {
									extraAddr += (extraAddr !== '' ? ', '
											+ data.buildingName
											: data.buildingName);
								}
								// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
								if (extraAddr !== '') {
									extraAddr = ' (' + extraAddr + ')';
								}
								// 조합된 참고항목을 해당 필드에 넣는다.
								document.getElementById("sample3_extraAddress").value = extraAddr;

							} else {
								document.getElementById("sample3_extraAddress").value = '';
							}

							// 우편번호와 주소 정보를 해당 필드에 넣는다.
							document.getElementById('sample3_postcode').value = data.zonecode;
							document.getElementById("sample3_address").value = addr;
							// 커서를 상세주소 필드로 이동한다.
							document.getElementById("sample3_detailAddress")
									.focus();

							// iframe을 넣은 element를 안보이게 한다.
							// (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
							element_wrap.style.display = 'none';

							// 우편번호 찾기 화면이 보이기 이전으로 scroll 위치를 되돌린다.
							document.body.scrollTop = currentScroll;
						},
						// 우편번호 찾기 화면 크기가 조정되었을때 실행할 코드를 작성하는 부분. iframe을 넣은 element의 높이값을 조정한다.
						onresize : function(size) {
							element_wrap.style.height = size.height + 'px';
						},
						width : '100%',
						height : '100%'
					}).embed(element_wrap);

			// iframe을 넣은 element를 보이게 한다.
			element_wrap.style.display = 'block';
		}
	</script>
	</body>
</html>
