module Financier
  class Cli
    class Convert < Thor

      include Acclimate::CliHelper

      def self.banner( command, namespace=nil, subcommand=false )
        return "#{basename} convert help [SUBCOMMAND]" if command.name == 'help'
        "#{basename} #{command.usage}"
      end

      desc "convert qif-to-csv", "Convert an iBank or Quicken QIF to CSV"
      long_desc <<-LONGDESC
      LONGDESC
      option :source, type: :string, desc: "The source of the QIF (ibank or quicken)", aliases: '-s', default: 'ibank'
      option :owner, type: :string, desc: "The owner of the transactions", aliases: '-o', default: 'cjh'
      def qif_to_csv( filepath )
        execute Financier::Command::Convert::QifToCsv, filepath: filepath
      end

    end
  end
end
