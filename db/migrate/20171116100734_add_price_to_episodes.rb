class AddPriceToEpisodes < ActiveRecord::Migration[5.0]
  def change
    add_column :episodes, :price, :float
  end
end
