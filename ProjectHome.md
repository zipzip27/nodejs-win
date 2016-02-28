### This project will now be discontinued! NodeJS for Windows is now fully supported by the official release. Please use the official release found from this [site](http://nodejs.org/)! Thank you all for your support! ###

### Warning: Uninstall the previous version, before installing a newer version! ###

# Introduction #
This is a short introduction on how this package was built, and how it's going to be used.

### Documentation ###
Visit the [wiki](http://code.google.com/p/nodejs-win/wiki/Introduction) for a more in depth documentation! _(But seriously for the moment I have exams to take, so I'm inviting everyone to help me out and build a better environment for Windows users who'd like to practice NodeJS and use some of their modules! :)_

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
   ?[36minfo  -?[39m socket.io started
```

### More Examples ###
  1. [Simple Chat System](http://code.google.com/p/nodejs-win/wiki/SimpleChatSystem) Video: [In Less than 5 Minutes!](http://www.youtube.com/watch?v=hrdSN9ezDl0) ( **NEW VERSION** :)
  1. [Simple Chat System](http://code.google.com/p/nodejs-win/wiki/SimpleChatSystem) Video: [In Less than 5 Minutes!](http://www.youtube.com/watch?v=pyipKHsTqWc) ( **OLD VERSION** )

### How to Build the Installer Yourself ###
  * This package was built using NSIS (Nullsoft Scriptable Install System). You can check the source code in the [source section](http://code.google.com/p/nodejs-win/source/browse/).
  * Add this [addon](http://nsis.sourceforge.net/Environmental_Variables:_append,_prepend,_and_remove_entries) to NSIS includes folder in your program files directory.

### NodeJS Modules **(New modules since 0.6.5.1!)** ###
The following are the modules included in this package:
  * Added the NPM module! **(New @ 0.6.5.1)**
  * This NodeJS included in the package has since been upgraded to Version 0.6.0 stable. There might be incompatibilities with the pre-existing modules. You might want to download the older release if your projects no longer work with the latest release.
  * For those who would like to force NPM with windows you can read instructions from [npmsjs wiki](http://npmjs.org/doc/README.html#Installing-on-Windows-Experimental). Note, the experimental procedure discussed here does not work with NodeJS version 0.6 and above.
  * [connect-1.7.2](http://search.npmjs.org/#/connect) (@ 0.5.10.2)
    * Tested the csrf middleware http://j.mp/sLla7y
    * Tested the basicAuth middleware http://j.mp/uelIM4
    * not all tested
  * [connect-mongodb-1.0.0](http://search.npmjs.org/#/connect-mongodb) (@ 0.5.10.2)
    * tested
  * [express-2.5.0](http://search.npmjs.org/#/express) (@ 0.5.10.2)
    * no project management yet.
    * but basic calls to express methods work
    * not all tested
  * [express-csrf-0.3.3](http://search.npmjs.org/#/express-csrf) (@ 0.5.10.2)
    * untested
  * [mime-1.2.4](http://search.npmjs.org/#/mime) (@ 0.5.10.2)
    * untested
  * [mkdirp-0.0.7](http://search.npmjs.org/#/mkdirp) (@ 0.5.10.2)
    * ntested
  * [qs-0.3.1](http://search.npmjs.org/#/qs) (@ 0.5.10.2)
    * untested
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