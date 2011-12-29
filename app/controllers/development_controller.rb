class DevelopmentController < ApplicationController
  def index
    session[:go_to_after_edit] = development_index_path
    @case_studies = CaseStudy.order('sorting desc').where("section = 'development'").page(params[:page]).per(8)
  end

end
