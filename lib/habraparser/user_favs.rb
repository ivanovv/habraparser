module Habr
  class UserFavs
    MinPageNumber = 1
    attr_reader :userslug

    # opts:
    #  * :userslug => favorites belongs to a user with this slug
    #  * :username => favorites belongs to a user with this name
    def initialize(opts={})
      @userslug = opts[:userslug] || Habr::Helper.name_to_slug(opts[:username])
    end

    # Gets number of user's favorites (based upon number on user's page).
    def count
      @count ||= get_count
    end

    # Iterates over all user's favorites.
    def each(&block)
      pages.each { |page| page.favs.each(&block) }
    end

    # Gets pages with favorites
    def pages
      @pages ||= get_pages
    end

    private

      # Returns count of user's favs
      def get_count
        user_page = Habr::open_page(Habr::Links.userpage(@userslug))
        # get text with favs count
        user_page.css(".left .count").first.text.to_i
      end

      # Returns pages with favorites
      def get_pages
        (1..page_count).map { |n| Habr::FavsPage.new(n, :userslug => @userslug) }
      end

      # Gets a number of pages based upon paginator on user's page.
      def page_count
        @page_count ||= get_page_count
      end

      # Returns a number of pages based upon paginator on user's page.
      def get_page_count
        first_page = Habr::open_page(Habr::Links.favorites(@userslug))
        count = 1

        last_page_link = first_page.xpath(".//*[@id='nav-pages']/li/noindex/a").first

        if last_page_link
          count = get_page_number_from_url(last_page_link[:href])
        else # no last page link found (that means fav pages count <= 6)
          page_urls = first_page.css("#nav-pages>li>a").map { |link| link[:href] }
          page_numbers = page_urls.map { |url| get_page_number_from_url(url) }
          count = page_numbers.max unless page_numbers.empty?
        end

        count
      end

      def get_page_number_from_url(url)
        (url.scan(/\d+/).last || MinPageNumber).to_i
      end

  end
end