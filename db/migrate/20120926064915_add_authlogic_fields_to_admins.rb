class AddAuthlogicFieldsToAdmins < ActiveRecord::Migration
  def change
    rename_column :admins, :password, :crypted_password

    change_table(:admins) do |t|
      t.string    :password_salt,       :null => false
      t.string    :persistence_token,   :null => false
      t.string    :perishable_token,    :null => false
    end
  end
end
