module VideojsRails
  module Tags
    class Source < Tag
      def initialize(video_type, options)
        @video_type = video_type
        @attributes = parse_options(options)
      end

      def to_html
        tag :source, @attributes
      end

      private

      attr_reader :video_type

      def parse_options(options)
        case options
        when String, Symbol
          {
            src: options,
            type: type
          }
        when Hash
          options
        else
          raise ArgumentError
        end
      end

      def type
        "video/#{video_type}"
      end
    end
  end
end
