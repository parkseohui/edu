var eventModal = $('#eventModal');
var dong = $('#dong');
var modalTitle = $('.modal-title');
var editId = $('#edit-Id');
var editAllDay = $('#edit-allDay');
var editTitle = $('#edit-title');
var editDong = $('#edit-dong');
var editStart = $('#edit-start');
var editEnd = $('#edit-end');
var editType = $('#edit-type');
var editColor = $('#edit-color');
var editDesc = $('#edit-desc');
var editAptSeq = $('#edit-Apt-Seq');
var editType = $('#edit-type');
var editAuth = $('#edit-auth');
var realAuth = $('#edit-Autho');

var addBtnContainer = $('.modalBtnContainer-addEvent');
var modifyBtnContainer = $('.modalBtnContainer-modifyEvent');

/* ****************
 *  새로운 일정 생성
 * ************** */
var newEvent = function (start, end, eventType) {

    $("#contextMenu").hide(); //메뉴 숨김

    modalTitle.html('새로운 일정');
    editType.val(eventType).prop('selected', true);
    editTitle.val('');
    editDong.val('');
    editStart.val(start);
    editEnd.val(end);
    editDesc.val('');
    editAptSeq.val();
    editId.val();
    editAuth.val();
    dong.val();
    editType.val('등록');
    
    addBtnContainer.show();
    modifyBtnContainer.hide();
    eventModal.modal('show');

		
    //새로운 일정 저장버튼 클릭
    $('#save-event').unbind();
    $('#save-event').on('click', function () {
//    	console.log(editDong.val());
//    	console.log(editAptSeq.val());
//    	console.log(realAuth.val());
//    	console.log(editType.val());

        var eventData = {
                title : editTitle.val(),
            	contents : editDesc.val(),
            	dong : editDong.val(),
            	startDate : moment(editStart.val()).format('YYYY-MM-DD HH:mm'),
            	endDate : moment(editEnd.val()).format('YYYY-MM-DD HH:mm'),
            	aptSeq : editAptSeq.val(),
            	states: editType.val(),
                backgroundColor: editColor.val(),
        };
                
        if (eventData.start > eventData.end) {
            alert('끝나는 날짜가 앞설 수 없습니다.');
            return false;
        }

        if (eventData.title === '') {
            alert('일정명은 필수입니다.');
            return false;
        }

        var realEndDay;

        if (editAllDay.is(':checked')) {
            eventData.start = moment(eventData.start).format('YYYY-MM-DD HH:mm');
            eventData.end = moment(eventData.end).add(1, 'days').format('YYYY-MM-DD HH:mm');
            realEndDay = moment(eventData.end).format('YYYY-MM-DD HH:mm');

            eventData.allDay = true;
        }
        var tmp = {
 				"title": editTitle.val(),
 				"dong" : editDong.val(),
 				"contents":  editDesc.val(),
 				"startDate": moment(editStart.val()).format('YYYY-MM-DD HH:mm'),
 				"endDate": moment(editEnd.val()).format('YYYY-MM-DD HH:mm'),
 				"aptSeq":editAptSeq.val(),
 				"states": editType.val(),
 				"backgroundColor": editColor.val(),

 			};
        
        	$.ajax({
      			url: "/tenant/insertSchedule",
      			type: "post",
      			dataType: "json",
      			contentType: "application/json; charset=utf-8",
      			data: JSON.stringify(tmp),
      			  
      			success: function(data){      
      					 $('#calendar').fullCalendar('removeEvents');
      	                $('#calendar').fullCalendar('refetchEvents');
      	                console.log(data);
      				if(data.status == "true"){
      					
      					alert("관리자의 승인을 기다리는 중입니다.");
      					location.reload();

      				}else {
      					alert("잠시후 다시 시도해주세요.");
      				}
      			},
      			error: function(request, status, error) {
      				console.log(request, status, error);
      				alert("요청에 실패하였습니다. 조금 있다 다시 요청해주세요.")
      			}
      		}); 
        
		 
        $("#calendar").fullCalendar('renderEvent', eventData, true);
        eventModal.find('input, textarea').val('');
        editAllDay.prop('checked', false);
        eventModal.modal('hide');
        
    });
};