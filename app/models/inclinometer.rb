class Inclinometer < ApplicationRecord

  def self.data_process(xlsxes)
    @coordinate_hash = Hash.new
    @inclinometer_hash = Hash.new
    xlsxes.each do |xlsx|
      @xlsx_name = xlsx[0].split('.')[0]
      if @xlsx_name == "坐标"
        self.coordinate_file_process(xlsx)
      else
        self.inclinometer_file_process(xlsx)
      end
    end
    raise "请导入文件名为“坐标“的坐标文件" if @coordinate_hash.empty?
    raise "测斜文件名和坐标点名不一致，请核对！坐标点名：#{@coordinate_hash.keys}，测斜孔名：#{@inclinometer_hash.keys}" unless @coordinate_hash.keys == @inclinometer_hash.keys
    result = self.merge_in_one_table
    return result
  end


  def self.coordinate_file_process(xlsx)
    (1..xlsx[1].last_row).each do |n|
      one_row_data = xlsx[1].row(n)
      @coordinate_hash[one_row_data.first] = one_row_data.last(3)
    end
  end

  def self.inclinometer_file_process(xlsx)
    @inclinometer_hash[@xlsx_name] = Array.new
    (4..xlsx[1].last_row).each do |n|
      @inclinometer_hash[@xlsx_name] << xlsx[1].row(n)
    end
  end

  def self.merge_in_one_table
    data_table = Array.new
    data_table << ["点名", "X", "Y", "Z", "NO.", "Depth(m)", "Dip", "AZ", "G Total", "Mag Total", "Lx(m)", "Ly(m)", "Lz(m)"]
    @inclinometer_hash.keys.each do |hole_name|
      coordinate = @coordinate_hash[hole_name] || [0, 0, 0]
      data_table << [hole_name, coordinate[0].round(3), coordinate[1].round(3), coordinate[2].round(3)]
      @inclinometer_hash[hole_name].each do |one_measure_data|
        one_row_table = Array.new
        one_row_table << nil
        one_row_table << (coordinate[0].to_f + one_measure_data[7].to_f).round(3)
        one_row_table << (coordinate[1].to_f + one_measure_data[6].to_f).round(3)
        one_row_table << (coordinate[2].to_f + one_measure_data[8].to_f).round(3)
        one_row_table << one_measure_data[0]
        one_row_table << one_measure_data[1]
        one_row_table << one_measure_data[2]
        one_row_table << one_measure_data[3]
        one_row_table << one_measure_data[4]
        one_row_table << one_measure_data[5]
        one_row_table << one_measure_data[6]
        one_row_table << one_measure_data[7]
        one_row_table << one_measure_data[8]
        data_table << one_row_table
      end
    end
    return data_table

  end

end
