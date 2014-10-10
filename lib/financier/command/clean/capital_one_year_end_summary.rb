require 'csv'

module Financier
  module Command
    module Clean
      class CapitalOneYearEndSumary < CapitalOneBase

        REGEX = /^(?<month>\d+)\/(?<day>\d+)\ (?<payee>.*)\ (?<amount>-?\$[\d,]*\.\d*)$/

        def execute
          header "Clean Capital One Year End Sumary"
          raise_if_errors!

          process_file

          say "Cleaned file written to: #{out_filepath}", :green
        end

      end
    end
  end

end
