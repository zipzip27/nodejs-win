### Simple Chat System ###
Most websites that wish to use NodeJS generally can't afford a direct migration to NodeJS from webservers to everything else. But the asynchronous part of NodeJS will be most helpful. This is simplified by the Socket.IO module where the websocket technique is simplified. This is a simpe guide on how to implement a simple chat system, with an existing webserver and a NodeJS Socket.IO server for listening for asynchronous calls from the clientside JavaScript.

### Server Side JS - socket.js ###
Here's the code for the server side Javascript that will be powered by Socket.IO under NodeJS.

```
var io = require('socket.io').listen(8000);

// open the socket connection
io.sockets.on('connection', function (socket) {
   
   // listen for the chat even. and will recieve
   // data from the sender.
   socket.on('chat', function (data) {
   
      // default value of the name of the sender.
      var sender = 'unregistered';
      
      // get the name of the sender
      socket.get('nickname', function (err, name) {
         console.log('Chat message by ', name);
         console.log('error ', err);
         sender = name;
      });   

      // broadcast data recieved from the sender
      // to others who are connected, but not 
      // from the original sender.
      socket.broadcast.emit('chat', {
         msg : data, 
         msgr : sender
      });
   });
   
   // listen for user registrations
   // then set the socket nickname to 
   socket.on('register', function (name) {
   
      // make a nickname paramater for this socket
      // and then set its value to the name recieved
      // from the register even above. and then run
      // the function that follows inside it.
      socket.set('nickname', name, function () {
      
         // this kind of emit will send to all! :D
         io.sockets.emit('chat', {
            msg : "naay nag apil2! si " + name + '!', 
            msgr : "mr. server"
         });
      });
   });

});
```

### Client Side JS - index.html ###
And this is a plain html file which will be powered by your existing web server. For me, Im currently using Apache (WAMP). I put it in my www folder and named it index.html.

```
<html>
   <head>
      <script src="http://localhost:8000/socket.io/socket.io.js"></script>
      <script src="http://code.jquery.com/jquery-1.6.2.min.js"></script>
      <script>
         var name = '';
         var socket = io.connect('http://localhost:8000');
         
         // at document read (runs only ones).
         $(document).ready(function(){
            // on click of the button (jquery thing)
            // the things inside this clause happen only when 
            // the button is clicked.
            $("button").click(function(){
            
               // just some simple logging
               $("p#log").html('sent message: ' + $("input#msg").val());
               
               // send message on inputbox to server
               socket.emit('chat', $("input#msg").val() );
               
               // the server will recieve the message, 
               // then maybe do some processing, then it will 
               // broadcast it again. however, it will not 
               // send it to the original sender. the sender
               // will be the browser that sends the msg. 
               // other browsers listening to the server will
               // recieve the emitted message. therefore we will
               // need to manually print this msg for the sender.
               $("p#data_recieved").append("<br />\r\n" + name + ': ' + $("input#msg").val());
               
               // then we empty the text on the input box.
               $("input#msg").val('');
            });
            
            // ask for the name of the user, ask again if no name.
            while (name == '') {
               name = prompt("What's your name?","");
            }
            
            // send the name to the server, and the server's 
            // register wait will recieve this.
            socket.emit('register', name );
         });
         
         // listen for chat event and recieve data
         socket.on('chat', function (data) {
         
            // print data (jquery thing)
            $("p#data_recieved").append("<br />\r\n" + data.msgr + ': ' + data.msg);
            
            // we log this event for fun :D
            $("p#log").html('got message: ' + data.msg);
            
         });
      </script>
   </head>
   <body>
      <input type="text" id="msg"></input><button>Click me</button>
      <p id="log"></p>
      <p id="data_recieved"></p>
   </body>
</html>
```

### Explanation ###

Notice that the server side JavaScript is being run on port 8000, and by default Apache runs on Port 80. The index.html is served at port 80, however, the client side JavaScript communicates with another server, at port 8000 for asynchronous updates on itself. Just like how Facebook chat/comments are asynchronously updated.

Now, run the server side JavaScript. You will access the index.html file through your browser. For each onload event of index.html, it will ask for a nickname, it will then emit this nickname to the server. The server side JavaScript.

The server will then save that nick for that particular socket (session of communication between this particular client and the server). It will then be saved there for the duration of their asynchronous calls until disconnection, or re-registration.

### Code Snippets ###
#### Sender ####
The ff code snippet is a sender:
```
socket.emit('chat', $("input#msg").val() );
```
Chat in this case is more like the name of the event to be raised when the data is received by some receiver (in this case, since we're the client, then the receiver will be the server), while the value sent is this JQuery call _$("input#msg").val()_ which denotes the value of the input box with id _msg_ in the html file.
#### Receiver ####
The ff code snippet is a listener:
```
socket.on('chat', function (data) {
```
Chat is the name of the event to be listened for. Then the function is the call back function triggered when a chat event comes up. Data is the value received from the chat even.

Notice that the same emit, and on syntax are used for the server side and the client side JavaScript. Which can prove to be useful for the developers side.

### References ###
[Socket.IO Wiki](https://github.com/learnboost/socket.io)