# encoding: UTF-8
require 'spec_helper'

describe Habr::Helper do
  subject { Habr::Helper }

  it "should convert user's name to user's slug" do
    {
      'BlackFoks' => 'blackfoks',
      'alizar' => 'alizar',
      'XaocCPS' => 'xaoccps',
      'HrBr123' => 'hrbr123'
    }.each do |name, slug|
      subject.name_to_slug(name).should == slug
    end
  end

  it "should parse datetime" do
    { "22 июля 2009, 13:16" => Time.new(2009, 7, 22, 13, 16),
      "22 сентября 2011, 10:16" => Time.new(2011, 9, 22, 10, 16),
      "27 октября 2008, 01:48" => Time.new(2008, 10, 27, 1, 48)
    }.each do |str, time|
      subject.parse_datetime(str).should == time
    end

  end

end