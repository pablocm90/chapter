class CreateBooks < ActiveRecord::Migration[5.0]
  def change
    create_table :books do |t|
      t.string :title
      t.string :description
      t.string :genre
      t.string :tags
      t.string :cover-pic
      t.string :quote-hover
      t.string :content-pdf
      t.string :content-epub

      t.timestamps
    end
  end
end
