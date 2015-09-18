$(function() {
    // page is now ready, initialize the calendar...

    $('#calendar').fullCalendar({
        events: window.workSchedules
    })

});