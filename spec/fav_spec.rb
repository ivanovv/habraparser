require 'spec_helper'

describe "Habr::Fav" do
  subject {
    Habr::Fav.new :blog_slug => "ror", :blog_title => "Ruby on Rails",
      :post_id => "128645", :post_title => "Some Title", :author_name => "BlackFoks",
      :post_url => "http://habrahabr.ru/blogs/ror/128645/"
  }

  its(:blog_slug) { should == "ror" }
  its(:blog_title) { should == "Ruby on Rails" }
  its(:post_id) { should == 128645 }
  its(:post_title) { should == "Some Title" }
  its(:author_name) { should == "BlackFoks" }
  its(:post_url) { should == "http://habrahabr.ru/blogs/ror/128645/" }
  its(:post_href) { should == "http://habrahabr.ru/blogs/ror/128645/" }

end