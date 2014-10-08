module Financier
  class Error < StandardError

    def initialize( message, handled=false )
      @handled = handled

      super( message )
    end

    def handled?
      handled
    end

  protected

    attr_reader :handled

  end
end
