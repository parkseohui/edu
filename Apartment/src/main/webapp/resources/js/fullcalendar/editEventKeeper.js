/* ***************
 *  일정 편집            *
 * ************** */

var editEvent = function(event, element, view) {

	$('#deleteEvent').data('id', event._id); // 클릭한 이벤트 ID

	$('.popover.fade.top').remove();
	$(element).popover("hide");

	if (event.allDay === true) {
		editAllDay.prop('checked', true);
	} else {
		editAllDay.prop('checked', false);
	}

	if (event.end === null) {
		event.end = event.start;
	}

	if (event.allDay === true && event.end !== event.start) {
		editEnd.val(moment(event.end).subtract(1, 'days').format('YYYY-MM-DD HH:mm'))
	} else {
		editEnd.val(event.end.format('YYYY-MM-DD HH:mm'));
	}

	modalTitle.html('일정 수정');
	editId.val(event._id);
	editTitle.val(event.title);
	editDong.val(event.dong);
	editStart.val(moment(event.start).format('YYYY-MM-DD HH:mm'));
	editEnd.val(moment(event.end).format('YYYY-MM-DD HH:mm'));
	editType.val(event.states);
	editDesc.val(event.contents);
	editColor.val(event.backgroundColor).css('color', event.backgroundColor);
	editAptSeq.val(event.apt_seq);
	editAuth.val(event.authority);

	addBtnContainer.hide();
	modifyBtnContainer.show();
	eventModal.modal('show');

	// 업데이트 버튼 클릭시
	$('#updateEvent').unbind();
	$('#updateEvent').on('click',function() {

						if (editStart.val() > editEnd.val()) {
							alert('끝나는 날짜가 앞설 수 없습니다.');
							return false;
						}

						if (editTitle.val() === '') {
							alert('일정명은 필수입니다.')
							return false;
						}

						var statusAllDay;
						var startDate;
						var endDate;
						var displayDate;

						if (editAllDay.is(':checked')) {
							statusAllDay = true;
							startDate = moment(editStart.val()).format('YYYY-MM-DD');
							endDate = moment(editEnd.val()).format('YYYY-MM-DD');
							displayDate = moment(editEnd.val()).add(1, 'days').format('YYYY-MM-DD');
						} else {
							statusAllDay = false;
							startDate = moment(editStart.val()).format('YYYY-MM-DD');
							endDate = moment(editEnd.val()).format('YYYY-MM-DD');
							displayDate = endDate;
						}

						eventModal.modal('hide');

						event.allDay = statusAllDay;
						event.title = editTitle.val();
						event.dong = editDong.val();
						event.start = startDate;
						event.end = displayDate;
						event.states = editType.val();
						event.backgroundColor = editColor.val();
						event.contents = editDesc.val();
						event.apt_seq = editAptSeq.val();

						$("#calendar").fullCalendar('updateEvent', event);

						var scheduleSeq = editId.val();
						var authority = editAuth.val();

						var updateData = {
							"title" : editTitle.val(),
							"dong" : editDong.val(),
							"contents" : editDesc.val(),
							"startDate" : moment(editStart.val()).format('YYYY-MM-DD HH:mm'),
							"endDate" : moment(editEnd.val()).format('YYYY-MM-DD HH:mm'),
							"states": editType.val(),
							"backgroundColor" : editColor.val()
						};

						// 일정 업데이트
							$.ajax({
										url : "/keeper/" + scheduleSeq,
										type : "put",
										dataType : "json",
										contentType : "application/json; charset=utf-8",
										data : JSON.stringify(updateData),
										success : function(response) {
											console.log(response);
											alert('수정되었습니다.');
											location.reload();
										}
									});
	
					});
};

// 삭제버튼
$('#deleteEvent').on('click', function() {
	console.log(editId.val());

	$('#deleteEvent').unbind();
	$("#calendar").fullCalendar('removeEvents', $(this).data('id'));
	eventModal.modal('hide');

	var scheduleSeq = editId.val();
	// 삭제시

		$.ajax({
			type : "delete",
			url : "/keeper/" + scheduleSeq,
			dataType : "json",
			contentType : "application/json; charset=utf-8",
			success : function(response) {
				alert('삭제되었습니다.');
				location.reload();
			}
		});

});