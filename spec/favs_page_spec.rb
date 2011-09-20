require 'spec_helper'

describe Habr::FavsPage do
  subject { Habr::FavsPage.new(2, :userslug => 'alizar') }

  it { should respond_to(:each) }
  it { should have_at_least(2).favs }
  it { should have_at_most(10).favs }

  its(:number) { should == 2 }
  its(:userslug) { should == 'alizar' }

  it "should have #each for favs" do
    count = 0
    subject.each { |fav| count += 1 if fav.kind_of?(Habr::Fav) }
    count.should == subject.favs.count
  end

  it "should accept :username" do
    favs_page = Habr::FavsPage.new(1, :username => 'BlackFoks')
    favs_page.userslug == 'blackfoks'
  end
end