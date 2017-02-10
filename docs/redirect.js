window.setTimeout(function() {
    var link = document.evaluate("/html/body/div[1]/section/div/div/div[2]/div/p/a", document, null, XPathResult.ANY_TYPE, null);
    window.location.href = link.iterateNext().href;
}, 5000);
