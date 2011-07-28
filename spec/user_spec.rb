require 'spec_helper'

describe Habr::User do
  let(:alizar) { Habr::User.find 'alizar' }
  specify { alizar.name.should == 'alizar'} 
  specify { alizar.favs_count.should > 0 }  
end