//= require ionrangeslider
//= require jquery
//= require jquery-ui

App.WorkSchedule = {};

App.WorkSchedule.labelField = "#user";
App.WorkSchedule.idField = "#user_id";

App.WorkSchedule.setFields = function (label, value) {
    $(App.WorkSchedule.labelField).val(label);
    $(App.WorkSchedule.idField).val(value);
};

$(function () {
    if (!($("body.work_schedule").length > 0)) {
        return;
    }

    $(App.WorkSchedule.labelField).autocomplete({
        source: window.availableTags,
        select: function (event, ui) {
            App.WorkSchedule.setFields(ui.item.label, ui.item.value);
            return false;
        },
        focus: function (event, ui) {
            App.WorkSchedule.setFields(ui.item.label, ui.item.value);
            return false;
        },
        change: function (event, ui) {
            var didSet = false;
            $.each(window.availableTags, function (index, item) {
                // Don't use $(this) here instead of the field because $(this) is undefined,
                // presumably due to the imminent context switch.
                if (item.label && $(App.WorkSchedule.labelField).val() && item.label.toLowerCase() === $(App.WorkSchedule.labelField).val().toLowerCase()) {
                    didSet = true;
                    $(App.WorkSchedule.idField).val(item.value);
                    return false;
                }
            });

            // Wipe the field if they failed to choose a real one
            if (!didSet) {
                $(App.WorkSchedule.idField).val("");
                $("#user_error").removeClass("invisible");
            } else {
                $("#user_error").addClass("invisible");
            }
            return false;
        }
    });

    $("#time-slider").ionRangeSlider({
        type: "double",
        min: 0,
        max: 1440,
        step: 5,
        from: window.start_time,
        to: window.end_time,
        grid: true,
        grid_num: 12,
        prettify: function (num) {
            var date = new Date();
            date.setHours(num / 60);
            date.setMinutes(num % 60);

            var hours = date.getHours();
            var am_pm = (hours < 12) ? "AM" : "PM";

            if (hours == 0) {
                hours = 12;
            }
            if (hours > 12) {
                hours = hours - 12;
            }

            var minutes = date.getMinutes() + "";

            if (minutes.length == 1) {
                minutes = "0" + minutes;
            }

            return hours + ':' + minutes + ' ' + am_pm;
        },
        onFinish: function () {
            updateDates();
        }
    });

    $("#date")
        .datepicker({
            minDate: 0,
            showAnim: "blind"
        })
        .change(function () {
            updateDates();
        });

    var updateDates = function () {
        var timeSliderData = $("#time-slider").val().split(";");
        var startTime = timeSliderData[0];
        var endTime = timeSliderData[1];
        var date = $.datepicker.formatDate("yy-mm-dd", new Date($("#date").val()));
        $("#work_schedule_start_at").val(date + " " + toTimestamp(startTime));
        $("#work_schedule_end_at").val(date + " " + toTimestamp(endTime));
    };

    var toTimestamp = function (minutes) {
        var hours = Math.floor(minutes / 60) + "";
        if (hours.length == 1) {
            hours = "0" + hours;
        }

        var minutes = minutes % 60 + "";
        if (minutes.length == 1) {
            minutes = "0" + minutes;
        }

        return hours + ':' + minutes + ':00';
    }
});