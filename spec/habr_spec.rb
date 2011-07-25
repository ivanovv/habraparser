require 'spec_helper'

describe Habr do
  
  describe ".user_agent" do
    
    it "should be 'Mozilla/5.0' by default" do
      Habr.user_agent.should == 'Mozilla/5.0'
    end
    
  end
  
  it "should open a habrapage"
  
end