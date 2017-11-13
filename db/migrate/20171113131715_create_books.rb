class CreateBooks < ActiveRecord::Migration[5.0]
  def change
    create_table :books do |t|
      t.string :title
      t.string :description
      t.string :genre
      t.string :tags
      t.string :cover_pic
      t.string :quote_hover
      t.string :content_pdf
      t.string :content_epub

      t.timestamps
    end
  end
end
