class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.string :txref
      t.string :action_type
      t.float :amount
      t.string :asset

      t.timestamps
    end
  end
end
