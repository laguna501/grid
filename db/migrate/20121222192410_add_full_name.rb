class AddFullName < ActiveRecord::Migration
  def change
  	change_table(:users) do |t|
      t.string    "full_name"
    end
  end
end
