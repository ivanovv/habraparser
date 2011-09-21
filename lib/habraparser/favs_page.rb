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
          blog_link = post_link.parent.css('a.blog').first

          # post info
          post_title = post_link.text
          post_href = post_link[:href]
          href_parts = post_href.split('/')
          post_id = href_parts[-1]

          # blog info
          blog_title = blog_link.text
          blog_slug = href_parts[4]

          # if topic is a topic-link
          if blog_slug == "go"
            blog_href_parts = blog_link[:href].split('/')
            blog_slug = blog_href_parts[-1]
            # if link is in a corporate blog
            blog_slug = blog_href_parts[-2] if blog_slug == "blog"
          end

          new_favs << Habr::Fav.new(:blog_slug => blog_slug, :post_id => post_id,
            :post_title => post_title, :post_url => post_href, :blog_title => blog_title)
        end

        new_favs
      end

  end
end