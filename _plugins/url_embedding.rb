require "open-uri"
require "json"

module Jekyll

  # convert various urls to embedding html
  class UrlEmbedding

    def convert(line)
      twitter(line)
    end

    def get_twitter_html(id)
      url = "https://api.twitter.com/1/statuses/oembed.json?id=#{id}"
      JSON.parse(open(url).read, { :symbolize_names => true })[:html]
    end

    def twitter(line)
      r = /^https?:\/\/twitter\.com\/[a-zA-Z0-9_]+\/status(es)?\/([0-9]+)\/?$/
      r =~ line ? get_twitter_html($~[2]) : youtube(line)
    end

    def get_youtube_html(id)
      return "<div class='embed-container youtube'><iframe width='560' height='315' src='https://www.youtube.com/embed/#{id}' frameborder='0' allow='autoplay; encrypted-media' allowfullscreen></iframe> </div>"
    end

    def youtube(line)
      r = /^(https?:\/\/www\.youtube\.com)\/watch\?v=(.*?)$/
      r =~ line ? get_youtube_html($~[2]) : framer(line)
    end

    def get_framer_html(id)
      return "<div class='embed-container framer'><iframe width='500' height='640' src='https://framer.cloud/#{id}' frameborder='0'></iframe></div>"
    end

    def framer(line)
      r = /(https?:\/\/framer\.cloud\/(.*?)$)/
      r =~ line ? get_framer_html($~[2]) : marvel(line)
    end

    def get_marvel_html(id)
      return "<div class='embed-container framer'><iframe width='500' height='640' src='https://marvelapp.com/#{id}?emb=1' frameborder='0'></iframe></div>"
    end

    def marvel(line)
      r = /(https?:\/\/marvelapp.com)\/(.*?)$/
      r =~ line ? get_marvel_html($~[2]) : line
    end
    

    def embed(content)
      content.lines.collect {|line| convert(line) }.join
    end
  end

  # for markdown, extend oroginal parser's convert method
  module Converters
    class Markdown < Converter
      alias_method :parser_converter, :convert

      def convert(content)
        parser_converter(Jekyll::UrlEmbedding.new.embed(content))
      end
    end
  end

  # for html, extend converter as a plugin
  class EmbeddingUrlIntoHTML < Converter
    safe true
    priority :low

    def matches(ext)
      ext =~ /^\.html$/i
    end

    def output_ext(ext)
      ".html"
    end

    def convert(content)
      Jekyll::UrlEmbedding.new.embed(content)
    end
  end

end
