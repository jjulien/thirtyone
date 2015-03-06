var labelField = "#person";
var idField = "#person_id";

var setFields = function (label, value) {
    $(labelField).val(label);
    $(idField).val(value);
}

$(function () {
    $(labelField).autocomplete({
        source: window.availableTags,
        select: function (event, ui) {
            setFields(ui.item.label, ui.item.value)
            return false;
        },
        focus: function (event, ui) {
            setFields(ui.item.label, ui.item.value)
            return false;
        },
        change: function (event, ui) {
            var didSet = false;
            $.each(window.availableTags, function (index, item) {
                // Don't use $(this) here instead of the field because $(this) is undefined,
                // presumably due to the imminent context switch.
                if (item.label && $(labelField).val() && item.label.toLowerCase() === $(labelField).val().toLowerCase()) {
                    didSet = true;
                    $(idField).val(item.value);
                    return false;
                }
            });

            // Wipe the field if they failed to choose a real one
            if (!didSet) {
                $(idField).val("");
                $("#person_div").addClass("field_with_errors");
                $("#person_error").removeAttr("hidden");
            } else {
                $("#person_div").removeClass("field_with_errors");
                $("#person_error").attr("hidden", "true");
            }
            return false;
        }
    });

    $("#time-slider").ionRangeSlider({
        type: "double",
        min: 0,
        max: 1440,
        step: 5,
        from: 480, // 8AM
        to: 960, // 4PM
        grid: true,
        grid_num: 12,
        prettify: function(num) {
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

            var minutes = date.getMinutes() +"";

            if (minutes.length == 1) {
                minutes = "0" + minutes;
            }

            return hours + ':' + minutes + ' ' + am_pm;
        },
        onFinish: function() {
           updateDates();
        }
    });

    $("#date").change(function(data) {
        updateDates();
    });

    var updateDates = function() {
        var timeSliderData = $("#time-slider").val().split(";");
        var startTime = timeSliderData[0];
        var endTime = timeSliderData[1];
        var date = $("#date").val();
        $("#work_schedule_start_at").val(date +" "+ toTimestamp(startTime));
        $("#work_schedule_end_at").val(date +" "+ toTimestamp(endTime));
    }

    var toTimestamp = function(minutes) {
        var hours = Math.floor(minutes / 60) +"";
        if(hours.length == 1) {
            hours = "0" + hours;
        }

        var minutes = minutes % 60 +"";
        if(minutes.length == 1) {
            minutes = "0" + minutes;
        }

        return hours +':'+ minutes +':00';
    }
});