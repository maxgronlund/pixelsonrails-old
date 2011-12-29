class DevelopmentController < ApplicationController
  def index
    session[:go_to_after_edit] = development_index_path
    @case_studies = CaseStudy.where("section = 'development'").page(params[:page]).per(8).order('sorting DESC')
  end

end
