class AddTypeToAccounts < ActiveRecord::Migration
  def change
    change_table(:accounts, bulk: true) do |t|
      t.string :type
    end
  end
end
