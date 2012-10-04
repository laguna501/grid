class DefaultCharacterSet < ActiveRecord::Migration
  def self.up
    tables.each do |table|
      execute "alter table #{table} character set utf8"
    end
  end

  def self.down
    # i don't want to go back to latin1
  end
end
