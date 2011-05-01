# encoding: utf-8
class SearchController < ApplicationController
  def index
    @blogs = Blog.search params[:search], :conditions => { :language => locale.to_s }
    @pages = Page.search params[:search], :conditions => { :language => locale.to_s }
  end
end