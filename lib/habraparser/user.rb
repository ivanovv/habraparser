module Habr

  # Represents habrauser.
  # All fields are lazy, page loading happens when first lazy field accessing
  # happens. First loaded page are stored and never will be reloaded for this
  # instanse.
  class User
    attr_reader :slug

    def initialize(slug)
      @slug = slug
    end

    # Gets user name (not a slug)
    def name
      @name ||= userpage.css('.habrauser.silentlink').first.text.strip
    end

    # Gets favs info for the user
    def favs
      Habr::UserFavs.new(:userslug => @slug)
    end

    # Finds user with given slug on habrahabr.ru
    def self.find(userslug)
      User.new(userslug)
    end

    private

      # Gets a homepage object for this user
      def userpage
        @userpage ||= Habr::open_page(Habr::Links.userpage(@slug))
      end

  end

end