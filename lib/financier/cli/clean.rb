module Financier
  class Cli
    class Clean < Thor

      include CliHelper

      def self.banner( command, namespace=nil, subcommand=false )
        return "#{basename} clean help [SUBCOMMAND]" if command.name == 'help'
        "#{basename} #{command.usage}"
      end

      def self.date_format_option
        option :date_format, type: :string, desc: "The date format to output", aliases: '-d', default: "%Y-%m-%d"
      end

      def self.year_option
        option :year, type: :numeric, desc: "The year to process the file as", aliases: '-y', default: Time.now.year
      end

      desc "clean capitol-one-year-end-summary", "Cleans a text file created from Capitol One year end summary"
      long_desc <<-LONGDESC
        Cleans a text file created from Captiol One's Year End Summary converting it into a CSV ready to import
        into other applications.

        The flat file is created by manually cutting a pasting the tabular sections of data into a text file.
      LONGDESC
      date_format_option
      year_option
      def capitol_one_year_end_summary( filepath )
        execute Financier::Command::Clean::CapitolOneYearEndSumary, filepath: filepath
      end

      desc "clean capital-one-statement", "Cleans a text file created from Capital One monthly statment"
      long_desc <<-LONGDESC
        Cleans a text file created from Captial One's monthly statement converting it into a CSV ready to import
        into other applications.

        The flat file is created by using docsplit to extract text from PDF statement and then manually formatting some
        lines.  The eventual line looks something like:

        149 12 JAN KIRKLANDS #685THE WOODLANDSTX     $40.68

        When --straddle-years[-s], the --year will be applied to the December transactions and the --year + 1 will be
        applied to January transactions.
      LONGDESC
      date_format_option
      year_option
      option :straddle_year, type: :boolean, desc: "When true, statment straddles years (in December)", aliases: '-s'
      def capital_one_statement( filepath )
        execute Financier::Command::Clean::CapitalOneStatement, filepath: filepath
      end

    end
  end
end
