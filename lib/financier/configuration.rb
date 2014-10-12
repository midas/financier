require 'pathname'

module Financier
  class Configuration < Acclimate::Configuration

  protected

    def self.config_filepath
      @@config_filepath ||= Pathname.new( '.financier' )
    end

  end
end
