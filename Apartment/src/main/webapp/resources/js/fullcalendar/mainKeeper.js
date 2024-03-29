
var draggedEventIsAllDay;
var activeInactiveWeekends = true;

function getDisplayEventDate(event) {

  var displayEventDate;

  if (event.allDay == false) {
    var startTimeEventInfo = moment(event.start).format('HH:mm');
    var endTimeEventInfo = moment(event.end).format('HH:mm');
    displayEventDate = startTimeEventInfo + " ~ " + endTimeEventInfo;
  } else {
    displayEventDate = "하루종일";
  }

  return displayEventDate;
}

function filtering(event) {
	if($("#dong_toggle").prop('checked')){
		 return (sessionDong == event.dong) ? true : false;
	 }else{
		 console.log("unclick");
		 return true;
	 }
}

function calDateWhenResize(event) {

  var newDates = {
    startDate: '',
    endDate: ''
  };

  if (event.allDay) {
    newDates.startDate = moment(event.start._d).format('YYYY-MM-DD HH:mm');
    newDates.endDate = moment(event.end._d).subtract(1, 'days').format('YYYY-MM-DD HH:mm');
  } else {
    newDates.startDate = moment(event.start._d).format('YYYY-MM-DD HH:mm');
    newDates.endDate = moment(event.end._d).format('YYYY-MM-DD HH:mm');
  }

  return newDates;
}

function calDateWhenDragnDrop(event) {
  // 드랍시 수정된 날짜반영
  var newDates = {
    startDate:moment(event.start._d).format('YYYY-MM-DD HH:mm'),
    endDate: moment(event.end._d).subtract(1, 'days').format('YYYY-MM-DD HH:mm')
  }

  // 날짜 & 시간이 모두 같은 경우
  if(!event.end) {
    event.end = event.start;
  }

  //하루짜리 all day
  if (event.allDay && event.end === event.start) {
    console.log('1111')
    newDates.startDate = moment(event.start._d).format('YYYY-MM-DD HH:mm');
    newDates.endDate = newDates.startDate;
  }

  //2일이상 all day
  else if (event.allDay && event.end !== null) {
    newDates.startDate = moment(event.start._d).format('YYYY-MM-DD HH:mm');
    newDates.endDate = moment(event.end._d).subtract(1, 'days').format('YYYY-MM-DD HH:mm');
  }

  //all day가 아님
  else if (!event.allDay) {
    newDates.startDate = moment(event.start._d).format('YYYY-MM-DD HH:mm');
    newDates.endDate = moment(event.end._d).format('YYYY-MM-DD HH:mm');
  }

  return newDates;
}


var calendar = $('#calendar').fullCalendar({
	contentHeight: ()=>{
	      console.log(screen.width);
	      if(screen.width < 577) {
	            return 600
	        } else {
	            return 1000
	        }
	      },
	      eventLimit: true,
	      
  eventRender: function (event, element, view) {

    //일정에 hover시 요약
    element.popover({
      title: $('<div />', {
        class: 'popoverTitleCalendar',
        text: event.title
      }).css({
        'background': event.backgroundColor,
        'color': event.textColor
      }),
      content: $('<div />', {
          class: 'popoverInfoCalendar'
        }).append('<p><strong>제목:</strong> ' + event.title + '</p>')
        .append('<p><strong>시간:</strong> ' + getDisplayEventDate(event) + '</p>')
        .append('<div class="popoverDescCalendar"><strong>설명:</strong> ' + event.contents + '</div>'),
      delay: {
        show: "800",
        hide: "50"
      },
      trigger: 'hover',
      placement: 'top',
      html: true,
      container: 'body'
    });

    return filtering(event);

  },

  //주말 숨기기 & 보이기 버튼
  customButtons: {
    viewWeekends: {
      text: '주말',
      click: function () {
        activeInactiveWeekends ? activeInactiveWeekends = false : activeInactiveWeekends = true;
        $('#calendar').fullCalendar('option', {
          weekends: activeInactiveWeekends
        });
      }
    }
  },

  header: {
    left: 'today, prevYear, nextYear, viewWeekends',
    center: 'prev, title, next',
    right: 'month,agendaWeek,agendaDay,listWeek'
  },
  views: {
    month: {
      columnFormat: 'dddd'
    },
    agendaWeek: {
      columnFormat: 'M/D ddd',
      titleFormat: 'YYYY년 M월 D일',
      eventLimit: false
    },
    agendaDay: {
      columnFormat: 'dddd',
      eventLimit: false
    },
    listWeek: {
      columnFormat: ''
    },

  },

  /* ****************
   *  일정 받아옴 
   * ************** */
	  
	  //관리자 ajax


	  events: function (start, end, timezone, callback) {
			    $.ajax({
				      type: "get",
				      url: "/keeper/listSchedule/",
				      success: function (response) {
				    	  console.log("start.....");
				    	  console.log(response);
				        callback(response);
				      }
				    });
	  },
	  
  eventAfterAllRender: function (view) {
    if (view.name == "month") {
      $(".fc-content").css('height', 'auto');
    }
  },
  
  

  //일정 리사이즈
  eventResize: function (event, delta, revertFunc, jsEvent, ui, view) {
    $('.popover.fade.top').remove();

    /** 리사이즈시 수정된 날짜반영
     * 하루를 빼야 정상적으로 반영됨. */
    var newDates = calDateWhenResize(event);
	var scheduleSeq = event._id;
	var resizeData =   {
	        scheduleSeq: event._id,
	        title: event.title,
	        dong: event.dong,
			contents:  event.contents,
			startDate: moment(event.start._d).format('YYYY-MM-DD HH:mm'),
			endDate: moment(event.end._d).format('YYYY-MM-DD HH:mm'),
			states: event.states,
			aptSeq: event.aptseq,
			backgroundColor: event.backgroundColor
	      };
	
    //리사이즈한 일정 업데이트

	
    $.ajax({
    	url : "/keeper/" + scheduleSeq,
		type : "put",
		dataType : "json",
		contentType: "application/json; charset=utf-8",
		data : JSON.stringify(resizeData),
      success: function (response) {
        alert('수정: ' + newDates.startDate + ' ~ ' + newDates.endDate);
      }
    });

  },

  eventDragStart: function (event, jsEvent, ui, view) {
    draggedEventIsAllDay = event.allDay;
  },

  //일정 드래그앤드롭
  eventDrop: function (event, delta, revertFunc, jsEvent, ui, view) {
    $('.popover.fade.top').remove();

    //주,일 view일때 종일 <-> 시간 변경불가
    if (view.type === 'agendaWeek' || view.type === 'agendaDay') {
      if (draggedEventIsAllDay !== event.allDay) {
        alert('드래그앤드롭으로 종일<->시간 변경은 불가합니다.');
        location.reload();
        return false;
      }
    }

    // 드랍시 수정된 날짜반영
    var newDates = calDateWhenDragnDrop(event);

	var scheduleSeq = event._id;
	console.log(event._id);
	console.log(scheduleSeq);
	console.log(event.backgroundColor);
	console.log(event.type);
	

	
    var updateData ={
			scheduleSeq: event._id,
	        title: event.title,
	        dong: event.dong,
			contents:  event.contents,
			startDate: moment(event.start._d).format('YYYY-MM-DD HH:mm'),
			endDate: moment(event.end._d).format('YYYY-MM-DD HH:mm'),
			states: event.states,
			aptSeq: event.aptseq,
			backgroundColor: event.backgroundColor
	};
    
    //드롭한 일정 업데이트
    $.ajax({
    	url:  "/keeper/" + scheduleSeq,
			type: "put",
			dataType : "json",
			contentType: "application/json; charset=utf-8",
			data : JSON.stringify(updateData),
        success: function (response) {
        	console.log(response)
            alert('수정: ' + newDates.startDate + ' ~ ' + newDates.endDate);
        	location.reload();
        }
    });

  },

  select: function (startDate, endDate, jsEvent, view) {

    $(".fc-body").unbind('click');
    $(".fc-body").on('click', 'td', function (e) {

      $("#contextMenu")
        .addClass("contextOpened")
        .css({
          display: "block",
          left: e.pageX,
          top: e.pageY
        });
      return false;
    });

    var today = moment();

    if (view.name == "month") {
      startDate.set({
        hours: today.hours(),
        minute: today.minutes()
      });
      startDate = moment(startDate).format('YYYY-MM-DD HH:mm');
      endDate = moment(endDate).subtract(1, 'days');

      endDate.set({
        hours: today.hours() + 1,
        minute: today.minutes()
      });
      endDate = moment(endDate).format('YYYY-MM-DD HH:mm');
    } else {
      startDate = moment(startDate).format('YYYY-MM-DD HH:mm');
      endDate = moment(endDate).format('YYYY-MM-DD HH:mm');
    }

    //날짜 클릭시 카테고리 선택메뉴
    var $contextMenu = $("#contextMenu");
    $contextMenu.on("click", "a", function (e) {
      e.preventDefault();

      //닫기 버튼이 아닐때
      if ($(this).data().role !== 'close') {
        newEvent(startDate, endDate, $(this).html());
      }

      $contextMenu.removeClass("contextOpened");
      $contextMenu.hide();
    });

    $('body').on('click', function () {
      $contextMenu.removeClass("contextOpened");
      $contextMenu.hide();
    });

  },

  //이벤트 클릭시 수정이벤트
  eventClick: function (event, jsEvent, view) {
    editEvent(event);
  },

  locale: 'ko',
  timezone: "local",
  nextDayThreshold: "09:00:00",
  allDaySlot: true,
  displayEventTime: true,
  displayEventEnd: true,
  firstDay: 0, //월요일이 먼저 오게 하려면 1
  weekNumbers: false,
  selectable: true,
  weekNumberCalculation: "ISO",
  eventLimit: true,
  views: {
    timeGrid: {
      eventLimit: 4
    }
  },
  
  eventLimitClick: 'popover', //popover
  navLinks: true,
  defaultDate: moment('2020-11'), //실제 사용시 삭제
  timeFormat: 'HH:mm',
  defaultTimedEventDuration: '01:00:00',
  editable: true,
  minTime: '00:00:00',
  maxTime: '24:00:00',
  slotLabelFormat: 'HH:mm',
  weekends: true,
  nowIndicator: true,
  dayPopoverFormat: 'MM/DD dddd',
  longPressDelay: 0,
  eventLongPressDelay: 0,
  selectLongPressDelay: 0
});