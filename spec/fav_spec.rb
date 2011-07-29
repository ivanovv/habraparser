require 'spec_helper'

describe "Habr::Fav" do
  it "find last fav for user"
  it "find first fav for user"
  it "find specified fav for user"
  it "has a post title"
  it "belongs to user"
  it "has a blog title"
  it "can be found via user"
  
  # let(:bf_last_fav) { Habr::Fav.find :last, :user => 'blackfoks' }
  # specify { bf_last_fav.should_not be_nil }
  # specify { bf_last_fav.post_title.should_not be_nil }
  # specify { bf_last_fav.blog_title.should_not be_nil }
end