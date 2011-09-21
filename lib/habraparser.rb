require 'nokogiri'
require 'open-uri'

module Habr
  
  autoload :User, 'user.rb'
  autoload :Fav, 'fav.rb'
  autoload :UserFavs, 'user_favs.rb'
  autoload :FavsPage, 'favs_page.rb'
  autoload :Links, 'links.rb'
  autoload :Helper, 'helper.rb'
  
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