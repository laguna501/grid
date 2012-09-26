class AddActiveFieldToAdmins < ActiveRecord::Migration
  def change
  	change_table(:admins) do |t|
      t.boolean  "active",                           :default => true
    end
  end
end
