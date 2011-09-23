module Habr
  class Post
    attr_reader :id

    def initialize(id)
      @id = id.to_i
    end

    def self.find(id)
      Post.new(id)
    end

    def title
      @title ||= page.css('.hentry .entry-title .topic').first.text.strip
    end

    def blog_title
      @blog_title ||= blog_link.text
    end

    def blog_slug
      @blog_slug ||= blog_link[:href].split('/')[-1]
    end

    def author_name
      @author_name ||= page.css('.vcard.author .nickname span').first.text.strip
    end

    def tags
      @tags ||= page.css('.tags li a').map { |n| n.text.strip }
    end

    def content
      @content ||= page.css('.content').inner_html
    end

    def published_at
      @published_at ||= Habr::Helper.parse_datetime(page.css('.published').first.text)
    end

    private

      def page
        @page ||= Habr::open_page(Habr::Links.post(@id))
      end

      def blog_link
        @blog_link ||= (page.css('.blog-header a').first || # for shared blog
                        page.css('.company-header .habrauser').first) # for corporate blog
      end

  end
end