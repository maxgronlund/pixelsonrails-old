class GibbonCampaignsController < ApplicationController
  def index
    start = params[:start] || 0
    limit = params[:limit] || 100
    @campaigns = GibbonAPI.campaigns({:start => start, :limit => limit})
  end

end
