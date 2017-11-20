class RemovePriceFromEpisodes < ActiveRecord::Migration[5.0]
  def change
    remove_column :episodes, :price, :float
  end
end
