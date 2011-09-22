require 'nokogiri'
require 'open-uri'

require "habraparser/user"
require "habraparser/fav"
require "habraparser/user_favs"
require "habraparser/favs_page"
require "habraparser/links"
require "habraparser/helper"
require "habraparser/post"


module Habr
  # Returns default user agent
  def self.user_agent
    "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:5.0.1) Gecko/20100101 Firefox/5.0.1"
  end

  # Opens page on habrahabr.ru with default user agent.
  # Please, use this method instead of direct nokogiri.
  def self.open_page(habraurl)
    Nokogiri::HTML(open(habraurl, "User-Agent" => self.user_agent))
  end
end