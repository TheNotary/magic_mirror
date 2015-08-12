# MagicMirror

Have you ever wanted to add a GUI to your ruby command line application.  Didn't want to go the ncurses route?  Well with Ruby's new Magic Mirror gem, you can build a stunning UI with html.  No need to rewrite your code and do a massive MVC re-write, just require this gem, point it to an html public directory that includes and html index (and optionally javascripts and css files) and your UI is all set and standing by on 127.0.0.1:4567 by default.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'magic_mirror'
```

And then execute:

    $ bundle

## Usage

    rt = RubyTube.new

    # Point RubyTube to where the html public directory is
    rt.www_root = "gui/"

    # Possibly some routes setup for Sinatra
    # rt... 


    # start sinatra, faye/websockets and prints "browse to 127.0.0.1:4567"
    rt.run!


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/magic_mirror/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
