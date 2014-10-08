module Financier
  class Cli
    class Clean < Thor

      include CliHelper

      def self.banner( command, namespace=nil, subcommand=false )
        return "#{basename} clean help [SUBCOMMAND]" if command.name == 'help'
        "#{basename} #{command.usage}"
      end

      desc "clean capitol-one-year-end-summary", "Cleans a text file created from Captiol One year end summary"
      long_desc <<-LONGDESC
        Cleans a text file created from Captiol One's Year End Summary converting it into a CSV ready to import
        into other applications.

        The flat file is created by manually cutting a pasting the tabular sections of data into a text file.
      LONGDESC
      option :date_format, type: :string, desc: "The date format to output", aliases: '-d', default: "%Y-%m-%d"
      option :year, type: :string, desc: "The year to process the file as", aliases: '-y', default: Time.now.year.to_s
      def capitol_one_year_end_summary( filepath )
        execute Financier::Command::Clean::CapitolOneYearEndSumary, filepath: filepath
      end

    end
  end
end
