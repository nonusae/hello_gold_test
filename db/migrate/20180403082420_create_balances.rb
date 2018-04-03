class CreateBalances < ActiveRecord::Migration[5.2]
  def change
    create_table :balances do |t|
      t.string :asset_type
      t.float :amount , default: 0

      t.timestamps
    end
  end
end
