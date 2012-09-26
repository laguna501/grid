class RemovePasswordConfirmationFromAdmins < ActiveRecord::Migration
  def change
    change_table :admins do |t|
      t.remove :password_confirmation
    end
  end
end
