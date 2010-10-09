require File.dirname(__FILE__) + '/spec_helper'

describe "PageRankrDaemon" do
  include Rack::Test::Methods

  def app
    @app ||= PageRankrDaemon
  end

  it "should respond to /" do
    get '/'
    last_response.should be_ok
  end
end