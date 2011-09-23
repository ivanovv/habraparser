require 'spec_helper'

describe Habr::Blog do
  describe "shared blog" do
    subject { Habr::Blog.find 'ror' }

    it { should_not be_nil }
    its(:slug) { should == 'ror' }
    its(:title) { should == 'Ruby on Rails'}
  end
end