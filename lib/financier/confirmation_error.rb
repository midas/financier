module Financier
  class ConfirmationError < StandardError

    def initialize( message, finish_proc=nil )
      @finish_proc = finish_proc

      super( message )
    end

    def finish
      return unless finish_proc
      finish_proc.call
    end
  protected

    attr_reader :finish_proc

  end
end
