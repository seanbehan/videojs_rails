require 'videojs_rails/railtie'
require 'videojs_rails/engine' if defined?(Rails && Rails::VERSION::MAJOR == 3 && Rails::VERSION::MINOR >=1)
