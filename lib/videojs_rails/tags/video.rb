module VideojsRails
  module Tags
    class Video < Tag
      DEFAULT_LANGUAGE_KEY = :default_caption_language
      DEFAULT_OPTIONS = {
        controls: true,
        preload: :auto
      }.freeze

      def initialize(options, &no_js)
        @no_js = no_js
        prepare_options(options)
      end

      def to_html
        content_tag(:video, options) do
          sources.each {|type, options| concat Source.new(type, options).to_html }
          captions.each {|lang, options| concat Caption.new(lang, default_caption_language, options).to_html }
          generate_no_js
        end
      end

      private

      attr_reader :no_js, :sources, :captions, :options, :default_caption_language

      def prepare_options(user_options)
        @sources = user_options.delete(:sources) || []
        @captions = user_options.delete(:captions) || []
        @default_caption_language = user_options.delete(DEFAULT_LANGUAGE_KEY)
        @options = DEFAULT_OPTIONS.merge(user_options)
        options[:'data-setup'] = options.delete(:setup) if options.key?(:setup)
        options[:class] = [:'video-js', :'vjs-default-skin', *options[:class]]
      end

      def generate_no_js
        return if no_js.nil?
        concat content_tag(:p, no_js.call(), class: :'vjs-no-js')
      end
    end
  end
end
