module Financier
  class Cli
    class Database < Thor

      include Acclimate::CliHelper

      def self.banner( command, namespace=nil, subcommand=false )
        return "#{basename} database help [SUBCOMMAND]" if command.name == 'help'
        "#{basename} #{command.usage}"
      end

      desc "databse migrate", "Migrate the database"
      long_desc <<-LONGDESC
      LONGDESC
      option :down, type: :boolean, desc: 'Migrate database downward'
      option :env, type: :string, desc: 'The environment to execute in', default: 'development'
      def migrate
        execute Financier::Command::Database::Migrate
      end

    end
  end
end
