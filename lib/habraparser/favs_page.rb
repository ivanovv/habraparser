module Habr
  class FavsPage
    attr_reader :number, :userslug

    # opts:
    #  * :userslug or :username
    def initialize(number, opts={})
      @number = number
      @userslug = opts[:userslug] || Habr::Helper.name_to_slug(opts[:username])
    end

    # Gets favs for this page
    def favs
      @favs ||= get_favs
    end

    def each(&block)
      favs.each(&block)
    end

    private

      # Gets html-page for this page
      def page
        @page ||= Habr::open_page(Habr::Links.favorites(@userslug, @number))
      end

      # Extracts favs from html
      def get_favs
        new_favs = []

        page.css('.hentry a.topic').each do |post_link|
          post_title = post_link.text
          post_href = post_link[:href]

          href_parts = post_href.split('/')

          post_id = href_parts[-1]
          blog_slug = href_parts[2]

          new_favs << Habr::Fav.new(:post_title => post_title, :post_href => post_href)
        end

        new_favs
      end

  end
end