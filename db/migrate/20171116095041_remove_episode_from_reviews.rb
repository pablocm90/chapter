class RemoveEpisodeFromReviews < ActiveRecord::Migration[5.0]
  def change
    remove_column :reviews, :episode_id
  end
end
