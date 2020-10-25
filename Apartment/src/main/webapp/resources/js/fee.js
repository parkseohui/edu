console.log("$Fee module$");



var feeService = (function() {
	
	
	function addLevy(levy, callback, error) {
		
		$.ajax({
			type : 'post',
			url : '/keeper/addLevy',
			data : JSON.stringify(levy),
			contentType : "application/json; charset=utf-8",
			success : function(result, status, xhr) {
				if(callback){
					callback(result);
				}
			},
			error : function(xhr, status, er) {
				if(error){
					error(er);
				}
			}
		});
		
	}
	
	
	function listLevy(callback, error) {
		

		
		$.getJSON("/keeper/listLevy",
				function(data) {
					if(callback){
						callback(data);
					}
				}).fail(function(xhr, status, err) {
					if(error){
						error();
					}
				});
	}
	
	
	function listDong(callback, error) {
		
		
		$.getJSON("/keeper/listDong",
				function(data) {
					if(callback){
						callback(data);
					}
				}).fail(function(xhr, status, err) {
					if(error){
						error();
					}
				});
	}
	
	
	function listFeeReg(feeRef, callback, error) {
		
		var levyDate = feeRef.levyDate;
		var dong = feeRef.dong;
		
		$.getJSON("/keeper/listFeeReg/" + dong + ".json",
				function(data) {
					if(callback){
						callback(data);
					}
				}).fail(function(xhr, status, err) {
					if(error){
						error();
					}
				});
	}
	
	
	function getUnitPrice(unitPriceSeq, callback, error) {
		
		$.getJSON("/keeper/getUnitPrice/" + unitPriceSeq + ".json", 
				function(data) {
					if(callback){
						callback(data);
					}
				}).fail(function(xhr, status, err) {
					if(error){
						error();
					}
				});
	}
	
	
	function updateUnitPrice(unitPrice, callback, error) {
		
		$.ajax({
			type : 'put',
			url : '/keeper/updateUnitPrice/' + unitPrice.unitPriceSeq,
			data : JSON.stringify(unitPrice),
			contentType : "application/json; charset=utf-8",
			success : function(result, status, xhr) {
				if(callback){
					callback(result);
				}
			},
			error : function(xhr, status, er) {
				if(error){
					error();
				}
			}
		});
	}
	
	
	function findUnitPriceSeq(unitPriceSeq, callback, error) {
		
		$.getJSON("/keeper/findUnitPriceSeq/" + unitPriceSeq + ".json", 
				function(data) {
					if(callback){
						callback(data);
					}
				}).fail(function(xhr, status, err) {
					if(error){
						error();
					}
				});
	}
	
	
	function addMeter(meter, callback, error) {
		
		$.ajax({
			type : 'post',
			url : '/keeper/addMeter',
			data : JSON.stringify(meter),
			contentType : "application/json; charset=utf-8",
			success : function(result, status, xhr) {
				if(callback){
					callback(result);
				}
			},
			error : function(xhr, status, er) {
				if(error){
					error(er);
				}
			}
		});
		
	}
	
	
	
	function updateMeter(meter, callback, error) {
		
		$.ajax({
			type : 'put',
			url : '/keeper/updateMeter/' + meter.householdSeq,
			data : JSON.stringify(meter),
			contentType : "application/json; charset=utf-8",
			success : function(result, status, xhr) {
				if(callback){
					callback(result);
				}
			},
			error : function(xhr, status, er) {
				if(error){
					error();
				}
			}
		});
	}
	
	
	
	
//	function insertFee(fee, callback, error) {
//		console.log("insert fee.....");
//		
//		$.ajax({
//			type : "post",
//			url : "/keeper/insertFee",
//			data : JSON.stringify(fee),
//			contentType : "application/json; charset=utf-8",
//			success : function(result, status, xhr) {
//			if (callback) {
//				callback(result);
//				alert("입력에 성공하셨습니다.");
//				location.reload();
//			} else {
//				alert("잠시후 다시 시도해주세요.");
//			}
//		},
//		error : function(xhr, status, er) {
//			if(error){
//				error(er);
//			}
//		}
//	  });
//	}
	
	
	
	return {
		addLevy : addLevy,
		listLevy : listLevy,
		listDong : listDong,
		listFeeReg : listFeeReg,
		getUnitPrice :  getUnitPrice,
		updateUnitPrice : updateUnitPrice,
		findUnitPriceSeq : findUnitPriceSeq,
		addMeter : addMeter,
		updateMeter : updateMeter
	};
})();