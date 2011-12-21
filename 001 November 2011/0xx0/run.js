var jsdom = require( 'jsdom' );
var request = require( 'request' );

request( { uri: 'http://www.wolframalpha.com/input/?i=' + escape( process.argv[ 2 ] ) }, function( _, _, body ) {
    jsdom.env( { html: body, scripts: [ 'http://code.jquery.com/jquery-1.6.4.min.js' ] }, function( err, window ) {
        var $ = window.jQuery;
        console.log(
            $( $( '.output.pnt' )[ 1 ] ).find( 'img' ).attr( 'alt' )
        );
    } );
} );
