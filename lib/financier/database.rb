require 'active_record'

module Financier
  class Database

    def self.connect( config )
      if config['adapter'] == 'sqlite3'
        require 'sqlite3'
      elsif config['adapter'] == 'postgresql'
        require 'pg'
      else
        raise_error "#{config['adapter']} adapter is not recognized"
      end

      base.establish_connection( config )
    end

    #def self.console_connect
      #connect( Financier::Configuration.new( {} ).meta_database )
    #end

    def self.drop( config )
      silence_stream STDOUT do
        cn.drop_database( config.database ) rescue nil
      end
    end

    def self.load_schema
      silence_stream STDOUT do
        ActiveRecord::Schema.define do
          create_table :transactions do |t|
            t.string :acct_name, limit: 100
            t.string :acct_type, limit: 100
            t.date :date
            t.column :amount, :decimal, precision: 12, scale: 2
            t.string :number, limit: 10
            t.string :category, limit: 100
            t.string :payee, limit: 100
            t.string :memo, limit: 100
            t.column :split1_amount, :decimal, precision: 12, scale: 2
            t.string :split1_category, limit: 100
            t.string :split1_memo, limit: 100
            t.column :split2_amount, :decimal, precision: 12, scale: 2
            t.string :split2_category, limit: 100
            t.string :split2_memo, limit: 100
            t.column :split3_amount, :decimal, precision: 12, scale: 2
            t.string :split3_category, limit: 100
            t.string :split3_memo, limit: 100
          end
        end
      end
    end

    def self.base
      ActiveRecord::Base
    end

    def self.cn
      base::connection
    end

  end
end
