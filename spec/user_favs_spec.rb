require 'spec_helper'

describe Habr::UserFavs do
  subject { Habr::UserFavs.new(:userslug => 'alizar') }

  it { should have_at_least(4).pages }
  it { should have_at_most(90).pages }
  it { should respond_to(:each) }

  its(:count) { should >= 33 }

  it "should accept :userslug" do
    favs = Habr::UserFavs.new(:userslug => 'blackfoks')

  end

  it "should accept :username" do
    favs = Habr::UserFavs.new(:username => 'BlackFoks')
    favs.userslug.should == 'blackfoks'
  end

  it "should have #each for favs" do
    count = 0
    subject.each { |fav| count += 1 if fav.kind_of?(Habr::Fav) }
    count.should > 0
  end

end