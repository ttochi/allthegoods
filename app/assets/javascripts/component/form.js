$(function () {
    function increaseIdAndName(element) {
        var id = element.attr('id');
        var name = element.attr('name');

        if (id && name) {
            var number = parseInt(id.match(/\d+/)) + 1;
            element.attr('id', id.replace(/\d+/, number));
            element.attr('name', name.replace(/\d+/, number));
        }
    }

    $('#add_member').unbind('click').click(function () {
        var memberField = $('.member_field').last().clone();
        memberField.find('input[type=text]').val('');
        increaseIdAndName(memberField.find('input[type=text]'));
        increaseIdAndName(memberField.find('input[type=hidden]'));

        $('.member_field').last().after(memberField);

        $('.remove_member').click(function () {
            $(this).prev('input[type=hidden]').val(true);
            $(this).parent().hide();
        });
    });

    $('.remove_member').click(function () {
        $(this).prev('input[type=hidden]').val(true);
        $(this).parent().hide();
    });
});