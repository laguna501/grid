class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string    	:username
      t.string    	:social_type,      		:null => false
      t.string		:access_token
      t.integer		:user_id,          		:null => false
      t.timestamps
    end
  end
end
