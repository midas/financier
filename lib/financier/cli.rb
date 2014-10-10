module Financier
  class Cli < Thor

    autoload :Clean,   'financier/cli/clean'
    autoload :Convert, 'financier/cli/convert'

    include Acclimate::CliHelper

    desc 'clean SUBCOMMAND', "Clean financial flat-files making CSVs, etc"
    subcommand "clean", Financier::Cli::Clean

    desc 'convert SUBCOMMAND', "Convert financial files to other file formats"
    subcommand "convert", Financier::Cli::Convert

    #desc "console", "Load a console with seeding assets available"
    #long_desc <<-LONGDESC
      ##{env_option_description}
    #LONGDESC
    #env_option
    #def console
      #execute Financier::Command::Console
    #end

  end
end
