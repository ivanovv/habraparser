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

  it "should have post link" do
    { 128922 => "http://habrahabr.ru/post/128922/" }.each do |id, url|
      subject.post(id).should == url
    end
  end

  describe "should have blog link" do
    it "for shared blogs" do
      { 'ror' => "http://habrahabr.ru/blogs/ror/" }.each do |slug, url|
        subject.blog(slug, :corporate => false).should == url
      end
    end

    it "for corporate blogs" do
      { 'mosigra' => "http://habrahabr.ru/company/mosigra/blog/" }.each do |slug, url|
        subject.blog(slug, :corporate => true).should == url
      end
    end

    it "for shared blog by default" do
      { 'ror' => "http://habrahabr.ru/blogs/ror/" }.each do |slug, url|
        subject.blog(slug).should == url
      end
    end
  end
end