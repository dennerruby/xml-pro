class XmlProcessingsController < ApplicationController
  before_action :set_xml_processing, only: %i[ show edit update destroy ]

  # GET /xml_processings or /xml_processings.json
  def index
    @xml_processings = XmlProcessing.all
  end

  # GET /xml_processings/1 or /xml_processings/1.json
  def show
    @xml_processing = XmlProcessing.find(params[:id])
    if @xml_processing.xml_file.attached?
      @report_data = []
      @xml_processing.xml_file.each do |xml_file|
        xml_content = xml_file.download
        @parsed_xml = Nokogiri::XML(xml_content)
        @report_data << extract_report_data(@parsed_xml)
      end
    end
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
    if @xml_processing.save
      redirect_to @xml_processing, notice: 'Upload do XML feito com sucesso.'
    else
      render :new
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
    params.require(:xml_processing).permit(xml_file: [])
  end

  def extract_report_data(parsed_xml)
    # byebug
    report_data = {}
    report_data[:series] = parsed_xml.search('serie').text
    report_data[:invoice_number] = parsed_xml.search('nNF').text
    report_data[:date_time_issue] = parsed_xml.search('dhEmi').text
    report_data[:issuer_data] = parsed_xml.search('emit').text
    # dados do emitente
    report_data[:cnpj] = parsed_xml.at('CNPJ').text
    report_data[:xnome] = parsed_xml.at('xNome').text
    report_data[:xfant] = parsed_xml.at('xFant').text
    enderEmit = parsed_xml.at('enderEmit')
    report_data[:xlgr] = enderEmit.at('xLgr').text
    report_data[:nro] = enderEmit.at('nro').text
    report_data[:xcpl] = enderEmit.at('xCpl').text
    report_data[:xbairro] = enderEmit.at('xBairro').text
    report_data[:cmun] = enderEmit.at('cMun').text
    report_data[:xmun] = enderEmit.at('xMun').text
    report_data[:uf] = enderEmit.at('UF').text
    report_data[:cep] = enderEmit.at('CEP').text
    report_data[:cpais] = enderEmit.at('cPais').text
    report_data[:xpais] = enderEmit.at('xPais').text
    report_data[:fone] = enderEmit.at('fone').text
    report_data[:ie] = parsed_xml.at('IE').text
    report_data[:crt] = parsed_xml.at('CRT').text
    # fim dos dados do emitente
    #############################
    # Dados do destinatário
    enderDest = parsed_xml.at('enderDest')
    report_data[:dest_cnpj] = parsed_xml.at('CNPJ').text
    report_data[:dest_xnome] = parsed_xml.at('xNome').text
    report_data[:dest_xlgr] = enderDest.at('xLgr').text
    report_data[:dest_nro] = enderDest.at('nro').text
    report_data[:dest_xbairro] = enderDest.at('xBairro').text
    report_data[:dest_cmun] = enderDest.at('cMun').text
    report_data[:dest_xmun] = enderDest.at('xMun').text
    report_data[:dest_uf] = enderDest.at('UF').text
    report_data[:dest_cep] = enderDest.at('CEP').text
    report_data[:dest_cpais] = enderDest.at('cPais').text
    report_data[:dest_xpais] = enderDest.at('xPais').text
    report_data[:indiedest] = parsed_xml.at('indIEDest').text
    # Fim dos dados do destinatário
    report_data[:product_description] = parsed_xml.search('xProd').text
    report_data[:ncm] = parsed_xml.search('NCM').map(&:text).join("\n")
    report_data[:cfop] = parsed_xml.search('CFOP').map(&:text).join("\n")
    report_data[:ucom] = parsed_xml.search('uCom').map(&:text).join("\n")
    report_data[:qcom] = parsed_xml.search('qCom').map(&:text).join("\n")
    report_data[:vuncom] = parsed_xml.search('vUnCom').text
    report_data[:vicms] = parsed_xml.search('vICMS').text
    report_data[:vipi] = parsed_xml.search('vIPI').text
    report_data[:vpis] = parsed_xml.search('vIPIS').text
    report_data[:vcofins] = parsed_xml.search('vCOFINS').text
    report_data
  end
end
