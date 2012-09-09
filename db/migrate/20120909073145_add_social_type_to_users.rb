class AddSocialTypeToUsers < ActiveRecord::Migration
  def change
  	change_table(:users) do |t|
      t.text    "social_type"
    end
  end
end
