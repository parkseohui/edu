<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	
	<link href="https://cdn.datatables.net/1.10.20/css/dataTables.bootstrap4.min.css" rel="stylesheet" crossorigin="anonymous" />
	<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.11.2/js/all.min.js" crossorigin="anonymous"></script>
	<link href="/resources/css/index.css" rel="stylesheet">
	<link href="/resources/css/styles.css" rel="stylesheet" />

	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title> Main</title>

</head>
<style>
#dd{
float:right;
}
</style>
<body>  
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<a class="navbar-brand" href="/Aptogether/">
Apartment</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav mr-auto">
			</ul>
			<a class="btn btn-outline-dark my-2 my-sm-0" href="/createApt">아파트
				생성하기</a>
		</div>
	</nav>
	<div class="container-fluid main-section">
		<div class="container">
			<div class="row" style="float:right;">
			
			
			
<div class="row">
  <div class="col-sm-6">
    <div class="card">
      <div class="card-body">
        <h5 class="card-title">회원 가입하기</h5>
        <p class="card-text"></p>
        <a href="/keeper/signup" class="btn btn-primary">관리자</a>
        <a href="/tenant/signup" class="btn btn-primary">입주민</a>
      </div>
    </div>
  </div>
  <div class="col-sm-6">
    <div class="card">
      <div class="card-body">
        <h5 class="card-title">회원 로그인</h5>
        <p class="card-text"></p>
        <a href="/keeper/signin" class="btn btn-primary">관리자</a>
        <a href="/tenant/signin" class="btn btn-primary">입주민</a>
      </div>
    </div>
  </div>
</div>
			<!-- 	<div >
					<div class="user">회원 가입하기</div>
					<a href="/keeper/signup">관리자 </a>
					<a href="/tenant/signup">입주민 </a>
					</div>
					 -->
<!-- <div class="btn-group" role="group" aria-label="Basic example">
  <button type="button" class="btn btn-secondary" onclick="location.href='/keeper/signup'">관리자</button>
  <button type="button" class="btn btn-secondary" onclick="location.href='/tenant/signup'">입주민</button>
</div> -->
			
			
<!-- 			<form>
  <div class="form-group row">
    <label for="staticEmail" class="col-sm-2 col-form-label"></label>
    <div class="col-sm-15">
      <button type="button" class="btn btn-first" onclick="location.href='/keeper/signup'">회원가입</button>
    </div>
  </div>
  <div class="form-group row">
    <label for="inputPassword" class="col-sm-2 col-form-label"></label>
    <div class="col-sm-15">
      <div class="btn-group" role="group" aria-label="Basic example">
  <button type="button" class="btn btn-secondary" onclick="location.href='/keeper/signup'">관리자</button>
  <button type="button" class="btn btn-secondary" onclick="location.href='/tenant/signup'">입주민</button>
</div>
    </div>
  </div>
</form>	
				
<div class="btn-group" role="group" aria-label="Basic example" id="dd">
<h1>회원 로그인</h1>
  <button type="button" class="btn btn-secondary" onclick="location.href='/keeper/signin'">관리자</button>
  <button type="button" class="btn btn-secondary" onclick="location.href='/tenant/signin'">입주민</button>
</div> -->
				<!-- <div></div>
				<div >
					<div class="user">회원 로그인</div>
					<a href="/keeper/signin">관리자</a>
					<a href="/tenant/signin">입주민</a>
				</div> -->
				<!-- 	<div class="col-xl-5 select-box">
					<div class="user">입주민 회원이십니까?</div>
					
			</div> -->
		</div>
	</div>

<!-- 	<div id="layoutAuthentication_footer">
		<footer class="py-4 bg-light mt-auto">
			<div class="container-fluid">
				<div class="d-flex align-items-center justify-content-between small">
					<div class="text-muted"></div>
					<div>
						<a> 박서희 </a>
					</div>
				</div>
			</div>
		</footer>
	</div> -->
	<script src="https://code.jquery.com/jquery-3.4.1.min.js" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
</body>

</html>
