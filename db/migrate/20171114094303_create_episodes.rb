class CreateEpisodes < ActiveRecord::Migration[5.0]
  def change
    create_table :episodes do |t|
      t.string :title
      t.string :content
      t.string :description
      t.string :content_pdf
      t.string :content_epub
      t.string :number
      t.references :book, foreign_key: true

      t.timestamps
    end
  end
end
