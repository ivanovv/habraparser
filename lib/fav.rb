require 'nokogiri'

module Habr
  class Fav
    attr_reader :post_title, :post_href

    def initialize(opts={})
      @post_title = opts[:post_title]
      @post_href = opts[:post_href]
    end

  end
end