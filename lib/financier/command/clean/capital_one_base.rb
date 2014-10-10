require 'csv'

module Financier
  module Command
    module Clean
      class CapitalOneBase < Command::Base

        include Financier::IoHelper

        REGEX = /^(?<month>\d+)\/(?<day>\d+)\ (?<payee>.*)\ (?<amount>-?\$[\d,]*\.\d*)$/i

      protected

        def process_file
          confirm "Processing lines from '#{config.filepath}' as year #{config.year}" do
            process_lines
            if in_error_lines.size > 0
              raise Acclimate::ConfirmationError.new( "Lines failed to parse", finish_proc: error_finish_lambda )
            end
          end

          confirm "Sorting lines by date" do
            sort_lines
          end

          confirm "Writing CSV file" do
            write_array_lines_to_csv_file( out_filepath, lines.unshift( csv_header ))
          end
        end

        def process_lines
          File.readlines( filepath ).each do |line|
            original_line = line.strip.dup
            line = clean_line( line )

            begin
              match = REGEX.match( line )
              amount = clean_currency( match[:amount] )
              lines << [date_from_string( match[:month], match[:day] ).strftime( config.date_format ),
                        clean_payee( match[:payee] ),
                        amount,
                        credit_debit_from_amount( amount )].flatten
            rescue
              add_in_error_line( original_line )
            end
          end
        end

        def clean_line( line )
          line.strip
        end

        def clean_payee( payee )
          payee.strip
        end

        def date_from_string( month, day )
          month = Date.parse( "#{day} #{month} #{Date.today.year}" ).month
          year = month == 12 ? config.year : config.year + 1
          Date.new( year, month, day.to_i )
        end

        def sort_lines
          lines.sort! { |a,b| a.first <=> b.first }
        end

        def csv_header
          %w(Date Payee Amount Credit Debit)
        end

        def clean_currency( amount )
          amount.gsub( /\$|\,/, '' )
        end

        def credit_debit_from_amount( amount )
          if amount.include?( '-' )
            [amount.gsub( '-', '' ), nil]
          else
            [nil, amount]
          end
        end

        def error_finish_lambda
          ->{
            in_error_lines.each do |line|
              say_stderr( "  #{line}", :red )
            end
          }
        end

        def raise_if_errors!
          raise_unless_input_file_exists!
          raise_if_input_and_output_filepaths_collide!
        end

        def raise_unless_input_file_exists!
          return if filepath.file?
          raise "File '#{filepath.expand_path}' does not exist"
        end

        def raise_if_input_and_output_filepaths_collide!
          return unless filepath == out_filepath
          raise Acclimate::Error.new( "Input file and output file path are the same: #{filepath.expand_path}" )
        end

        def add_in_error_line( line )
          in_error_lines << line
        end

        def lines
          @lines ||= []
        end

        def in_error_lines
          @in_error_lines ||= []
        end

        def straddle_years?
          config.straddle_years
        end

      end
    end
  end

end
