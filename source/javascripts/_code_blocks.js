$(document).ready(function () {
    $('pre code').each(function (i, block) {
        var lang = "",
            regexp = /[^language-](.[^\s]*)/;

        for (var i = 0; i < block.classList.length; i++) {
            lang = regexp.exec(block.classList[i])[0];
        }

        var blockTitle = document.createElement("span")
        blockTitle.setAttribute("class", "code-block-title")
        blockTitle.innerHTML = lang.toUpperCase() + ":"

        $(block).parent().prepend(blockTitle)
    });
});
