module Financier
  module IoHelper

    def filepath
      @filepath ||= Pathname.new( config.filepath )
    end

    def out_filepath
      @out_filepath = Pathname.new( File.join( File.dirname( filepath ) ,
                                               "#{File.basename( filepath.expand_path, '.*' )}.csv" ))
    end

    def write_array_lines_to_csv_file( filepath, lines )
      CSV.open( filepath, 'w' ) do |csv|
        lines.each do |line|
          csv << line
        end
      end
    end

    def write_lines_to_file( filepath, lines )
      File.open( filepath, 'w' ) do |file|
        lines.each do |line|
          file.puts( line )
        end
      end
    end

  end
end
