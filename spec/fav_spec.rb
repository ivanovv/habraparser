require 'spec_helper'

describe "Habr::Fav" do

  it "should accept :post_title" do
    fav = Habr::Fav.new(:post_title => "Some Title")
    fav.post_title.should == "Some Title"
  end

  it "should accept :post_href" do
    fav = Habr::Fav.new(:post_href => "http://habr.ru/posts/123")
    fav.post_href.should == "http://habr.ru/posts/123"
  end

  # it "find last fav for user"
  #   it "find first fav for user"
  #   it "find specified fav for user"
  #   it "has a post title"
  #   it "belongs to user"
  #   it "has a blog title"
  #
  #   it "can be found via user" # do
  #   # favs for blacfoks
  #   favs = Habr::Fav.for_user('blackfoks')
  #   favs.should_not be_nil
  #   favs.should_not be_empty
  # end

  # let(:bf_last_fav) { Habr::Fav.find :last, :user => 'blackfoks' }
  # specify { bf_last_fav.should_not be_nil }
  # specify { bf_last_fav.post_title.should_not be_nil }
  # specify { bf_last_fav.blog_title.should_not be_nil }
end