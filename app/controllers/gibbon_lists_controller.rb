class GibbonListsController < ApplicationController
  def index
    start = params[:start] || 0
    limit = params[:limit] || 100
    @lists = GibbonAPI.lists({:start => start, :limit => limit})
  end

end
