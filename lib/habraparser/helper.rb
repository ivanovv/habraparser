# encoding: UTF-8
module Habr
  class Helper
    class << self
      # Converts user name to user slug
      def name_to_slug(name)
        name.downcase
      end

      def parse_datetime(str)
        date, time = str.split(', ')
        # time
        h, mins = time.split(':').map { |s| s.to_i }
        # date
        d, month, y = date.split(' ')
        y = y.to_i
        d = d.to_i

        month = case month.downcase
          when 'января' then 1
          when 'февраля' then 2
          when 'марта' then 3
          when 'апреля' then 4
          when 'мая' then 5
          when 'июня' then 6
          when 'июля' then 7
          when 'августа' then 8
          when 'сентября' then 9
          when 'октября' then 10
          when 'ноября' then 11
          when 'декабря' then 12
        end

        Time.new(y, month, d, h, mins)
      end

    end
  end
end