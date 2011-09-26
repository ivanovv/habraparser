module Habr
  class Blog
    attr_reader :slug

    def initialize(slug, opts={})
      @slug = slug
      @corporate = opts[:corporate]
    end

    def title
      @title ||= blog_link.text.strip
    end

    def corporate?
      if @corporate.nil?
        page
      end
      @corporate
    end

    def known(opts={})
      @title ||= opts[:title]
      @corporate ||= opts[:corporate]

      self
    end

    def self.find(slug, opts={})
      Blog.new slug, opts
    end

    protected

      def page
        @page ||= get_page
      end

      def get_page
        is_corporate = @corporate || false # it's shared by default

        # try to use current #corporate? state
        begin
          new_page = Habr.open_page(Habr::Links.blog @slug, :corporate => is_corporate)
        # it seems like current #corporate? state is wrong, so try to use inverse state
        rescue Exception => e
          new_page = Habr.open_page(Habr::Links.blog @slug, :corporate => !is_corporate)
          @corporate = !is_corporate
        end

        new_page
      end

      def blog_link
        @blog_link ||= get_blog_link
      end

      def get_blog_link
        shared_blog_link = page.css('.blog-header a').first
        if shared_blog_link
          @corporate = false
          return shared_blog_link
        else
          @corporate = true
          return page.css('.company-header .habrauser').first
        end
      end

  end
end