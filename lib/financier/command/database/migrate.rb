require 'active_record'

module Financier
  module Command
    module Database
      class Migrate < Command::Base

        def execute
          confirm( "Connecting to DB" ) { db_connect! }
          #confirm( "Loading schema" ) { Financier::Database.load_schema }
          confirm( "Drop database #{config.database.database}" ) { Financier::Database.load_schema }
        end

      end
    end
  end
end
