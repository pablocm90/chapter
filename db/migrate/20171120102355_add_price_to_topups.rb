class AddPriceToTopups < ActiveRecord::Migration[5.0]
  def change
    add_monetize :topups, :price, currency: { present: false }
  end
end
