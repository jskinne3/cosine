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

  def cips
    @cips = Syllabus.distinct.pluck(:field, :cip).reject{|e| e[0].nil?}
  end

  def field
    # Head the page with a syllabus field label
    @h1 = params[:field]
    # Get the ids of all syllabi with this CIP code
    syllabus_ids = Syllabus.where(cip: params[:cip]).pluck(:id)
    # Then get all the books associated with those syllabus ids
    @books = Book.includes(:syllabi).where(syllabi: {id: syllabus_ids}).page params[:page]
  end
  
end
