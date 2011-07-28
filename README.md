# Habraparser Gem

Compatible with Ruby on Rails.

Usage:

```ruby

    require 'habraparser'
    
    # get post from habr
    post_id = 57829
    post = Habr::Post.find post_id
    
    # puts post info
    puts "#{post.blog_title} -> #{post.title}"
    puts post.before_habracut
    puts "author: #{post.author_name}"
     
```

Usage with Rails:

```ruby

    # app/models/post.rb
    class Post < ActiveRecord::Base
      # ...
      
      # fetches post from habr, saves it and then return it
      def self.fetch(id)
        # find post on habr
        hpost = Habr::Post.find id
        Post.create(
          :title => hpost.title,
          :content => hpost.content,
          # find blog in db or save it with given data
          :blog => Blog.find_or_save(
            :slug => hpost.blog_slug,
            :title => hpost.blog_title
          ),
          # find habrauser in db or save it with given data
          :habrauser => Habrauser.find_or_save(
            :slug => hpost.author_slug,
            :name => hpost_author_name
          )
        )
      end      
    end

```

For more see documentation or wiki.