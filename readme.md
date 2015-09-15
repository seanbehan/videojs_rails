# VideoJS for Rails Asset Pipeline

Supports Rails 3.x and 4.x

## Installation

Add to your Gemfile

```ruby
gem 'videojs_rails'
```

And run bundle to install the library.

```ruby
bundle
```

Add the resources to your application.js file

```coffeescript
# app/assets/javascripts/application.js
//= require video
```

And that resource to application.css file

```sass
/*
*= require_self
*= require video-js
*/
```

And to production.rb add this line

```ruby
config.assets.precompile += %w( video-js.swf vjs.eot vjs.svg vjs.ttf vjs.woff )
```

In Rails > 4.1
Add this line to config/initializers/assets.rb

```ruby
Rails.application.config.assets.precompile += %w( video-js.swf vjs.eot vjs.svg vjs.ttf vjs.woff )
```

## Usage

```erb
<%= videojs_rails sources: { mp4: "http://domain.com/path/to/video.mp4", webm: "http://another.com/path/to/video.webm"}, setup: "{}", controls: false, width:"400" %>
```

If you want add a callback if user don't support JavaScript use block with displayed html code:

```erb
<%= videojs_rails sources: { mp4: "http://domain.com/path/to/video.mp4", webm: "http://another.com/path/to/video.webm" }, width:"400" do %>
	Please enable <b>JavaScript</b> to see this content.
<%- end %>
```

## Captions

This is currently an experimental function.

```erb
<%= videojs_rails sources: { mp4: "http://domain.com/path/to/video.mp4" }, width:"400", captions: { en: { src: "http://domain.com/path/to/captions.vvt", label: "English" }, default_caption_language: :en } %>
```

## Turbolinks

Some of you might want to use VideoJS with Turbolinks. [andrkrn](https://github.com/andrkrn) provided CoffeeScript that he use:

```coffeescript
change = ->
    for player in document.getElementsByClassName 'video-js'
        video = videojs('example_video')

before_change = ->
    for player in document.getElementsByClassName 'video-js'
        video = videojs('example_video')
        video.dispose()

$(document).on('page:before-unload', before_change)
$(document).on('page:change', change)
```

## Resources
http://videojs.com/
http://videojs.com/#getting-started


## Updating this gem to the latest video.js release

### Clone this repository

    git clone https://github.com/seanbehan/videojs_rails.git

### Clone video.js repository

    git clone https://github.com/videojs/video.js.git


### Run the rake videojs:update task with the tag

    TAG=v4.12.5
    rake videojs:update

Note: The build will fail if you don't have `grunt` installed.  To install it:

    cd ../video.js
    npm install -g grunt

### Make sure everything is added to git

    git add .
    git ci -m "Update to $TAG"

### Push to rubygems

* $VIDEO_JS_RAILS_HOME/vendor/assets/javascripts/video.js.erb
* $VIDEO_JS_RAILS_HOME/vendor/assets/stylesheets/video-js.css.erb

Alternatively, you can set the Flash player SWF file in your web view with the `videojs.options.flash.swf` command:
```
<script>
  videojs.options.flash.swf = "http://example.com/path/to/video-js.swf"
</script>
```
As the instructions here suggests: https://github.com/videojs/video.js/blob/stable/docs/guides/setup.md#self-hosted
