require 'spec_helper'

describe Habr::Fav do
  describe "should be able to use some known information" do
    subject do
       Habr::Fav.new :user => 'blackfoks', :post => {
         :id => "128645", :title => "Some Title", :author => "BlackFoks",
         :blog => { :slug => "ror", :title => "Ruby on Rails" }
       }
     end

     its(:userslug) { should == 'blackfoks' }
     its(:post) { should_not be_nil }
  end

  describe "should work without any additional information" do
    subject { Habr::Fav.new :user => "alizar", :post => { :id => 128645 } }

    its(:userslug) { should == 'alizar' }
    its(:post) { should_not be_nil }
  end

end