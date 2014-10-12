module Financier
  module Command
    class Base < Acclimate::Command

    protected

      def config_klass
        Financier::Configuration
      end

      def db_connect!
        Financier::Database.connect( config.database )
      end

    end
  end
end
