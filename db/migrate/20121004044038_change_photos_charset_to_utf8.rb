class ChangePhotosCharsetToUtf8 < ActiveRecord::Migration
  def self.up
    tables.each do |table|
      execute "alter table photos modify description text character set utf8"
    end
  end

  def self.down
    # i don't want to go back to latin1
  end
end
