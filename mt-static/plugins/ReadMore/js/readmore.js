jQuery(function($) {

    if ( typeof ReadMore !== "undefined" && ReadMore.use_charcount ) {
        var wraptext = $( '#readmore-wraptext' );
        var children = wraptext.children();
        var content_length = 0;
        var visible_index = 0;
        for ( var i = 0; i < children.length; i++ ) {
            content_length += jQuery( children[i] ).html().length;
            if ( content_length > ReadMore.charcount ) {
                visible_index = i + 1;
                break;
            }
        }

        var html = wraptext.html();
        var visible_html = html.substr( 0, ReadMore.charcount );
        var readmore_html = html.substr( ReadMore.charcount );

        if ( checkHTML( visible_html ) ) {
            if ( readmore_html.length > 0 ) {
                wraptext.html( visible_html + '<div class="readmore-link"><a href="#readmore">続きを読む</a></div>' + '<div id="readmore" class="readmore-area">' + readmore_html + '</div>' );
            }
        } else {
            visible_html = '';
            readmore_html = '';
            var j = 0;
            for ( j = 0; j < visible_index; j++ ) {
                visible_html += jQuery( children[j] ).html();
            }
            for ( ; j < children.length; j++ ) {
                readmore_html += jQuery( children[j] ).html();
            }
            if ( children.length > visible_index ) {
                wraptext.html( visible_html + '<div class="readmore-link"><a href="#readmore">続きを読む</a></div>' + '<div id="readmore" class="readmore-area">' + readmore_html + '</div>' );

            }
        }
    }

    $( ".readmore-area" ).hide();
    $( ".readmore-link a" ).on( "click", function() { return show_more(this); } );

    function show_more( button ) {
        var targetId = button.getAttribute( "href" );
        $( targetId ).slideDown( "slow" );
        $( button.parentNode ).slideUp( "fast" );
        return false;
    }
});

var checkHTML = function( html ) {
    var doc = document.createElement('div');
    doc.innerHTML = html;
    return ( doc.innerHTML === html );
}
