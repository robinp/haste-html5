// Control file for PhantomJS
//
// Renders the webpage and saves its output to a png
var page = require('webpage').create();
page.open('index.html', function () {
    page.render('booted.png');
    phantom.exit();
});
