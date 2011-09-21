module Habr
  class Helper
    class << self
      # Converts user name to user slug
      def name_to_slug(name)
        name.downcase
      end
    end
  end
end