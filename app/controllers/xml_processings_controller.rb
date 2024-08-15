class XmlProcessingsController < ApplicationController
  before_action :set_xml_processing, only: %i[ show edit update destroy ]

  # GET /xml_processings or /xml_processings.json
  def index
    @xml_processings = XmlProcessing.all
  end

  # GET /xml_processings/1 or /xml_processings/1.json
  def show
  end

  # GET /xml_processings/new
  def new
    @xml_processing = XmlProcessing.new
  end

  # GET /xml_processings/1/edit
  def edit
  end

  # POST /xml_processings or /xml_processings.json
  def create
    @xml_processing = XmlProcessing.new(xml_processing_params)

    respond_to do |format|
      if @xml_processing.save
        format.html { redirect_to xml_processing_url(@xml_processing), notice: "Xml processing was successfully created." }
        format.json { render :show, status: :created, location: @xml_processing }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @xml_processing.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /xml_processings/1 or /xml_processings/1.json
  def update
    respond_to do |format|
      if @xml_processing.update(xml_processing_params)
        format.html { redirect_to xml_processing_url(@xml_processing), notice: "Xml processing was successfully updated." }
        format.json { render :show, status: :ok, location: @xml_processing }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @xml_processing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /xml_processings/1 or /xml_processings/1.json
  def destroy
    @xml_processing.destroy

    respond_to do |format|
      format.html { redirect_to xml_processings_url, notice: "Xml processing was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_xml_processing
      @xml_processing = XmlProcessing.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def xml_processing_params
      params.fetch(:xml_processing, {})
    end
end
