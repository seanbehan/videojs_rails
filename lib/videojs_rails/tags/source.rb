module VideojsRails
  module Tags
    class Source < Tag
      def initialize(video_type, options)
        @attributes = prepare_attributes(video_type, options)
      end

      def to_html
        tag :source, @attributes
      end

      private

      def prepare_attributes(video_type, options)
        case options
          when String, Symbol
            {}.tap do |attributes|
              attributes[:src] = options
              attributes[:type] = "video/#{video_type}"
            end
          when Hash
            options
          else
            raise ArgumentError
        end
      end
    end
  end
end
