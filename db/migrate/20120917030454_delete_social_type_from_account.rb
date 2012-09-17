class DeleteSocialTypeFromAccount < ActiveRecord::Migration
  def change
    change_table :accounts do |t|
      t.remove :social_type
    end
  end
end
