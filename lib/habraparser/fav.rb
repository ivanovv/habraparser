require 'nokogiri'

module Habr
  class Fav
    attr_reader :userslug, :post

    def initialize(opts={})
      # set userslug and post
      @userslug = Habr::Helper.name_to_slug(opts[:user])
      @post = Habr::Post.new opts[:post][:id]
      # try to set some known info about post
      @post.known opts[:post]
    end
  end
end