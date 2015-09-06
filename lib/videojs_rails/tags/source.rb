module VideojsRails
  module Tags
    class Source < Tag
      def initialize(video_type, options)
        @video_type = video_type
        parse_options(options)
      end

      def to_html
        tag :source, attributes
      end

      private

      attr_reader :video_type, :src

      def parse_options(options)
        case options
        when String, Symbol
          @src = options
        else
          raise ArgumentError
        end
      end

      def type
        "video/#{video_type}"
      end

      def attributes
        {
          src: src,
          type: type
        }
      end
    end
  end
end
