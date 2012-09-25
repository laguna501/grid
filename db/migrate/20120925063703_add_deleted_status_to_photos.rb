class AddDeletedStatusToPhotos < ActiveRecord::Migration
  def change
    change_table(:photos) do |t|
      t.boolean :deleted, default: false
    end
  end
end
