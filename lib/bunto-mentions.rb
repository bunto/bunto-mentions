require 'bunto'
require 'html/pipeline'

module Bunto
  class Mentions
    GITHUB_DOT_COM = "https://github.com".freeze

    InvalidBuntoMentionConfig = Class.new(Bunto::Errors::FatalException)

    class << self
      def mentionify(doc)
        src = mention_base(doc.site.config)
        doc.output = filter_with_mention(src).call(doc.output)[:output].to_s
      end

      # Public: Create or fetch the filter for the given {{src}} base URL.
      #
      # src - the base URL (e.g. https://github.com)
      #
      # Returns an HTML::Pipeline instance for the given base URL.
      def filter_with_mention(src)
        filters[src] ||= HTML::Pipeline.new([
          HTML::Pipeline::MentionFilter
        ], { :base_url => src })
      end

      # Public: Filters hash where the key is the mention base URL.
      # Effectively a cache.
      def filters
        @filters ||= {}
      end

      # Public: Calculate the base URL to use for mentioning.
      # The custom base URL can be defined in the config as
      # bunto-mentions.base_url or bunto-mentions, and must
      # be a valid URL (i.e. it must include a protocol and valid domain)
      # It should _not_ have a trailing slash.
      #
      # config - the hash-like configuration of the document's site
      #
      # Returns a URL to use as the base URL for mentions.
      # Defaults to the https://github.com.
      def mention_base(config = {})
        mention_config = config['bunto-mentions']
        case mention_config
        when nil, NilClass
          GITHUB_DOT_COM
        when String
          mention_config.to_s
        when Hash
          mention_config.fetch('base_url', GITHUB_DOT_COM)
        else
          raise InvalidBuntoMentionConfig,
            "Your bunto-mentions config has to either be a" \
            " string or a hash. It's a #{mention_config.class} right now."
        end
      end

      # Public: Defines the conditions for a document to be emojiable.
      #
      # doc - the Bunto::Document or Bunto::Page
      #
      # Returns true if the doc is written & is HTML.
      def mentionable?(doc)
        (doc.is_a?(Bunto::Page) || doc.write?) &&
          doc.output_ext == ".html" || (doc.permalink && doc.permalink.end_with?("/"))
      end
    end
  end
end

Bunto::Hooks.register [:pages, :documents], :post_render do |doc|
  Bunto::Mentions.mentionify(doc) if Bunto::Mentions.mentionable?(doc)
end
