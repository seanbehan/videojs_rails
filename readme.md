# VideoJS for Rails 3.1 Asset Pipeline

## Installation

Add to your Gemfile
```ruby

gem 'videojs_rails

```

And run bundle to install the library.

```ruby

bundle

```

Add the resources to your application.js file

```coffeescript

# app/assets/javascripts/application.js
//= require videojs

```

You can optionally include skins by requiring in app/assets/stylesheets/application.css

```sass

/*
*= require_self
*= require videojs
*/

```

## Usage

```erb

<%= videojs_rails source: "http://domain.com/path/to/video.mp4" %>

```

## Resources
http://videojs.com/
http://videojs.com/#getting-started

