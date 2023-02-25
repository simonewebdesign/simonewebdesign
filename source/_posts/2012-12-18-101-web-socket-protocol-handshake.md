---
title: "101 Web Socket Protocol Handshake: a pragmatic guide"
description: "Learn how to set up a basic Web Socket server by reading this practical guide. We will use Node.js and the Official W3C's WebSocket API."
layout: post
permalink: /101-web-socket-protocol-handshake/
date: 2012-12-18 17:21:54 +0000
updated: 2020-02-09
comments: true
categories:
  - JavaScript
tags:
  - guide
  - handshake
  - node.js
  - protocol
  - socket
  - web
  - websocket
article_cta: false
---

<p>
  So you want to <strong>set up a web socket server</strong>, but you don&#8217;t know how. Maybe you just landed here after a bunch of Google searches. Well, keep reading: you&#8217;re in the right place.
</p>

<h2>
  The Web Socket in a nutshell
</h2>

<p>
  The new protocol is revolutionizing the whole Internet.
</p>

<p>
  The Web Socket protocol is the new alternative to the very popular <a href="http://en.wikipedia.org/wiki/Http" rel="external"><abbr title="HyperText Transfer Protocol">HTTP</abbr></a> protocol. The logic of the latter is well known: the client requests, the server responds. <a href="http://en.wikipedia.org/wiki/Request-response">Request, response</a>. Stop. This is what we call a <a href="http://en.wikipedia.org/wiki/Simplex_communication" rel="external">simplex connection</a>. It worked for decades, but has severe limitations therefore it&#8217;s not ideal for rich web applications, which would work better under a persistent connection. We need to <strong>serve content in real time</strong>; that&#8217;s why the new protocol is born.
</p>

<p>
  The <strong>WebSocket</strong> is awesome, especially if your goal is to build a chat, a VoIP server, or even a RTS game! Sounds good, huh? Let&#8217;s see how it works.
</p>

<h2>
  Roll your own Web Socket server and client
</h2>

<p>
  This guide is focused on the <a href="http://dev.w3.org/html5/websockets/" title="Official W3C WebSocket API specification">official <abbr title="World Wide Web Consortium">W3C</abbr>&#8217;s WebSocket <abbr title="Application Programming Interface">API</abbr> specification</a> for the client part; we&#8217;ll use a <a href="https://github.com/Worlize/WebSocket-Node" title="WebSocket Client &#038; Server Implementation for Node">Node.js WebSocket implementation</a> as the server. If you&#8217;re curious on how <a href="http://nodejs.org" title="Node.js" rel="external">Node.js</a> works, just check it out: there are tons of resources out there.
</p>

<p>
  Okay, let&#8217;s get started with the client: nothing fussy, It&#8217;s just a simple <abbr title="HyperText Markup Language">HTML</abbr> page. Call it <code>index.html</code>.
</p>

``` html
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <title>WebSocket Client</title>
</head>
<body>
  <h1>WebSocket Client</h1>
  <p>Open the JavaScript console to see the response!</p>
  <form>
    <label for="message">Send a message</label>
    <input id="message" name="message" type="text">
    <button id="send" name="send">Send</button>
  </form>
  <script src="ws_client.js"></script>
</body>
</html>
```

<p>
  You may have noticed the <code>script</code> tag:
</p>

``` html
<script src="ws_client.js"></script>
```

<p>
  Of course we need a bit of JavaScript in order to make it work, but don&#8217;t worry! Initializing a web socket server is just as simple as the following line of code. Create the file <code>ws_client.js</code> and write:
</p>

``` javascript
var ws = new WebSocket("ws://localhost:1337");
```

<p>
  If you&#8217;re already familiar with object-oriented programming, you should know we have been built a new instance of the <code>WebSocket</code> object, that&#8217;s built-in in all modern browsers. The <code>ws://localhost:1337</code> part just tells the <strong>WebSocket <abbr title="Application Programming Interface">API</abbr></strong> to initialize a new connection on <code>localhost:1337</code> using the <code>ws</code> protocol.
</p>

<p>
  Now let&#8217;s code some <a href="https://en.wikipedia.org/wiki/Event_%28computing%29" title="Event (computing)" rel="external">event handlers</a>. I won&#8217;t elaborate, they&#8217;re self-descriptive:
</p>

``` javascript
ws.onopen = function(ev) {
  console.log('Connection opened.');
}
ws.onmessage = function(ev) {
  console.log('Response from server: ' + ev.data);
}
ws.onclose = function(ev) {
  console.log('Connection closed.');
}
ws.onerror = function(ev) {
  console.log('An error occurred. Sorry for that.');
}
```

<p>
  Since we want to send a message to the server, we should use the <code>WebSocket.send()</code> function; but it doesn&#8217;t have a callback return value, so I&#8217;ll define a new function, <code>sendMessage()</code>, that does exactly the same <em>plus</em> logging the message on the console.
</p>

``` javascript
WebSocket.prototype.sendMessage = function(msg) {
  this.send(msg);
  console.log('Message sent: ' + msg);
}
```

<p>
  Finally I get the button to work by attaching an event handler to it:
</p>

``` javascript
var sendBtn = document.getElementById('send');
sendBtn.addEventListener('click', function(ev) {
  var message = document.getElementById('message').value;
  ws.sendMessage(message);
  ev.preventDefault();
});
```

<p>
  Basically, when we click on the button we send a message to the server. That&#8217;s it. You may wonder what does <code>ev.preventDefault()</code> do; it just makes sure that when we click the <em>Send</em> button, the form doesn&#8217;t get submitted.
</p>

<hr />

<p>
  At this stage you should have downloaded and installed <a href="https://nodejs.org/download/" rel="external">Node.js</a>: the procedure is slightly different for every operating system; just make sure to download the right installer.
</p>

<p>
  Node comes with <a href="https://npmjs.org/" title="Node Packaged Modules">npm</a>, the official package manager, that makes the <a href="https://github.com/Worlize/WebSocket-Node">WebSocket-Node</a> package installation ridiculously easy:
</p>

``` javascript
$ npm install websocket
```

<p>
  This shell command should install the WS implementation for Node.js on your machine. Now open the Node installation folder (if you don&#8217;t know where it is and you&#8217;re using a UNIX-based operating system, try <code>which node</code>) and create the file that will host our server:
</p>

``` bash
$ cd ~/local/node
$ touch ws_server.js
```

<p>
  Since this file will be executed by Node itself, it must start with the following:
</p>

```
#!/usr/bin/env node
```

<p>
  Require the WS server and the <abbr title="HyperText Transfer Protocol">HTTP</abbr> protocol APIs:
</p>

``` javascript
var WebSocketServer = require('websocket').server;
var http = require('http');
```

<p>
  Then you can define the <abbr title="HyperText Transfer Protocol">HTTP</abbr> server itself:
</p>

``` javascript
var server = http.createServer(function(request, response) {
  console.log('Received request from ' + request.url);
  response.writeHead(404);
  response.end();
});
```

<p>
  The server must be listening on a port. I&#8217;ve chosen the <code>1337</code> port, but it can be almost anything.
</p>

``` javascript
server.listen(1337, function() {
  console.log('Server is listening on port 1337.');
});
```

<p>
  Our WebSocket server is based on the <abbr title="HyperText Transfer Protocol">HTTP</abbr> server we have just created above, with a bit of security rules:
</p>

``` javascript
wsServer = new WebSocketServer({
  httpServer: server,
  autoAcceptConnections: false // because security matters
});
```

<p>
  The <code>autoAcceptConnections</code> parameter is absolutely necessary here, because we don&#8217;t want to allow connections from any source domain! That&#8217;s why I wrote a custom function that accepts or discards an incoming remote connection: it accepts only requests from <code>127.0.0.1</code> or <code>http://localhost</code>, but you can of course allow any origin you want.
</p>

``` javascript
function isAllowedOrigin(origin) {
  valid_origins = ['http://localhost', '127.0.0.1'];
  if (valid_origins.indexOf(origin) != -1) { // is in array
    console.log('Connection accepted from origin ' + origin);
    return true;
  }
  return false;
}
```

<p>
  This way we can easily filter connections based on the origin:
</p>

``` javascript
wsServer.on('request', function(request) {
  var connection = isAllowedOrigin(request.origin) ?
    request.accept() :
    request.reject();
}
```

<p>
  How can we check if a client sends us a message? We can do it by using the <code>message</code> event:
</p>

``` javascript
connection.on('message', function(message) {
  console.log('Received Message: ' + message.utf8Data);
}
```

<p>
  The message must be in UTF-8 format; we must inspect the <code>message.type</code> attribute. If the type is correct, we can process the request and define the response accordingly. Here&#8217;s my demonstrative implementation:
</p>

``` javascript
if (message.type === 'utf8') {

  var response = '';

  switch (message.utf8Data) {
    case 'hi':
      response = 'Hey there';
      break;
    case 'hello':
      response = 'Heya!';
      break;
    case 'xyzzy':
      response = 'Nothing happens.';
      break;
    case 'desu':
      response = 'Keep typing, man. Keep typing.';
      break;
    default:
      response = "Hello. Uh... what am I supposed to do with '" +
      message.utf8Data + "'?";
  }
  connection.sendUTF(response);
}
```

<p>
  It&#8217;s always a good idea to log when the connection starts and gets closed:
</p>

``` javascript
wsServer.on('connection', function(webSocketConnection) {
  console.log('Connection started.');
});

connection.on('close', function(reasonCode, description) {
  console.log(connection.remoteAddress + ' has been disconnected.');
});
```

<p>
  And that&#8217;s all. We now have a <strong>basic WebSocket server implementation</strong> and we&#8217;re ready for the <strong>handshake</strong>.
</p>

<h2>
  Establish a connection between server and client
</h2>

<p>
  We can now test our brand new <strong>WebSocket server</strong>. Open the command prompt and start the server with:
</p>

``` bash
$ node ws_server.js
Server is listening on port 1337.
```

<p>
  Finally open the client (index.html) with your favourite browser and try to send a message.
</p>

<p>
  When you send a web socket request as a client, you&#8217;ll send an <a href="https://en.wikipedia.org/wiki/HTTP_header" rel="external"><abbr title="HyperText Transfer Protocol">HTTP</abbr> header</a> like this one:
</p>

``` yaml
GET / HTTP/1.1
Host: localhost:1337
User-Agent: Mozilla/5.0 [...]
Upgrade: websocket
...
```

<p>
  And the server will respond something like:
</p>

``` yaml
HTTP/1.1 101 Switching Protocols
Upgrade: websocket
Connection: Upgrade
...
```

<p>
  This means you just established a <a href="http://en.wikipedia.org/wiki/Full_duplex#Full-duplex" rel="external">full-duplex</a> connection between the client and the server. If everything went as expected, the console should say something like:
</p>

``` yaml
Connection accepted from origin: http://localhost
```

<p>
  And from this point every message will be logged on the console. Of course you shouldn&#8217;t close the console or the server will go down. If you want to close the connection you can both press <kbd>Ctrl + C</kbd> or close the browser&#8217;s window.
</p>

<hr />

<p>
  I hope you enjoyed following this guide. You can read the full source code of this tutorial on GitHub, or download it directly. The demo also comes with a file for <a href="https://github.com/simonewebdesign/websocket-demo/blob/master/test-browser-support.html" title="Test your browser support for WebSocket API">testing your actual browser support</a> for the WebSocket <abbr title="Application Programming Interface">API</abbr>.
</p>

<ul>
  <li>
    <a href="https://github.com/simonewebdesign/websocket-demo/archive/master.zip">Direct Download</a>
  </li>
  <li>
    <a href="https://github.com/simonewebdesign/websocket-demo">View full source code on GitHub</a>
  </li>
</ul>
