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
	
	
	function householdInfo(callback, error) {
		
		$.getJSON("/keeper/householdInfo",
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
	
	
	function levyInfo(levy, callback, error) {
		
		var aptSeq = levy.aptSeq
		var levyDate = levy.levyDate
		
		$.getJSON("/keeper/levyInfo/"+ aptSeq + "/" + levyDate + ".json", 
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
	
	
	function addFee(fee, callback, error) {
		
		$.ajax({
			type : 'post',
			url : '/keeper/addFee',
			data : JSON.stringify(fee),
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
		
		var levySeq = feeRef.levySeq;
		var dong = feeRef.dong;
		
		$.getJSON("/keeper/listFeeReg/" + levySeq +"/"+dong + ".json",
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
	
	
	function updateFee(fee, callback, error) {
		
		$.ajax({
			type : 'put',
			url : '/keeper/updateFee/',
			data : JSON.stringify(fee),
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
	
	
	
	return {
		addLevy : addLevy,
		listLevy : listLevy,
		householdInfo : householdInfo,
		levyInfo : levyInfo,
		addFee : addFee,
		listDong : listDong,
		listFeeReg : listFeeReg,
		updateFee : updateFee
	};
})();