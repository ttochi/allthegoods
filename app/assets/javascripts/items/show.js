$(function() {
    // right content fixed 영역
    function fixedPanel() {
        if ($(window).width() >= 768) {
            var marginRight = parseFloat($('#contents').css('margin-right').replace("px", ""));
            $('#item_info').css({position: 'fixed', right: marginRight});
            $('#seller_info').css({position: 'fixed', right: marginRight});

            $(window).scroll(function () {
                var scrollTop = $(this).scrollTop();

                if (scrollTop < 45) {
                    $('#item_info').css({top: 65 - scrollTop});
                    $('#seller_info').css({top: 405 - scrollTop});
                } else {
                    $('#user_action').css({top: 20});
                    $('#writer').css({top: 360});
                }
            }).scroll();
        } else {
            $('#item_info').css({position: 'static'});
            $('#seller_info').css({position: 'static'});
            $(window).unbind('scroll');
        }
    }

    fixedPanel();

    $(window).resize(function () {
        fixedPanel();
    });
});