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
<%= videojs_rails sources: { mp4: "http://domain.com/path/to/video.mp4", webm: "http://another.com/path/to/video.webm" }, width:"400" %>
```

## Captions

This is currently experimental function.

```erb
<%= videojs_rails sources: { mp4: "http://domain.com/path/to/video.mp4" }, width:"400", captions: { en: "http://domain.com/path/to/captions.vvt" } %>
```


## Resources
http://videojs.com/
http://videojs.com/#getting-started

