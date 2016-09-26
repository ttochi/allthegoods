$(function () {
    $('.member').click(function () {
        $('.member_filter').slideToggle(200);
    });

    $('.order').click(function () {
        $('.order_filter').slideToggle(200);
    });

    $(document).click(function (event) {
        if (event.target.className != 'member_filter' && event.target.className != 'member') {
            $('.member_filter').slideUp(200);
        }
        if (event.target.className != 'order_filter' && event.target.className != 'order') {
            $('.order_filter').slideUp(200);
        }
    });
});