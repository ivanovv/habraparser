module Habr
  # Represents habrablog.
  class Blog
    attr_reader :slug

    # Creates a new blog with given slug. May have following options:
    # * :corporate - is blog corporate or not (i.e. shared)
    def initialize(slug, opts={})
      @slug = slug
      @corporate = opts[:corporate]
    end

    # Gets blog's title (like "Ruby on Rails"). Lazy method.
    def title
      @title ||= blog_link.text.strip
    end

    # Is blog corporate or not (i.e. shared).
    # If corresponding value has not set bafore (using #find, #new or #known) then 
    # loads blog page to get it.
    def corporate?
      if @corporate.nil?
        page
      end
      @corporate
    end

    # Sets some known information about this blog. Have options:
    # * title - blog's title
    # * corporate - is blog corporate or shared
    # Returns self for method chaining.
    def known(opts={})
      @title ||= opts[:title]
      @corporate ||= opts[:corporate]

      self
    end

    # Returns new blog with given params but doesn't try to find any data on habrahabr 
    # untill any method call.
    def self.find(slug, opts={})
      Blog.new slug, opts
    end

    protected

      # Gets appropriate page. Lazy method.
      def page
        @page ||= get_page
      end

      # Returns an appropriate page. If :corporate has not been set before then try to 
      # analyse the page to find out whether the blog is corporate or shared.
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

      # Gets Nokogiri::XmlNode for blog link on the page. Lazy method.
      def blog_link
        @blog_link ||= get_blog_link
      end

      # Returns Nokogiri::XmlNode for blog link. Try no find out whether the blog is 
      # corporate or shared.
      def get_blog_link
        shared_blog_link = page.css('.blog_header a').first
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