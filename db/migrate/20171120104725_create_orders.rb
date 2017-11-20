class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.string :state
      t.string :topup_sku
      t.monetize :amount, currency: { present: false }
      t.jsonb :payment

      t.timestamps
    end
  end
end
