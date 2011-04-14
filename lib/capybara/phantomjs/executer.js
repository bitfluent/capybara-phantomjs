var result;
var socket;

phantom.loadJs("./lib/capybara/phantomjs/socket.io.js");
socket = new io.Socket('localhost', {transports:['htmlfile', 'xhr-multipart', 'xhr-polling', 'jsonp-polling'], port: 8124});

socket.on('message', function(data) {
  console.log("received message from server: " + data);
  result = eval(data);
  if (data.indexOf('phantom.open') >= 0) {
    phantom.state = 'open';
  } else {
    socket.send(JSON.stringify(result || 'obye'));
  }
});

socket.on('connect', function() {
  if (phantom.state.length === 0) {
  } else {
    socket.send(JSON.stringify(phantom.state || 'ohai'));
    phantom.state = '';
  }
});

socket.connect();
