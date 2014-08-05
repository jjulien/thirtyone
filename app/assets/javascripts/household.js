
function updateHouseholdSearch(input) {

    var search_key_array = input.value.split(" ");
    var search_keys = JSON.stringify(search_key_array);

    var request = $.ajax({
        url: "household/search",
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

function selectHousehold(row) {
    var household_summary = $(row).find('input[name=household_summary]').val();
    var household_id = $(row).find('input[name=household_id]').val();

    $('#selectHouseholdModal').foundation('reveal', 'close');
    $('#household_summary').html(household_summary);
    $('#person_household_id').val(household_id);
}