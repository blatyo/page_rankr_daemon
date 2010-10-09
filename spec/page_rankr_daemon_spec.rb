require File.dirname(__FILE__) + '/spec_helper'

describe PageRankrDaemon do
  include Rack::Test::Methods

  def app
    @app ||= PageRankrDaemon
  end
  
  context "when responding to /stats?url=http://www.google.com" do
    before :each do
      get "/stats?url=http://www.google.com"
    end
    
    it "should be ok" do
      last_response.should be_ok
    end
    
    it "should have a content type of json" do
      last_response.headers['Content-Type'].should eql('application/json')
    end
  end
  
  context "when responding to /ranks?url=http://www.google.com" do
    before :each do
      get "/ranks?url=http://www.google.com"
    end
    
    it "should be ok" do
      last_response.should be_ok
    end
    
    it "should have a content type of json" do
      last_response.headers['Content-Type'].should eql('application/json')
    end
  end
end