require 'csv'

def main
  option = ARGV[0]
  year = ARGV[1]
  data_path = ARGV[2].gsub(/\\/,'/')

  if(option == '-e')
    yearly_stats(data_path, year)
  elsif(option == '-a')
    monthly_stats()
  elsif(option == '-c')
    graphical_stats()
  end


  
end

def yearly_stats(data_path, year)
  file_names_list = get_file_names(data_path, year)
  # puts 'files are', file_names_list

  # read the data from all yhe files in directory
  files_data = read_files_data(file_names_list, data_path)
  if( !files_data || files_data.length < 1)
    puts "no data found for matching files:"
    return
  end

  max_temperature_data = get_attribute_data(files_data, 'Max TemperatureC')
  max_temperature = max_temperature_data.max()
  puts "Highest: #{max_temperature}C"

  min_temperature_data = get_attribute_data(files_data, 'Min TemperatureC')
  min_temperature = min_temperature_data.min()
  puts "Lowest: #{min_temperature}C"

  max_humidity_data = get_attribute_data(files_data, 'Max Humidity')
  max_humidity = max_humidity_data.max()
  puts "Humid: #{max_humidity}%"


  # file_path = File.join( data_path, files[0] )
  # table = CSV.parse(File.read(file_path), headers: true)
  # puts "data is ", table[0]["Max TemperatureC"]
end



def get_file_names(folder_path, year)
 files =  Dir.entries(folder_path).select do |f|
     f.include?(year)
  end
  
 files
end

def read_files_data(files_names, data_path)
  files_names.map do |file|
    file_path = File.join(data_path, file)
    file_data = CSV.parse(File.read(file_path), headers: true)
    file_data
  end
end

def get_attribute_data(files_data, weather_factor)
  attr_data = files_data.map do |complete_file_data|
    complete_file_data.by_col[weather_factor].compact.map(&:to_i) 
  end
  # puts attr_data.flatten
  attr_data.flatten
end

def monthly_stats
  puts "this is monthly stats"
end

def graphical_stats
  puts "this is graphical stats"
end


main()
