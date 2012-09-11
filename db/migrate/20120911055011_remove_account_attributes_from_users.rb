class RemoveAccountAttributesFromUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.remove :username
      t.remove :social_type
      t.remove :access_token
    end
  end
end
