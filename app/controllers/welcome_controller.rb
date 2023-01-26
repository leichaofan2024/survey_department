class WelcomeController < ApplicationController

  def index
  end

  def export_excel
    # p = Axlsx::Package.new

    # p.workbook.add_worksheet(:name => "Pie Chart") do |sheet|
    #   sheet.add_row ["Simple Pie Chart"]
    #   %w(first second third).each { |label| sheet.add_row [label, rand(24)+1] }
    #   sheet.add_chart(Axlsx::Pie3DChart, :start_at => [0,5], :end_at => [10, 20], :title => "example 3: Pie Chart") do |chart|
    #     chart.add_series :data => sheet["B2:B4"], :labels => sheet["A2:A4"],  :colors => ['FF0000', '00FF00', '0000FF']
    #   end
    # end
    # a = p.serialize('/Users/superlei/Desktop/simple.xlsx')
    # flash[:success] = "表格已生成！请查看"
    # redirect_to '/'
    # render xlsx: 'buttons', template: 'welcome/export_excel'
    # respond_to do |format|
    #   format.xlsx
    # end
    render xlsx: "export_excel", disposition: 'inline', filename: '测试表'
  end

  def upload_file
    files = params[:attachment]
    @result = files[0]
    # @result = Roo::Spreadsheet.open(files[0])
    Rails.logger.info "@files：#{}"
    redirect_to upload_files_show_path(result: @result)
  end

  def upload_files_show
    @result = params[:result]
  end
end
