require 'spec_helper'

describe Habr do
  
  its(:user_agent) { should_not be_nil }
  its(:user_agent) { should == 'Mozilla/5.0' }
  
  # it "user_agent should be changable"
  
  it "should open a habrapage" do
    Habr.open_page('http://habrahabr.ru').should be_html
  end
  
end