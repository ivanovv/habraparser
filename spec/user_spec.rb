require 'spec_helper'

describe Habr::User do
  subject { Habr::User.find 'blackfoks' }

  its(:slug) { should == 'blackfoks'}
  its(:name) { should == 'BlackFoks'}
  its(:favs) { should_not be_nil }
end