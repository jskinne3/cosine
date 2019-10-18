class ReadingListsController < ApplicationController
  before_action :authenticate_user!

  def index
    @syllabi = Syllabus.all.includes(:books).page params[:page]
  end

  def coassigned
    @book = Book.find(params[:id])
    @syllabi = @book.syllabi
    @coassigned = @syllabi.map{|s| s.books}.flatten.uniq - [@book]
  end
    
end
