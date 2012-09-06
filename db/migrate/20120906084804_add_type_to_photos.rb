class AddTypeToPhotos < ActiveRecord::Migration
  def change
  	change_table(:photos) do |t|
      t.string    "type"
    end
  end
end
