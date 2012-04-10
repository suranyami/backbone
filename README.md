Notes on my fork of Backbone:
=============================
Added a backbone-websockets persistence layer.
It's early days and VERY unfinished.
The test websocket server requires MongoDB to run.

Trying it out
-------------

Run this:

    examples/websocket-todos/run_server

Then point your browser at:

    http://localhost:8888/examples/websocket-todos/index.html
    

You should see a todo list. Add items to it and they will be persisted
into the mongodb db `todos` in the collection `todos`.




     ____                     __      __                                                 
    /\  _`\                  /\ \    /\ \                                   __           
    \ \ \ \ \     __      ___\ \ \/'\\ \ \____    ___     ___      __      /\_\    ____  
     \ \  _ <'  /'__`\   /'___\ \ , < \ \ '__`\  / __`\ /' _ `\  /'__`\    \/\ \  /',__\ 
      \ \ \ \ \/\ \ \.\_/\ \__/\ \ \\`\\ \ \ \ \/\ \ \ \/\ \/\ \/\  __/  __ \ \ \/\__, `\
       \ \____/\ \__/.\_\ \____\\ \_\ \_\ \_,__/\ \____/\ \_\ \_\ \____\/\_\_\ \ \/\____/
        \/___/  \/__/\/_/\/____/ \/_/\/_/\/___/  \/___/  \/_/\/_/\/____/\/_/\ \_\ \/___/ 
                                                                           \ \____/      
                                                                            \/___/       
    (_'_______________________________________________________________________________'_)
    (_.———————————————————————————————————————————————————————————————————————————————._)
                                               
                                              
Backbone supplies structure to JavaScript-heavy applications by providing models key-value binding and custom events, collections with a rich API of enumerable functions, views with declarative event handling, and connects it all to your existing application over a RESTful JSON interface.

For Docs, License, Tests, pre-packed downloads, and everything else, really, see:
http://backbonejs.org

To suggest a feature, report a bug, or general discussion:
http://github.com/documentcloud/backbone/issues/

All contributors are listed here:
http://github.com/documentcloud/backbone/contributors

Special thanks to Robert Kieffer for the original philosophy behind Backbone. 
http://github.com/broofa
