require "nokogiri"
require "open-uri"

module Habr
  
  # Represents habrauser.
  # All fields are lazy, page loading happens when first lazy field accessing
  # happens. First loaded page are stored and never will be reloaded for this
  # instanse.
  class User
    
    def initialize(slug)
      @slug = slug
      @homepage_url = "http://#{@slug}.habrahabr.ru/"
    end
    
    # Gets a homepage object for this user
    def homepage
      @homepage ||= Habr::open_page(@homepage_url)
    end
    
    # Gets user name (not a slug)
    def name
      @name ||= homepage.css('.habrauser.silentlink').first.text.strip
    end
    
    # Gets number of user's favorites (from user home page)
    def favs_count
      @favs_count ||= get_favs_count
    end
    
    # Returns count of user's favs
    def get_favs_count
      # get text with favs count
      text_str = homepage.xpath(".//*[@id='main-content']/div[2]/div/ul/li[3]/a").text
      # extract count
      count = text_str.scan(/\d+/).first || 0
      # convert to int
      Integer(count)
    end
    
    # Finds user with given slug on habrahabr.ru
    def User.find(userslug)
      User.new(userslug)
    end
    
  end
  
end