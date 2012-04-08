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
      @title ||= page.css('.post .post_title').first.text.strip
    end

    def blog_title
     @blog_title ||= blog_link.text
    end

    def blog_slug
     @blog_slug ||= blog_link[:href].split('/')[-1]
    end

    def blog
      @blog ||= get_blog
    end

    def author_name
      @author_name ||= page.css('.author a').first.text.strip
    end

    def tags
      @tags ||= page.css('.tags a').map { |n| n.text.strip }
    end

    def content
      @content ||= page.css('.post .html_format').inner_html
    end

    def published_at
      @published_at ||= Habr::Helper.parse_datetime(page.css('.published').first.text)
    end

    def known(opts={})
      @title ||= opts[:title]
      @author_name ||= opts[:author]
      @tags ||= opts[:tags]
      @published_at ||= opts[:published_at]

      if opts[:blog]
        @blog_slug ||= opts[:blog][:slug]
        @blog_title ||= opts[:blog][:title]
        @is_blog_corporate ||= opts[:blog][:corporate]
      end

      self
    end

    private

      def page
        @page ||= Habr::open_page(Habr::Links.post(@id))
      end

      def blog_link
        @blog_link if @blog_link

        @is_blog_corporate = false
        @blog_link = page.css('.hub').first # for shared blog

        unless @blog_link
          @blog_link = page.css('.name a').first  # for corporate blog
          @is_blog_corporate = true
        end

        @blog_link
      end

      def get_blog
        new_blog = Habr::Blog.find blog_slug, :corporate => @is_blog_corporate
        new_blog.known :title => blog_title
      end

  end
end