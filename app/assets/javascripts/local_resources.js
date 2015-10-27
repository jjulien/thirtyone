$(function () {
    $("div.expand").click(function () {
        $(this).parent().parent().find("div.content").slideToggle('slow');
        var toggle = $(this).find("span.toggle");

        toggle.text(toggle.text() === '-' ? '+' : '-')
    });
});