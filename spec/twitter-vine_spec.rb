require 'spec_helper'
require 'twitter-vine'

TwitterVine::Client::DEBUG=true

describe TwitterVine do
  it "should be valid" do
    TwitterVine.should be_a(Module)
  end

  it "should return results" do 
    l = TwitterVine::Client.search("Prank")
    puts l
    expect(l.size).to be > 0 
  end

end