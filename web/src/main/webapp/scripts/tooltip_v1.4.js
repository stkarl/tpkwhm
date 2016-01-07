$( function()
{
    var targets = $( '.inline_glossary' ),
        target  = false,
        tooltip = false,
        title   = false;

    targets.bind( 'mouseenter', function(event)
    {
        target  = $( this );
        tip     = $(this).attr("description");//target.attr( 'title' );
        tooltip = $( '<div id="tooltip"></div>' );

        if( !tip || tip == '' )
            return false;

        target.removeAttr( 'title' );
        tooltip.css( 'opacity', 0 )
            .html( tip )
            .appendTo( 'body' );

        var init_tooltip = function()
        {
            if( $( window ).width() < tooltip.outerWidth() * 1.5 )
                tooltip.css( 'max-width', $( window ).width() / 2 );
            else
                tooltip.css( 'max-width', 200 );

            var pos_left = target.offset().left + ( target.outerWidth() / 2 ) - ( tooltip.outerWidth() / 2 ),
                pos_top  = target.offset().top - tooltip.outerHeight() - 20;

            if( pos_left < 0 )
            {
                pos_left = target.offset().left + target.outerWidth() / 2 - 20;
                tooltip.addClass( 'left' );
            }
            else
                tooltip.removeClass( 'left' );

            if( pos_left + tooltip.outerWidth() > $( window ).width() )
            {
                pos_left = target.offset().left - tooltip.outerWidth() + target.outerWidth() / 2 + 20;
                tooltip.addClass( 'right' );
            }
            else
                tooltip.removeClass( 'right' );

            if( pos_top < 0 )
            {
                var pos_top  = target.offset().top + target.outerHeight();
                tooltip.addClass( 'top' );
            }
            else
                tooltip.removeClass( 'top' );
            if(RegExp("<br>").test(target.html().trim())){
                // If content of inline_glossary component has <br/> tag. So, we only display tooltip line which rely on the position of cursor.
                if(event.pageY > target.offset().top + (target.outerHeight() / 2)){
                    tooltip.removeClass('right top').addClass('left');
                    $('body').append("<span id='textTmp' style='display: none;'>" +target.html().trim().split('<br>')[1].replace('\n','').trim()+ "</span>");
                    pos_left = target.offset().left + ($('#textTmp').width() / 2) - 20;
                    pos_top = target.offset().top - tooltip.outerHeight() + 5;
                }else{
                    $('body').append("<span id='textTmp' style='display: none;'>" +target.html().trim().split('<br>')[0]+ "</span>");
                    pos_left += (target.outerWidth() / 2) - ($('#textTmp').width() / 2) - 5;
                    pos_top = target.offset().top - tooltip.outerHeight() - 20;
                    if(tooltip.outerWidth() <= target.outerWidth()){
                        tooltip.removeClass('left right top');
                    }
                }
                $('#textTmp').remove();
            }
            tooltip.css( { left: pos_left, top: pos_top + 10, opacity: 1,display: 'block' } );
                //.animate( { top: '+=10', opacity: 1 }, 50 );
        };

        init_tooltip();
        $( window ).resize( init_tooltip );

        var remove_tooltip = function()
        {
            tooltip.animate( { top: '-=10', opacity: 0 }, 50, function()
            {
                $( this ).remove();
            });

            //target.attr( 'title', tip );
        };

        target.bind( 'mouseleave', remove_tooltip );
        tooltip.bind( 'click', remove_tooltip );
    });
});