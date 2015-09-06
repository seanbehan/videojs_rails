module VideojsRails
  module ViewHelpers
    def videojs_rails(user_options, &blk)
      VideojsRails::Tags::Video.new(user_options, &blk).to_html
    end
  end
end
