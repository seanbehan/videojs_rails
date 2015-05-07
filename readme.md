# VideoJS for Asset Pipeline

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

_currently skins are not implemented (after migrate to 4.1 version)_

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

This is currently experimental function.

```erb
<%= videojs_rails sources: { mp4: "http://domain.com/path/to/video.mp4" }, width:"400", captions: { en: { src: "http://domain.com/path/to/captions.vvt", label: "English" }, default_caption_language: :en } %>
```


## Resources
http://videojs.com/
http://videojs.com/#getting-started


## Update from video.js release

### Generate video.js distribution files

* Checkout release tag e.g. `git checkout v4.6.1`.
* Run the build i.e. `grunt`.

### Copy video.js files into videojs_rails

    $ cp $VIDEO_JS_HOME/dist/video-js/video-js.swf $VIDEO_JS_RAILS_HOME/vendor/assets/flash/
    $ cp $VIDEO_JS_HOME/dist/video-js/font/* $VIDEO_JS_RAILS_HOME/vendor/assets/fonts/
    $ cp $VIDEO_JS_HOME/dist/video-js/video.dev.js $VIDEO_JS_RAILS_HOME/vendor/assets/javascripts/video.js.erb
    $ cp $VIDEO_JS_HOME/dist/video-js/video-js.css $VIDEO_JS_RAILS_HOME/vendor/assets/stylesheets/video-js.css.erb

### Update video.js files with ERB from previous version of videojs_rails

The following files need to be modified to use the Rails `asset_path` helper e.g. for the location of the Flash player SWF file and for the location of the various font files:

* $VIDEO_JS_RAILS_HOME/vendor/assets/javascripts/video.js.erb
* $VIDEO_JS_RAILS_HOME/vendor/assets/stylesheets/video-js.css.erb

Alternatively, you can set the Flash player SWF file in your web view with the `videojs.options.flash.swf` command:
```
<script>
  videojs.options.flash.swf = "http://example.com/path/to/video-js.swf"
</script>
```
As the instructions here suggests: https://github.com/videojs/video.js/blob/stable/docs/guides/setup.md#self-hosted
