module Habr
  class Links
    class << self

      def home
        "http://habrahabr.ru/"
      end

      def userpage(slug)
        "http://#{slug}.habrahabr.ru/"
      end

      def favorites(slug, page=nil)
        if page
          "http://habrahabr.ru/users/#{slug}/favorites/page#{page}/"
        else
          "http://habrahabr.ru/users/#{slug}/favorites/"
        end
      end

      def post(id)
        "http://habrahabr.ru/post/#{id}/"
      end

      def blog(slug)
        "http://habrahabr.ru/blogs/#{slug}/"
      end

    end
  end
end