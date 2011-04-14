var     http = require('http'),
          io = require('socket.io'),
 querystring = require('querystring');

var params;
var current_client;
var current_response;
var payload;
var buffer = '';

var server = http.createServer(function(req, res) {
  req.on('data', function(data) {
    buffer += data;
  });

  req.on('end', function () {
    current_response = res;
    params = querystring.parse(buffer)
    buffer = '';
    send_to_client(params['payload']);
  });
});

server.listen(8124);

// socket.io, I choose you
var socket = io.listen(server);
socket.on('connection', function(client) {
  console.log("client connected");
  current_client = client;
  client.on('message', function(message) {
    console.log("message from client: " + message);
    current_response.end(message);
  }); 
});

var send_to_client = function(payload) {
  console.log("sending to client: " + payload);
  if (current_client) {
    console.log("client exists");
    current_client.send(payload);
  } else {
    console.log("client not there yet");
    setTimeout(function() { send_to_client(payload) }, 100);
  }
};

console.log('Server running at http://127.0.0.1:8124/');
