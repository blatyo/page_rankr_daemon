require 'sinatra/base'
require 'page_rankr'
require 'json'

class PageRankrDaemon < Sinatra::Base
  get "/stats/?" do
    url = params[:url]
    
    content_type :json
    {:ranks => PageRankr.ranks(url), :backlinks => PageRankr.backlinks(url)}.to_json
  end
end
