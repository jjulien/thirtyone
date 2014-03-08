function updateNewPersonButton(input) {
    var value = input.value;
    var add_button = $('#newperson');
    if ( value != "" ) {
        add_button.removeClass('hide');
        add_button.html('+ Add ' + value);
    } else {
        add_button.addClass('hide');
        add_button.html('');
    }
}
function updatePersonSearch(input) {
    updateNewPersonButton(input);

    var search_key_array = input.value.split(" ");
    var search_keys = JSON.stringify(search_key_array);

    var request = $.ajax({
        url: "people/search",
        type: "GET",
        data: { search : search_keys,
                ajax   : true },
        dataType: "html"
    });

    request.done(function( html ) {
        $( "#results" ).html( html );
    });

    request.fail(function( jqXHR, textStatus ) {
        alert( "Search update failed: " + textStatus );
    });

    // TODO: AJAX call to populate search results

}



function showPersonDiv(li) {
    var div = $(li).find("[name='persondetails']");
    var allitems = $(li).parent().find("li");
    allitems.each( function(index, item) {
        if ( item != li ) {
            $(item).animate({opacity:0});
            //$(li).parent().slideUp();
            //$(item).fadeOut({queue: false});
        }
    })
    var save_position = $(li).position().top;
    var slide_up_to = parseFloat(save_position) - 1;
    $("#searcharea").slideUp({complete: function() { div.slideDown(); }});
    //li.move
    //div.slideDown( { queue: true });
    $(li).css("position", "relative");
    $(li).animate({ 'top': '-' + slide_up_to.toString() + 'px' });
    $(li).parent().animate({ 'height': $(li).height()},
                           { complete: function () {
                                           allitems.each( function(index, item) {
                                                 if ( item != li ) {
                                                     $(item).hide();
                                                 }
                                           })
                                           $(li).css("position", "");
                                           $(li).css("top", "");
                                           $(li).parent().css("height", "auto");
                                      }
                           });
}
