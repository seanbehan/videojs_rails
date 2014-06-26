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

## Usage

```erb
<%= videojs_rails sources: { mp4: "http://domain.com/path/to/video.mp4", webm: "http://another.com/path/to/video.webm", setup: "{}", controls: false }, width:"400" %>
```

## Captions

This is currently experimental function.

```erb
<%= videojs_rails sources: { mp4: "http://domain.com/path/to/video.mp4" }, width:"400", captions: { en: "http://domain.com/path/to/captions.vvt" } %>
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
