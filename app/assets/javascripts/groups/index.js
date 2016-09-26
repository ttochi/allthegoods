$(function () {
    $('#selector').click(function () {
        $('#drop_down').slideToggle(200);

        var icon = $(this).find('.icon');
        if(icon.hasClass('active'))
            icon.removeClass('active');
        else
            icon.addClass('active');
    });
});