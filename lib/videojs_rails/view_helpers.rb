module VideojsRails
  module ViewHelpers
    def videojs_rails(*options)
      default_options = {
        controls: true,
        setup: "{}",
        preload: "auto"
      }
      @options = default_options.merge(options.extract_options!)
      render "videojs_rails/videojs_rails"
    end
  end
end

