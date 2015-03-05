// TODO: (Clete Blackwell) Do something if the field never gets set after losing focus.

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
                // TODO: (Clete Blackwell) We probably shouldn't disable the button.
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
});