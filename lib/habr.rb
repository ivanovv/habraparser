require 'nokogiri'
require 'open-uri'

module Habr
  
  # Returns default user agent
  def self.user_agent
    "Mozilla/5.0"
  end
  
  # Opens page on habrahabr.ru with default user agent.
  # Please, use this method instead of direct nokogiri.
  def self.open_page(habraurl)
    Nokogiri::HTML(open(habraurl, "User-Agent" => "Mozilla/5.0"))
  end
  
end