
function updateHouseholdSearch(input) {

    var search_key_array = input.value.split(" ");
    var search_keys = JSON.stringify(search_key_array);

    var request = $.ajax({
        url: "households/search",
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

function selectHousehold(row, url) {
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
}

function newHouseholdAjax(url) {
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
}