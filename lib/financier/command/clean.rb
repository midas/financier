module Financier
  module Command
    module Clean

      autoload :CapitalOneBase,          'financier/command/clean/capital_one_base'
      autoload :CapitalOneYearEndSumary, 'financier/command/clean/capital_one_year_end_summary'
      autoload :CapitalOneStatement,     'financier/command/clean/capital_one_statement'

    end
  end
end
