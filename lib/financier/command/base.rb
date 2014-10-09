module Financier
  module Command
    class Base < Acclimate::Command

    protected

      def config_klass
        Financier::Configuration
      end

    end
  end
end
