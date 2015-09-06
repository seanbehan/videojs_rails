module VideojsRails
  module Tags
    class Caption < Tag
      def initialize(lang, default_language, options)
        @lang = lang.to_sym
        @default_language = default_language
        parse_options(options)
      end

      def to_html
        tag :track, attributes
      end

      private

      attr_reader :src, :label, :lang, :default_language

      def default?
        default_language == lang
      end

      def parse_options(options)
        case options
        when String, Symbol
          @src = options
        when Hash
          @src, @label = options.values_at(:src, :label)
        else
          raise ArgumentError
        end
      end

      def attributes
        {
          kind: :captions,
          src: src,
          srclang: lang,
          label: label,
          default: default?
        }
      end
    end

  end
end
