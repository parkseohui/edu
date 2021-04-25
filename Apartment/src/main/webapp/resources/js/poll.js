
	var i = 1;
	var selected = -1;
	var checked = false;
	var listUrl = null;
	var template = "option_modal";
	var dd = "pollChart";
	var cvs = document.getElementById("chartCanvas");
	var ctx = cvs.getContext("2d");
	var chartCanvas;
	var fn = "showData";
	
	$("[data-action]").on("click", function(){
		 if($(this).data("action")=="1"){
			 listUrl = "/tenant/pollOnList";
			 template = "option_modal";
			 fn = "showData";
			 console.log(listUrl);
		 }else if($(this).data("action")=="2"){
			 listUrl = "/tenant/pollEndList";
			 template = "pollChart_modal";
			 fn = "showData2";
			 console.log(listUrl);
		 }
		 
		 $.ajax({
			 	url: listUrl,
				type: "GET",
				dataType: "json",
				success: function(data) {
					$('.pollList').html("");
					for(let i =0; i < data.length; i++){
						var time = moment(data[i].endDate).format('LL');
						$('.pollList').append(
									 '<div class="card custom-bg mb-4 margin-auto max-width-card"'
									 +	'data-toggle="modal" data-target="#'
									 + template
									 +	'" onclick="'
									 + fn	
									 + '('
									 + data[i].pollSeq
									 + ', &quot;'
									 + data[i].question
									 + '&quot;, &quot;'
									 + data[i].contents
									 + '&quot;)">'
									 +'<div class="card-header custom-header-bg text-white"><h5 class="card-title">'
									 + data[i].question
									 +	'</h5></div><div class="card-body bg-white"><p class="small text-dark">'
									 + data[i].contents
									 +	'</p></div>'
									 +	'<div class="card-footer custom-bg small text-white text-end">'
									 +	'<img id="poll_hitcount">'
									 +'<span class="margin-left-span"> ' 
									 +  time
									 +' 마감 </span></div></div>'
							)
					}
				}
		 })
	 })

	function add() {
		$('.option_input')
				.append(
						'<div id="input' + i + '" class = "intputs input-group margin-bottom-button" ><div class="input-group-prepend"><span class="input-group-text">항목</span></div><input id="options" type="text" class="form-control" name="options"><button type="button" class="btn btn-outline-dark" onclick="del('
								+ i
								+ ')" id="create_form"> <span aria-hidden="true">Del</span> </button></div>');
		i++;
	}

	function del(el) {
		$("#input" + el).remove();
	}

	function deloption() {
		$('.off').on('click', function() {
			$('.intputs').remove();
		})
	}

	$('#selectClose').click(function(){
		location.reload();
	})
	
	function imgName(fileName){
		console.log(fileName.substring(2, fileName.length));
		fileName = fileName.substring(2, fileName.length);
		console.log( '/keeper/pollSignBigPicture?fileName=' + fileName);
		$('.bigPicture').attr('src', '/keeper/pollSignBigPicture?fileName=' + fileName);
		console.log(fileName);
	}
	
	function showData(pollSeq,question,contents) {
		$('#myModalLabel').html(question);
		$('#myModalContents').html(contents);
		$('.option_modal_body').html("");
		
		$.ajax({
			url: "/tenant/pollOptionList",
			type: "POST",
			dataType: "json",
			contentType: "application/json",
			data: JSON.stringify({
				"pollSeq" : pollSeq
			}) ,
			success: function(data) {
				for(let i =0; i < data.length; i++){
					console.log(data[i]);
					$('.option_modal_body').append(
					 '<div class="input-group"><div class="input-group-prepend">'
					 +'<div class="input-group-text">'
					 +'<input type="hidden" class="pollSeq" value="'
					 + pollSeq
					 +'">'
					 +'<input type="radio" name="seq" value="'
					 + data[i].optionSeq
					 +'" aria-label="Radio button for following text input">'
					 +'</div>'
					 +'</div>'
					 +'<input type="text" class="form-control"  aria-label="Text input with radio button" value="'
					 + data[i].optionText + '"readonly>'
					 +'</div>'
						)
					}
				}
			})
		}
	
	
	function showData2(pollSeq,question,contents) {
		$('#myModalLabel').html(question);
		$('#myModalContents').html(contents);
		$('.option_modal_body').html("");
		 
			$.ajax({
				url: "/tenant/pollChart",
				type: "POST",
				dataType: "json",
				contentType: "application/json",
				data: JSON.stringify({
					"pollSeq" : pollSeq
				}) ,
				success: function(data) {
					var text = [];
					var cnt = [];
					
					for (let j = 0; j < data.length; j++) {
						console.log(data[j]);
						console.log(data[j].optionText);
						console.log(data[j].cnt);
						
						text[j] = data[j].optionText;
						cnt[j] = data[j].cnt;
						
					}
							chartCanvas = new Chart(ctx, {
							type: 'horizontalBar',
							data: {
						        labels: text,
						        datasets: [{
						            label: '투표결과',
						            data: cnt,
						            backgroundColor: [
						                'rgba(255, 99, 132, 0.2)',
						                'rgba(54, 162, 235, 0.2)',
						                'rgba(255, 206, 86, 0.2)',
						                'rgba(75, 192, 192, 0.2)',
						                'rgba(153, 102, 255, 0.2)',
						                'rgba(255, 159, 64, 0.2)'
						            ],
						            borderColor: [
						                'rgba(255,99,132,1)',
						                'rgba(54, 162, 235, 1)',
						                'rgba(255, 206, 86, 1)',
						                'rgba(75, 192, 192, 1)',
						                'rgba(153, 102, 255, 1)',
						                'rgba(255, 159, 64, 1)'
						            ],
						            borderWidth: 1
						        }]
						    },
						    options: {
						        maintainAspectRatio: true,
						        scales: {
						        	xAxes: [{
						        		ticks:{
						        			min:0,
						        			stepSize:1
						        		}
						        	}],
						            yAxes: [{
						                ticks: {
						                    beginAtZero:true
						                }
						            }]
						        }
						    }
						});
					}
				})
			}

		
	
	function selectOption() {
			selected = $('.input-group input:radio[name=seq]:checked').val();
			pollSeq = $('.pollSeq').attr('value');
			console.log(selected);
			console.log(pollSeq);
				if(!selected){
					$('.alert').show();
				}else{
					$('.alert').alert('close');
						$('#option_modal').modal('hide');
					$('.alert').toggle();
//					resizeCanvas();
					$('#sign_modal').modal('show');
				}
	}

	
	$('#pollChartClose').on('click', function() {
		chartCanvas.destroy();
	});