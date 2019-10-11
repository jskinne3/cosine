class SyllabiController < ApplicationController
  before_action :set_syllabus, only: [:show, :edit, :update, :destroy]

  # GET /syllabi
  # GET /syllabi.json
  def index
    @syllabi = Syllabus.all.page params[:page]
  end

  # GET /syllabi/1
  # GET /syllabi/1.json
  def show
  end

  # GET /syllabi/new
  def new
    @syllabus = Syllabus.new
  end

  # GET /syllabi/1/edit
  def edit
  end

  # POST /syllabi
  # POST /syllabi.json
  def create
    @syllabus = Syllabus.new(syllabus_params)

    respond_to do |format|
      if @syllabus.save
        format.html { redirect_to @syllabus, notice: 'Syllabus was successfully created.' }
        format.json { render :show, status: :created, location: @syllabus }
      else
        format.html { render :new }
        format.json { render json: @syllabus.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /syllabi/1
  # PATCH/PUT /syllabi/1.json
  def update
    respond_to do |format|
      if @syllabus.update(syllabus_params)
        format.html { redirect_to @syllabus, notice: 'Syllabus was successfully updated.' }
        format.json { render :show, status: :ok, location: @syllabus }
      else
        format.html { render :edit }
        format.json { render json: @syllabus.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /syllabi/1
  # DELETE /syllabi/1.json
  def destroy
    @syllabus.destroy
    respond_to do |format|
      format.html { redirect_to syllabi_url, notice: 'Syllabus was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_syllabus
      @syllabus = Syllabus.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def syllabus_params
      params.require(:syllabus).permit(:osp_doc_id, :institution, :year)
    end
end
