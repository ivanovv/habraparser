# encoding: UTF-8
require 'spec_helper'

describe Habr::Blog do
  describe "shared blog" do
    subject { Habr::Blog.find 'ror' }

    it { should_not be_nil }
    its(:slug) { should == 'ror' }
    its(:title) { should == 'Ruby on Rails'}
    its(:corporate?) { should be_false }
  end

  describe "corporate blog" do
    subject { Habr::Blog.find 'mosigra', :corporate => true }

    it { should_not be_nil }
    its(:slug) { should == 'mosigra' }
    its(:title) { should == 'Мосигра'}
    its(:corporate?) { should be_true}
  end

  describe "shared/corporate recognition" do
    describe "if no :corporate info given" do
      it "should recognize corporate blog" do
        blog = Habr::Blog.find 'mosigra'
        blog.corporate?.should be_true
      end

      it "should recognize shared blog" do
        blog = Habr::Blog.find 'ror'
        blog.corporate?.should be_false
      end

      it "should prefer shared instead of corporate" do
        blog = Habr::Blog.find 'yandex'
        blog.corporate?.should be_false
      end
    end

    describe "if wrong info given" do
      it "should change shared to corporate" do
        blog = Habr::Blog.find 'mosigra', :corporate => false
        blog.corporate?.should be_false
        blog.title # force loading page
        blog.corporate?.should be_true
      end

      it "should chage corporate to shared" do
        blog = Habr::Blog.find 'ror', :corporate => true
        blog.corporate?.should be_true
        blog.title # force loading page
        blog.corporate?.should be_false
      end
    end
  end

  describe "we know something about" do
    subject do
      blog = Habr::Blog.find 'ror'
      blog.known :title => "Ruby on Rails", :corporate => false
    end

    before(:each) { Habr.should_not_receive :open_page }

    it { should_not be_nil }
    its(:slug) { should == 'ror' }
    its(:title) { should == "Ruby on Rails" }
    its(:corporate?) { should be_false }
  end
end