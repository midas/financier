require 'financier/version'
require 'pry-debugger'
require 'rainbow'
require 'thor'

module Financier

  autoload :Cli,               'financier/cli'
  autoload :CliHelper,         'financier/cli_helper'
  autoload :Command,           'financier/command'
  autoload :Configuration,     'financier/configuration'
  autoload :ConfirmationError, 'financier/confirmation_error'
  autoload :Error,             'financier/error'
  autoload :Output,            'financier/output'

end
