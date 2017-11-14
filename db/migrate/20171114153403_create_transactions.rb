class CreateTransactions < ActiveRecord::Migration[5.0]
  def change
    create_table :transactions do |t|
      t.references :user, foreign_key: true
      t.references :episode, foreign_key: true
      t.references :book, foreign_key: true

      t.timestamps
    end
  end
end
