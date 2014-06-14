module VideojsRails
  module ViewHelpers
    def videojs_rails(*options, &blk)
      @options = options.extract_options!
      render "videojs_rails/videojs_rails", &blk
    end
  end
end

