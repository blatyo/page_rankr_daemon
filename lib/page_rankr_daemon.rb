require 'sinatra/base'
require 'page_rankr'
require 'json'

class PageRankrDaemon < Sinatra::Base
  get "/stats/?" do
    url = params[:url]
    
    content_type :json
    {:ranks => PageRankr.ranks(url), :backlinks => PageRankr.backlinks(url)}.to_json
  end
  
  get "/ranks/?" do
    content_type :json
    PageRankr.ranks(params[:url]).to_json
  end
  
  get "/backlinks/?" do
    content_type :json
    PageRankr.backlinks(params[:url]).to_json
  end
end
