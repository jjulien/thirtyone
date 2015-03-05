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

    $("#start-time-slider").ionRangeSlider({
        type: "double",
        min: 0,
        max: 1440,
        step: 5,
        from: 480, // 8AM
        to: 960, // 4PM
        grid: true,
        grid_num: 12,
        prettify: function (num) {
            var date = new Date();
            date.setHours(num / 60);
            date.setMinutes(num % 60);

            var am_pm = "";
            var hours = date.getHours();

            if (hours < 12) {
                am_pm = "AM";
            } else {
                am_pm = "PM";
            }

            if (hours == 0) {
                hours = 12;
            }
            if (hours > 12) {
                hours = hours - 12;
            }

            var minutes = date.getMinutes();

            minutes = minutes + "";

            if (minutes.length == 1) {
                minutes = "0" + minutes;
            }

            return hours + ':' + minutes + ' ' + am_pm;
        }
    });
});