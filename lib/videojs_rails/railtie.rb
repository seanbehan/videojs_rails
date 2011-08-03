require 'videojs_rails/view_helpers'

module VideojsRails
  class Railtie < Rails::Railtie
    initializer "videojs_rails.view_helpers" do
      ActionView::Base.send(:include, ViewHelpers)
    end
  end
end
