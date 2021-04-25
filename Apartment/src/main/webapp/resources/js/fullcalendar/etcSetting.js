//SELECT 색 변경
$('#edit-color').change(function () {
    $(this).css('color', $(this).val());
});

//필터
$('#dong_toggle').on('change', function () {
	console.log(dong.val()+" 동의 일정");
    $('#calendar').fullCalendar('rerenderEvents');
});

$("#type_filter").select2({
    placeholder: "선택..",
    allowClear: true
});

//datetimepicker

function get_calendar_height() {
    return $(window).height() - 30;
}