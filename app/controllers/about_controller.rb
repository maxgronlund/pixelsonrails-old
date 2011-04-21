class AboutController < ApplicationController
#  load_and_authorize_resource
  def index
    case locale.to_s
      when 'dk' then @about = Page.about_dk
      when 'en' then @about = Page.about_en
    end
  end
end
