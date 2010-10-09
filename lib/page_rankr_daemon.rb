require 'sinatra/base'
require 'page_rankr'
require 'json'

class PageRankrDaemon < Sinatra::Base
  def url
    params[:splat].first + "//" + params[:splat][1..-1].join('/')
  end
  
  get "/stats/*" do  
    content_type :json
    {:ranks => PageRankr.ranks(url), :backlinks => PageRankr.backlinks(url)}.to_json
  end
  
  PageRankr.backlink_trackers.each do |tracker|     # Example:
    get "/backlinks/#{tracker}/*" do                # get "/backlinks/google/*" do
      content_type :json                            #   content_type :json
      PageRankr.backlinks(url, tracker).to_json     #   PageRankr.backlinks(url, :google).to_json
    end                                             # end
  end
  
  PageRankr.rank_trackers.each do |tracker|         # Example:
    get "/ranks/#{tracker}/*" do                    # get "/ranks/google/*" do
      content_type :json                            #   content_type :json
      PageRankr.ranks(url, tracker).to_json         #   PageRankr.ranks(url, :google).to_json
    end                                             # end
  end
  
  get "/ranks/*" do
    content_type :json
    PageRankr.ranks(url).to_json
  end
  
  get "/backlinks/*" do
    content_type :json
    PageRankr.backlinks(url).to_json
  end
end
