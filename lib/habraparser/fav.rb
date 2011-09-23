require 'nokogiri'

module Habr
  class Fav
    attr_reader :post_id
    attr_accessor :blog_slug, :blog_title, :post_title, :author_name, :post_href
    alias_method :post_url, :post_href
    alias_method :post_url=, :post_href=

    def initialize(opts={})
      opts.each { |k, v| set_attr_value(k, v) }
    end

    def post_id=(val)
      @post_id = val.to_i
    end

    def post
      @post ||= Habr::Post.find(post_id)
    end

    private

      def set_attr_value(name, val)
        self.method("#{name}=").call(val)
      end

  end
end