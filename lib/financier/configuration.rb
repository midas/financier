require 'hashie'

module Financier
  class Configuration < Hashie::Mash

    def initialize( options={} )
      super( options )
    end

    def slice( *keys )
      Financier::Configuration.new( select { |k,v| keys.map( &:to_s ).include?( k ) } )
    end

  end
end
