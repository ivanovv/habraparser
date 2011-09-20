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

end