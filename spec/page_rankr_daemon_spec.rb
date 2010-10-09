require File.dirname(__FILE__) + '/spec_helper'

describe PageRankrDaemon do
  include Rack::Test::Methods

  def app
    @app ||= PageRankrDaemon
  end
  
  context "when responding to /stats/http://www.google.com" do
    before :all do #The multiple requests from PageRankr are too slow
      get "/stats/http://www.google.com"
    end
    
    it "should be ok" do
      last_response.should be_ok
    end
    
    it "should have a json content type" do
      last_response.headers['Content-Type'].should eql('application/json')
    end
    
    it "should have a body with the correct form" do
      hash = JSON.parse(last_response.body)
      
      hash.keys.should include("ranks", "backlinks")
      hash["ranks"].keys.should include(*PageRankr.rank_trackers.collect(&:to_s))
      hash["ranks"].values.each{|value| value.should be_kind_of(Numeric)}
      hash["backlinks"].keys.should include(*PageRankr.backlink_trackers.collect(&:to_s))
      hash["backlinks"].values.each{|value| value.should be_kind_of(Numeric)}
    end
  end
  
  context "when responding to /ranks/http://www.google.com" do
    before :all do
      get "/ranks/http://www.google.com"
    end
    
    it "should be ok" do
      last_response.should be_ok
    end
    
    it "should have a json content type" do
      last_response.headers['Content-Type'].should eql('application/json')
    end
    
    it "should have a body with the correct form" do
      ranks = JSON.parse(last_response.body)
      
      ranks.keys.should include(*PageRankr.rank_trackers.collect(&:to_s))
      ranks.values.each{|value| value.should be_kind_of(Numeric)}
    end
  end
  
  context "when responding to /backlinks/http://www.google.com" do
    before :all do
      get "/backlinks/http://www.google.com"
    end
    
    it "should be ok" do
      last_response.should be_ok
    end
    
    it "should have a json content type" do
      last_response.headers['Content-Type'].should eql('application/json')
    end
    
    it "should have a body with the correct form" do
      backlinks = JSON.parse(last_response.body)
      
      backlinks.keys.should include(*PageRankr.backlink_trackers.collect(&:to_s))
      backlinks.values.each{|value| value.should be_kind_of(Numeric)}
    end
  end
  
  PageRankr.rank_trackers.each do |tracker|
    context "when responding to /ranks/#{tracker}/http://www.google.com" do
      before :all do
        get "/ranks/#{tracker}/http://www.google.com"
      end

      it "should be ok" do
        last_response.should be_ok
      end

      it "should have a json content type" do
        last_response.headers['Content-Type'].should eql('application/json')
      end

      it "should have a body with the correct form" do
        rank = JSON.parse(last_response.body)

        rank.keys.should eql([tracker.to_s])
        rank.values.each{|value| value.should be_kind_of(Numeric)}
      end
    end
  end
  
  PageRankr.backlink_trackers.each do |tracker|
    context "when responding to /backlinks/#{tracker}/http://www.google.com" do
      before :all do
        get "/backlinks/#{tracker}/http://www.google.com"
      end

      it "should be ok" do
        last_response.should be_ok
      end

      it "should have a json content type" do
        last_response.headers['Content-Type'].should eql('application/json')
      end

      it "should have a body with the correct form" do
        backlink = JSON.parse(last_response.body)

        backlink.keys.should eql([tracker.to_s])
        backlink.values.each{|value| value.should be_kind_of(Numeric)}
      end
    end
  end
end