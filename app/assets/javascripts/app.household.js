// app/assets/javascripts/app.household.js

App.Household = {};

App.Household.updateHouseholdSearch = function(input) {
  var request;
  if(input.value.length > 0){
    var search_key_array = input.value.split(" ");
    var search_keys = JSON.stringify(search_key_array);

    request = $.ajax({
      url: "/households/search",
      type: "GET",
      data: { search : search_keys,
        ajax   : true },
      dataType: "html"
    });

    request.done(function( html ) {
      $( "#household_results" ).html( html );
    });

    request.fail(function( jqXHR, textStatus ) {
      alert( "Search update failed: " + textStatus );
    });
  }
  else{
    request = $.ajax({
      url: "/households/search",
      type: "GET",
      data: { ajax   : true },
      dataType: "html"
    });

    request.done(function( html ) {
      $( "#household_results" ).html( html );
    });

    request.fail(function( jqXHR, textStatus ) {
      alert( "Search update failed: " + textStatus );
    });

  }
};

App.Household.selectHousehold = function(row, url) {
  var household_id = $(row).find('input[name=household_id]').val();
  //var url = base_url + "/" + household_id;
  $.ajax({url: url,
    data: {ajax: true}
  }).fail(function( jqXHR, textStatus, errorThrown ) {
      alert("Sorry, a failure occured");
    })
    .done(function(data, status, xhr) {
      $('#selectHouseholdModal').foundation('reveal', 'close');
      $('#household_div').html(data);
      $('#select_household_message').hide();
    });
};

App.Household.newHouseholdAjax = function(url) {
  $.ajax({url: url,
    data: {ajax: true}
  }).fail(function( jqXHR, textStatus, errorThrown ) {
      alert("Sorry, a failure occured");
    })
    .done(function(data, status, xhr) {
      $('#selectHouseholdModal').foundation('reveal', 'close');
      $('#household_div').html(data);
      $('#select_household_message').hide();
    });
};

$(document).ready(function() {
  if (!($("body.household").length > 0)) {
    return;
  }
  // Anything here will get executed when a page is rendered through the Households controller
});
