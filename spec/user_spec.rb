require 'spec_helper'

describe Habr::User do
  # alizar
  let(:alizar) { Habr::User.find 'alizar' }
  specify { alizar.name.should == 'alizar'} 
  specify { alizar.favs_count.should > 0 }
  
  # blackfoks
  let(:blackfoks) { Habr::User.find 'blackfoks' }
  specify { blackfoks.name.should == 'BlackFoks' }
  specify { blackfoks.favs_count.should >= 770 }
end