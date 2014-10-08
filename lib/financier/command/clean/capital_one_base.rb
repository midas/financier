require 'csv'

module Financier
  module Command
    module Clean
      class CapitalOneBase < Command::Base

        REGEX = /^\d+\ (?<day>\d{2})\ (?<month>\w{3})\ (?<payee>.+)\s+\$(?<amount>.+)$/

      protected

        def process_file
          confirm "Processing lines from '#{config.filepath}' as year #{config.year}" do
            process_lines
            if in_error_lines.size > 0
              raise Financier::ConfirmationError.new( "Lines failed to parse", error_finish_lambda )
            end
          end

          confirm "Sorting lines by date" do
            sort_lines
          end

          confirm "Writing CSV file" do
            write_csv_file
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
              binding.pry
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

        def write_csv_file
          CSV.open( out_filepath, 'w' ) do |csv|
            csv << csv_header

            lines.each do |line|
              csv << line
            end
          end
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
          raise Financier::Error.new( "Input file and output file path are the same: #{filepath.expand_path}" )
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

        def filepath
          @filepath ||= Pathname.new( config.filepath )
        end

        def out_filepath
          @out_filepath = Pathname.new( File.join( File.dirname( filepath ) ,
                                                   "#{File.basename( filepath.expand_path, '.*' )}.csv" ))
        end

        def straddle_years?
          config.straddle_years
        end

      end
    end
  end

end
