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

        page.css('.post').each do |post|
          post_link = post.css(".post_title").first
          blog_link = post.css('.hub').first

          # post info
          post_title = post_link.text
          post_href = post_link[:href]
          href_parts = post_href.split('/')
          post_id = href_parts[-1]
          tags = post.css(".tags a").map{|tag| tag.text.strip}

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

          new_fav = Habr::Fav.new :user => @userslug, :post => {
            :id => post_id, :title => post_title, :tags => tags,
            :blog => { :slug => blog_slug, :title => blog_title }
          }

          new_favs << new_fav
        end

        new_favs
      end

  end
end