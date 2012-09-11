class RenameUserIdToAccountIdOnPhoto < ActiveRecord::Migration
  def change
    rename_column :photos, :user_id, :account_id
  end
end
