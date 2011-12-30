class KobloStudioController < ApplicationController
  def index
    @flash_file = FlashFile.first
  end

end
