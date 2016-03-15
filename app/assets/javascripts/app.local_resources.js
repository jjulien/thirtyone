App.Local_Resources = {};

$(document).ready(function() {
  if (!($("body.local_resources").length > 0)) {
    return;
  }

  $("input#local_resource_phone").inputmask("999-999-9999");
  $("input#local_resource_address_attributes_zip").inputmask("99999");

  $("div.expand").click(function () {
    $(this).parent().parent().find("div.content").slideToggle('slow');
    var toggle = $(this).find("span.toggle");

    toggle.text(toggle.text() === '▼' ? '►' : '▼')
  });
});