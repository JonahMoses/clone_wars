require 'bundler'
Bundler.require

module LeCentral

  class Database

    def self.database
      @database ||= Sequel.sqlite('lib/le_central/db/database.sqlite3')
    end

    def self.create_menu_items_table
      database.create_table? :menu_items do
        primary_key :id
        Integer     :active
        String      :meal,        :size => 10
        String      :course,      :size => 30
        String      :name,        :size => 50
        String      :description, :size => 200
        String      :price,       :size => 20
        DateTime    :created_at
        DateTime    :updated_at
      end
    end

    def self.menu_items_table
      if database.table_exists?(:menu_items)
        database.from(:menu_items)
      else
        create_menu_items_table
        database.from(:menu_items)
      end
    end

  end

end
