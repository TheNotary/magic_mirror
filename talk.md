## S1.0 What is magic_mirror?




## S1.1 rails vs traditional programming

Everyone here has probably heard of rails before.  
Well Rails, Sinatra, Python's django... Flask...
These are all ways of building GUI applications for
  * Multiple Users
  and in an
  * MVC design pattern

Now that I know rails, I'm happy with MVC.  
It helps us keep our code organized and clean.  
Though in some use cases, it slows us down.  
Say, if you wanted your app to print the version number when /version is accessed.
That should only take 4 lines of code, one after another, right?  
But with MVC, we need to change 4 different files.  
So MVC is good for some things.  
But MVC isn't good for *all* things, I don't think that's a controversial statement.  

So what if we just want to add a GUI to our existing command line app?
Obviously our CLI apps aren't designed in the MVC pattern,
so we can't just start copy/pasting things into a rails app.  
And maybe we don't even want to put it on the web,
we want to use the app exclusively from our own machine.  

That's where magic_mirror comes in.  
We simply add it as a dependency, and call MagicMirror.new() and pass in a root
directory from which to serve our index view.  

Of course we have to draw up an html file to serve as our GUI,
but once that's done, you now have a GUI for your once gooey-less application.  

So in principle, this is a pretty cool gem...


## S2 What is magic_mirror... Specifically?

So by now you're probably wondering what comprises this interesting gem.  
Well magic_mirror is:
  * A sinatra html/ web server (on thin)
  * A Faye websocket server (on thin)
  * A class variable that caches all commands sent through the websocket server
    (The mirror if you will)

## S3 How do you add magic_mirror to a project?

To use magic_mirror, simply require the gem as a dependency and add a line
`@mirror = MagicMirror.new(options)`
As options, you must specify where your html assets live.  
Then you can do `@mirror.init_servers!` to boot the web/ websocket servers.  


## Lets do a hello world
