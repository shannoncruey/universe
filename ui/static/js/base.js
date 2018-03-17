$(function() {"use strict";
    // this is gonna have to use the cookie/session to know who's logged in

    $("#btn_sensorlogs").click(function() {
        $.get("/api/sensorlogs", function(data) {
            $("#details").empty();
            $.each(data, function(idx, log) {
                var $ul = $('<ul>');
                $ul.append('<li>' + log.type + '</li>');
                $("#details").append($ul);
            });
        });
    });

});
