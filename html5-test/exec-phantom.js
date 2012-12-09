// Control file for PhantomJS
//
// Renders the webpage and saves its output to a png

var page = require('webpage').create();
page.settings.localToRemoteUrlAccessEnabled = true

page.onResourceRequested = function(request) {
    console.log('Request (#' + request.id + '): ' + JSON.stringify(request));
};
page.onResourceReceived = function(response) {
    console.log('Response (#' + response.id + ', stage "' + response.stage + '"): ' + JSON.stringify(response));
};

page.open('index.html', function () {
    // Wait a little until the imag is loaded
    // TODO hook to resource received and apply timeout there?
    window.setTimeout(function() {
      page.render('booted.png');
      phantom.exit();
    }, 100)
});
