class CreateTopups < ActiveRecord::Migration[5.0]
  def change
    create_table :topups do |t|
      t.string :sku
      t.string :name
      t.timestamps
    end
  end
end
