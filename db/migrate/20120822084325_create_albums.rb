class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.integer    :facebook_aid,   :null => false
      t.integer    :user_id,        :null => false
      t.timestamps
    end
  end
end
