require 'csv'

module Financier
  module Command
    module Clean
      class CapitalOneStatement < CapitalOneBase

        REGEX = /^\d+\ (?<day>\d{2})\ (?<month>\w{3})\ (?<payee>.+)\s+\$(?<amount>.+)$/

        def execute
          header "Clean Capital One Statement"
          raise_if_errors!

          process_file

          say "Cleaned file written to: #{out_filepath}", :green
        end

      protected

        def clean_line( line )
          line.strip.
               gsub( '($', '$-' ).
               gsub( /\)$/, '' )
        end

      end
    end
  end
end
