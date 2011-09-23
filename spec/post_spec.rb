# encoding: UTF-8
require 'spec_helper'

describe Habr::Post do
  describe "from shared blogs" do
    subject { Habr::Post.find 128922 }

    it { should_not be_nil }
    it { should have(3).tags }
    its(:id) { should == 128922 }
    its(:title) { should == "Пример интеграции Робокассы с Rails" }
    its(:blog_slug) { should == "ror" }
    its(:blog_title) { should == "Ruby on Rails" }
    its(:content) { should_not be_nil }
    its(:published_at) { should == Time.new(2011, 9, 22, 10, 16) }
    its(:author_name) { should == "vol4ok"}
  end

  describe "from corporate blogs" do
    subject { Habr::Post.find 107398 }

    it { should_not be_nil }
    it { should have(8).tags }
    its(:id) { should == 107398 }
    its(:title) { should == "Учет личных финансов: увлекательно и полезно!" }
    its(:blog_slug) { should == "sanuel" }
    its(:blog_title) { should == "Sanuel" }
    its(:content) { should_not be_nil }
    its(:published_at) { should == Time.new(2010, 11, 1, 23, 30) }
    its(:author_name) { should == "alexeysalo"}
  end

end