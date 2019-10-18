class ReadingListsController < ApplicationController
  before_action :authenticate_user!

  def index
    @syllabi = Syllabus.all.includes(:books).page params[:page]
  end

  private
    
end
