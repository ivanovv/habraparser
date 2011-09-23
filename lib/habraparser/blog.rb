module Habr
  class Blog
    attr_reader :slug

    def initialize(slug)
      @slug = slug
    end

    def title
      @title ||= blog_link.text.strip
    end

    def self.find(slug)
      Blog.new slug
    end

    protected

      def page
        @page ||= Habr.open_page(Habr::Links.blog(@slug))
      end

      def blog_link
        @blog_link ||= page.css('.blog-header a').first
      end

  end
end