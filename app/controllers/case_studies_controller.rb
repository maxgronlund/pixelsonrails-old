class CaseStudiesController < InheritedResources::Base
    load_and_authorize_resource

    def create
      @case_study = CaseStudy.new(params[:case_study])  
      if @case_study.save  
        if params[:case_study][:image]
          redirect_to crop_case_study_path(@case_study), :notice => "Case study created!"
        else
          redirect_to case_study_path(@case_study), :notice => "Case study created!"
        end
      else  
        render "new"  
      end  
    end  


    def crop
      @crop_version = (params[:version] || :large).to_sym
      @case_study.get_crop_version! @crop_version
      @version_geometry_width, @version_geometry_height = CaseImageUploader.version_dimensions[@crop_version]
    end

    def crop_update
    #  @case_study = current_case_study                        #!!! current case_study? no no no 
      @case_study = CaseStudy.find(params[:id])
      @case_study.crop_x = params[:case_study]["crop_x"]
      @case_study.crop_y = params[:case_study]["crop_y"]
      @case_study.crop_h = params[:case_study]["crop_h"]
      @case_study.crop_w = params[:case_study]["crop_w"]
      @case_study.crop_version = params[:case_study]["crop_version"]
      @case_study.save

      redirect_to edit_case_study_path(@case_study)
    end




  end