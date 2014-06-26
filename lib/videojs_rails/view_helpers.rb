module VideojsRails
  module ViewHelpers
    def videojs_rails(*options, &blk)
      default_options = {
        controls: true,
        setup: "{}",
        preload: "auto"
      }
      @options = default_options.merge(options.extract_options!)
      render layout: "videojs_rails/videojs_rails", &blk
    end
  end
end
