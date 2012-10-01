class AddHighlightedToPhotos < ActiveRecord::Migration
  def change
    change_table(:photos) do |t|
      t.boolean :highlighted, default: false
    end
  end
end
