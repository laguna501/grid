class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string    :identifier,          :null => false
      t.string    :thumbnail
      t.string    :full
      t.integer   :user_id
      t.timestamps
    end
  end
end
