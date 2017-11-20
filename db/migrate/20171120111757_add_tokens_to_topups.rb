class AddTokensToTopups < ActiveRecord::Migration[5.0]
  def change
    add_column :topups, :tokens, :float
  end
end
