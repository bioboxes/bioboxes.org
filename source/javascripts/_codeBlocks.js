$(document).ready(function () {
    $('pre code').each(function (i, block) {
        var lang = "",
            regexp = /[^language-](.[^\s]*)/;

        for (var i = 0; i < block.classList.length; i++) {
            lang = regexp.exec(block.classList[i])[0];
        }

        $(block).parent().prepend(lang.toUpperCase() + ":")
    });
});
