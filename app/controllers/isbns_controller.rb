class IsbnsController < ApplicationController
  before_action :set_isbn, only: [:show, :edit, :update, :destroy]

  # GET /isbns
  # GET /isbns.json
  def index
    @isbns = Isbn.all
  end

  # GET /isbns/1
  # GET /isbns/1.json
  def show
  end

  # GET /isbns/new
  def new
    @isbn = Isbn.new
  end

  # GET /isbns/1/edit
  def edit
  end

  # POST /isbns
  # POST /isbns.json
  def create
    @isbn = Isbn.new(isbn_params)

    respond_to do |format|
      if @isbn.save
        format.html { redirect_to @isbn, notice: 'Isbn was successfully created.' }
        format.json { render :show, status: :created, location: @isbn }
      else
        format.html { render :new }
        format.json { render json: @isbn.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /isbns/1
  # PATCH/PUT /isbns/1.json
  def update
    respond_to do |format|
      if @isbn.update(isbn_params)
        format.html { redirect_to @isbn, notice: 'Isbn was successfully updated.' }
        format.json { render :show, status: :ok, location: @isbn }
      else
        format.html { render :edit }
        format.json { render json: @isbn.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /isbns/1
  # DELETE /isbns/1.json
  def destroy
    @isbn.destroy
    respond_to do |format|
      format.html { redirect_to isbns_url, notice: 'Isbn was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_isbn
      @isbn = Isbn.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def isbn_params
      params.require(:isbn).permit(:book_id, :code)
    end
end
