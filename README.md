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

Simple example:

```ruby

    # find user
    user = Habr::User.find 'blackfoks'

    # each fav
    user.favs.pages.each |page| do
      page.each |fav| do
        # find blog, post and author
        blog = Habr::Blog.find fav.blog_slug
        post = Habr::Post.find fav.post_id
        author = Habr::User.find fav.author_slug

        # puts past preview
        puts "#{blog.name} > #{post.title}"
        puts post.before_habracut
        puts "by #{author.name} (#{author.karma}, #{author.power})"
      end
    end

```

Instead of directly find blog by its slug and post by its id you can simply call special
methods of Fav instance:

```ruby

    # explicit
    blog = Habr::Blog.find fav.blog_slug
    post = Habr::Post.find fav.post_id
    author = Habr::User.find fav.author_slug

    # inplicit
    blog = fav.blog
    post = fav.post
    author = fav.author

```

You also can iterate over all favs instead of pages and favs. UserFavs#each gets
an iterator and hides iterating over pages.

All attributes of FavsPage is lazy. This means that when you create FavsPage object or even when
you get it from iterator or #each method it contains nothing but URL of favorites page.

When you start iterating over favorites on the page on the first time FavsPage instance
calls #load and loads appropriate web-page and parses its content then it fills @favs array
with Fav objects and lets you iterate over the array.

Notice: #load is called only once so if you need to reload the page you should create
a new FavsPage instance.

All attributes of Fav is not lazy. There's only one way you can get an object of this kind:
from FavsPage instance. Although you can use #new because it gets empty Fav object.



How to use:

```ruby

    user = Habr::User.find 'blackfoks'
    user.favs.count #=> 786
    user.favs.pages.count #=> 64
    user.favs.page(1) #=> [Fav, Fav, Fav...]

    user.favs.class #=> UserFavs
    user.favs.pages[1].class #=> FavsPage
    user.favs.pages.class #=> Array

    user.favs.pages.each do |page|
      page.each do |fav|
       fav.title #=> ...
       fav.blog_title #=> "Ruby"
       fav.blog_slug #=> "ruby"
       fav.post_id #=> 123876
      end
    end

```

Usage with Rails:

```ruby

    # app/models/post.rb
    class Post < ActiveRecord::Base
      # ...

      # fetches post from habr, saves it and then returns it
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
          :author => Habrauser.find_or_save(
            :slug => hpost.author_slug,
            :name => hpost_author_name
          )
        )
      end
    end

```

For more see documentation or wiki.