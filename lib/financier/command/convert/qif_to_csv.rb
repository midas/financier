require 'qiflib'

module Financier
  module Command
    module Convert
      class QifToCsv < Command::Base

        include Financier::IoHelper

        def execute
          confirm "Parsing input files" do
            csv_lines
          end

          confirm "Writing CSV to '#{out_filepath}" do
            write_lines_to_file( out_filepath, csv_lines )
          end
        end

      protected

        def csv_lines
          @csv_lines ||= Qiflib::Util.transactions_to_csv( input_file_specs )
        end

        def input_file_specs
           [
             {
               filename: filepath.expand_path,
               owner: owner,
               source: source
             }
           ]
        end

        def owner
          config.owner
        end

        def source
          return Qiflib::SOURCE_IBANK if config.source == 'ibank'
          Qiflib::SOURCE_QUICKEN
        end

      end
    end
  end
end
