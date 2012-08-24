class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string    :email,               :null => false
      t.string    :facebook_uid,        :null => false
      t.string    :type,                :null => false
      t.timestamps
    end
  end
end
