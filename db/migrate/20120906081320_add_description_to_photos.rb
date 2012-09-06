class AddDescriptionToPhotos < ActiveRecord::Migration
  def change
  	change_table(:photos) do |t|
      t.text    "description"
    end
  end
end
