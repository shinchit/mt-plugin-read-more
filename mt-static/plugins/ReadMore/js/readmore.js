jQuery(function($) {
    $( ".readmore-area" ).hide();
    $( ".readmore-link a" ).on( "click", function() { return show_more(this); } );


    function show_more( button ) {
        var targetId = button.getAttribute( "href" );
        $( targetId ).slideDown( "slow" );
        $( button.parentNode ).slideUp( "fast" );
        return false;
    }
});
