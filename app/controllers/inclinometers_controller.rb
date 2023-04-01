class InclinometersController < ApplicationController
  def index
  end

  def upload_file
    files = params[:attachment].dup
    xlsxes = files.map{|x| [x.original_filename, Roo::Spreadsheet.open(x).sheet(0)]} rescue nil
    raise "文件无法读取，可用办公软件打开、保存之后再尝试操作！" unless xlsxes.present?
    @result_table = Inclinometer.data_process(xlsxes)
    flash[:success] = '数据导入成功！'
  rescue => e
    flash[:danger] = "数据导入失败！#{e.message}"
    redirect_to inclinometers_path
  end

  def download_file
    result_table = JSON.parse(params[:result_table].dup)["result_table"]
    @result_table = result_table
    render xlsx: "download_file", disposition: 'inline', filename: '测斜成果表'
  end

end
