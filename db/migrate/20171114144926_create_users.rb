class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :picture
      t.string :description
      t.boolean :active
      t.boolean :is_author, default: false
      t.string :fav_genre
      t.string :f_name
      t.string :l_name
      t.references :registration, foreign_key: true
      t.boolean :status

      t.timestamps
    end
  end
end
