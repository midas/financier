module Financier
  class Cli < Thor

    autoload :Clean, 'financier/cli/clean'

    include CliHelper
    include Thor::Actions

    desc 'clean SUBCOMMAND', "Cleans financial flat-files making CSVs, etc"
    subcommand "clean", Financier::Cli::Clean

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
