require 'spec_helper'

describe Habr::Links do
  subject { Habr::Links }
  its(:home) { should == 'http://habrahabr.ru/' }

  it "should have userpage link" do
    subject.userpage('alizar').should include('alizar')
  end

  it "should have favorites link" do
    ['blackfoks', 'alizar'].each do |userslug|
      [1, 2, 3].each do |page_number|
        link = subject.favorites(userslug, page_number)
        link.should include(userslug)
        link.should include("page#{page_number}")
      end
    end
  end

  it "should get link to 1st page without page number" do
    ['blackfoks', 'alizar'].each do |userslug|
      link = subject.favorites(userslug)
      link.should include(userslug)
      link.should_not include("page")
    end
  end

end