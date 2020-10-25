<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
    <meta name="description" content="" />
    <meta name="author" content="" />

    <title>Aptogether - 세입자 회원가입</title>

    <!-- Custom fonts for this template-->
    <link
      href="/Aptogether/dist/vendor/fontawesome-free/css/all.min.css"
      rel="stylesheet"
      type="text/css"
    />
    <link
      href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
      rel="stylesheet"
    />

    <!-- Custom styles for this template-->
    <link href="/resources/css/sb-admin-2.css" rel="stylesheet" />
    <style type="text/css">
      .modal-mine {
        display: none;
        position: fixed;
        width: 100%;
        z-index: 9999;
        margin-top: 60px;
        left: 0;
      }

      .modal-content {
        margin: auto;
        padding: 30px 20px;
        box-sizing: border-box;
        overflow: scroll;
        height: 800px;
      }
      .margin-bottom {
        margin-bottom: 10px;
      }
      .margin-bottom-10 {
      	margin-bottom: 10px;
      }
      .margin-top-15px {
      	margin-top: 15px;
      	height:40px;
      	font-size: 22px;
      }
      .warning{
      	font-size: 22px;
      	color: red;
      }
    </style>
  </head>

  <body class="bg-gradient-primary">
    <div class="container">
      <div class="modal-mine">
        <div class="modal-content col-xl-6">
          <div class="input-group mb-3">
            <input
              type="text"
              id="modalAptName"
              class="form-control"
              placeholder="아파트 이름을 입력해주세요"
              aria-label="Recipient's username"
              aria-describedby="basic-addon2"
            />
            <div class="input-group-append">
              <button
                class="btn btn-outline-secondary"
                type="button"
                onclick="searchApt()"
              >
                아파트 검색하기
              </button>
            </div>
          </div>
          <div class="apt-list-box">
            <div class="list-group"></div>
          </div>
          <input type="button" class="margin-top-15px" onclick="doAction()" value="선택하기" />
          <input type="button" class="margin-top-15px" onclick="closeModal()" value="닫기 " />
        </div>
      </div>

      <div class="card o-hidden border-0 shadow-lg my-5">
        <div class="card-body p-0">
          <!-- Nested Row within Card Body -->
          <div class="row">
            <div class="col-lg-5 d-none d-lg-block bg-register-image"></div>
            <div class="col-lg-7">
              <div class="p-5">
                <div class="text-center">
                  <h1 class="h4 text-gray-900 mb-4">Aptogether - 회원가입</h1>
                </div>
                <form:form class="user" action="/tenant/signup" modelAttribute="JoinVO" method="post">
                  <div class="form-group row">
                    <div class="col-sm-6 mb-3 mb-sm-0">
                      <input
                        type="text"
                        name="name"
                        class="form-control form-control-user"
                        id="userName"
                        placeholder="이름"
                      />
                    </div>
                    <div class="col-sm-6">
                      <input
                        type="text"
                        class="form-control form-control-user"
                        name="aptName"
                        id="aptName"
                        placeholder="아파트 이름"
                        readonly
                      />
                      <input
                        type="hidden"
                        name="aptSeq"
                        id="aptSeq"
                        placeholder="seq"
                      />
                    </div>
                  </div>

                  <button
                    id="modal-toggle-button"
                    class="btn btn-google btn-user btn-block"
                  >
                    아파트 찾기
                  </button>

                  <div class="form-group">
                    <input
                      type="email"
                      class="form-control form-control-user"
                      id="email"
                      name="id"
                      placeholder="이메일 주소를 입력하세요"
                    />
                  </div>
                  <div class="form-group row">
                    <div class="col-sm-6 mb-3 mb-sm-0">
                      <input
                        type="password"
                        class="form-control form-control-user"
                        name="password"
                        id="password"
                        placeholder="비밀번호"
                      />
                    </div>
                    <div class="col-sm-6">
                      <input
                        type="password"
                        class="form-control form-control-user"
                        id="exampleRepeatPassword"
                        placeholder="비밀번호 확인"
                      />
                    </div>
                  </div>
                  <div class="form-group row resident">
                    <div class="col-sm-6 mb-3 mb-sm-0">
                      <input
                        type="number"
                        class="form-control form-control-user"
                        name="dong"
                        id="dong"
                        placeholder="동"
                      />
                    </div>
                    <div class="col-sm-6">
                      <input
                        type="number"
                        class="form-control form-control-user"
                        name="ho"
                        id="ho"
                        placeholder="호"
                      />
                    </div>
                  </div>

                  <hr />
                  <div>
                    <div class="custom-control custom-radio margin-bottom">
                      <input
                        type="hidden"
                        name="type"
                        value="tenant"
                        class="custom-control-input"
                        id="customCheck1"
                        checked="checked"
                      />
                    </div>
                  </div>
                  <input
                    type="submit"
                    class="btn btn-primary btn-user btn-block"
                    value="회원 가입하기"
                  />
                  <div class="warning">${status } </div>
                </form:form>
                <hr />
                <!--               <div class="text-center">
                <a class="small" href="forgot-password.html">Forgot Password?</a>
              </div> -->
                <div class="text-center">
                  <a class="small" href="/signin">로그인 하기</a>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- Bootstrap core JavaScript-->
    <script src="/resources/vendor/jquery/jquery.min.js"></script>
    <script src="/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="/Aptogether/vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="/js/sb-admin-2.min.js"></script>
    <script type="text/javascript">
      function selectApt(seq, name) {
        $("#aptName").val(name);
        $("#aptSeq").val(seq);
        closeModal();
      }

      function searchApt() {
    	  console.log(JSON.stringify({aptName: $("#modalAptName").val()}));
        $.ajax({
          url: "/apt/showAptList",
          type: "POST",
          dataType: "json",
          contentType: "application/json;charset=utf-8",
          data: JSON.stringify({aptName: $("#modalAptName").val()}),
          success: function (data) {
        	  console.log(data);
            $(".apt-list-box .list-group").html("");
            if(data.status == 'success') {
                for (var i = 0; i < data.aptList.length; i++) {
                    $(".apt-list-box .list-group").append(
                      '<button type="button" class="list-group-item list-group-item-action margin-bottom-10" onclick="selectApt(' +
                        data.aptList[i].aptSeq +
                        "," +
                        "'" +
                        data.aptList[i].aptName +
                        "'" +
                        ')"' +
                        ">" +
                        data.aptList[i].aptName +
                        "(" +
                        data.aptList[i].aptLocation +
                        ")" +
                        "</button>"
                    );
                  }
            } else if(data.status == 'no_value') {
            	$(".apt-list-box .list-group").html(
                        '<button type="button" class="list-group-item list-group-item-action margin-bottom-10" disabled>' +
						"아파트 목록이 없습니다 등록 부탁드립니다"
                          + "</button>")
            } else{
            	$(".apt-list-box .list-group").html(
                        '<button type="button" class="list-group-item list-group-item-action margin-bottom-10" disabled>' +
						"잘못된 값을 입력하셨거나 에러가 발생했습니다"
                          + "</button>")
            }

          },
        });
      }
      function closeModal() {
        $(".modal-mine").toggle();
      }
      $(function () {
    	$('input:radio').click(function () {
    		console.log($(this).val());
    		if($(this).val() == 'ROLE_KEEPER'){
    			$('.resident').hide();
    		}else {
    			$('.resident').show();
    		}
    	});
        console.log("conssole.");
        $("#modal-toggle-button").on("click", function () {
          $(".modal-mine").toggle();
          return false;
        });
      });
    </script>
  </body>
</html>
