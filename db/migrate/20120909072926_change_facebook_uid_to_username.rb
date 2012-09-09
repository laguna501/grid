class ChangeFacebookUidToUsername < ActiveRecord::Migration
  def change
    rename_column :users, :facebook_uid, :username
  end
end
