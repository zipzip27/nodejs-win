# Introduction #
This is a short introduction on how this package was built, and how it's going to be used.

### Examples ###
  1. Everyone is invited to add more examples to this wiki!

### Installation ###
  1. Download and Install the [latest release](http://code.google.com/p/nodejs-win/downloads/list) of the package. _The environment variable PATH should already be appended by the  installer with the installation directory of NodeJS and a new environment variable called NODE\_PATH should already be added which should point to the %install\_directory%\node\_modules._
  1. Test the installation if NodeJS works with the Socket.IO module.

### Testing ###
Using the command prompt go to your documents folder. There should be a new directory called NodeJS there. Go to the socket directory example. And try to run it with Node. The ff example indicates a successful install.

```
Microsoft Windows Version 6.1.7600
Copyright (c) 2009 Microsoft Corporation. All rights reserved.

C:\Users\Bangonkali>cd Documents\NodeJS\Examples\socket

C:\Users\Bangonkali\Documents\NodeJS\Examples\socket>node socket.js
   ←[36minfo  -←[39m socket.io started
```

### More Examples ###
  1. [Simple Chat System](http://code.google.com/p/nodejs-win/wiki/SimpleChatSystem) Video: [In Less than 5 Minutes!](http://www.youtube.com/watch?v=pyipKHsTqWc) :)

### How to Build the Installer Yourself ###
  * This package was built using NSIS (Nullsoft Scriptable Install System). You can check the source code in the [source section](http://code.google.com/p/nodejs-win/source/browse/).
  * Add this [addon](http://nsis.sourceforge.net/Environmental_Variables:_append,_prepend,_and_remove_entries) to NSIS includes folder in your program files directory.

### NodeJS Modules ###
The following are the modules included in this package:
  * [mysql ](http://search.npmjs.org/#/mysql)
  * [hasish](http://search.npmjs.org/#/hashish)
  * [socket.io](http://search.npmjs.org/#/socket.io)
  * [socket.io-client](http://search.npmjs.org/#/socket.io-client)
  * [uglify-js](http://search.npmjs.org/#/uglify-js)
  * [websocket-client](http://search.npmjs.org/#/websocket-client)
  * [xmlhttprequest](http://search.npmjs.org/#/xmlhttprequest)
  * [policyfile](http://search.npmjs.org/#/policyfile)
  * [redis](http://search.npmjs.org/#/redis)
More modules will be added along the way. I'm still testing on modules' [now](http://search.npmjs.org/#/now), and [express](http://search.npmjs.org/#/express). After testing them then they'll soon be included.

### Future ###
  * Everyone is invited to **JOIN IN** and **ADD MORE MODULES** to this package. As long as they'll work perfectly with each other. And probably someday, when a real package manager for windows starts arriving then we can leave the modules to it. As for the moment, I think this is better than nothing for Windows users.
  * Also there is a [very good article from here](http://blog.tatham.oddie.com.au/2011/03/16/node-js-on-windows) which details how to run NodeJS as a service. This would be very good. I'll be working on this soon. Probably an install as a service section for the NSIS script. That would be pretty cool. \m/
  * I don't know so much about licensing stuff so I hope people will not get angry with what im doing. I'm not taking ownership on any code stored in this project, I just want a simple package for my Co-Windows Users. <sup>_</sup>

### Inspiration ###
This project was inspired by this [article](http://ajlopez.wordpress.com/2011/09/01/playing-with-nodejs-1-running-on-windows-and-azure/). You can visit updates from the developer blog [here](http://blog.istoryahi.me/?p=118).