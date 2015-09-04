module VideojsRails
  module ViewHelpers
    DEFAULT_OPTIONS = {
        controls: true,
        preload: :auto
    }.freeze

    def videojs_rails(user_options, &blk)
      sources, captions, options = prepare_options(user_options)
      generate_tag(options, sources, captions, &blk)
    end

    private

    def prepare_options(user_options)
      options = DEFAULT_OPTIONS.merge(user_options)
      options[:'data-setup'] = options.delete(:setup) if options.key?(:setup)
      options[:class] = [options[:class], "video-js vjs-default-skin"].join(' ')

      [options.delete(:sources), options.delete(:captions), options]
    end

    def generate_sources(sources)
      if sources.is_a?(Array)
        sources.each do |source|
          concat tag(:source, source)
        end
      elsif sources.is_a?(Hash)
        sources.each do |type, source|
          concat tag(:source, src: source, type: "video/#{ type }")
        end
      end
    end

    def generate_captions(captions, options)
      return if captions.blank?
      captions.each do |lang, caption|
        src, label = extract_caption_information(caption)
        caption_options = prepare_caption_options(src, lang, label, options)

        concat tag(:track, caption_options)
      end
    end

    def extract_caption_information(caption)
      if caption.is_a?(Hash)
        caption.values_at(:src, :label)
      else
        caption
      end
    end

    def prepare_caption_options(src, lang, label, options)
      default_caption_language = options[:default_caption_language].try(:to_sym)
      {
          kind: :captions,
          src: src,
          srclang: lang,
          label: label,
          default: default_caption_language == lang.to_sym
      }
    end

    def generate_tag(options, sources, captions, &blk)
      content_tag(:video, options) do
        generate_sources(sources)
        generate_captions(captions, options)
        generate_no_js(&blk)
      end
    end

    def generate_no_js
      return unless block_given?
      concat content_tag(:p, yield, class: :'vjs-no-js')
    end
  end
end
