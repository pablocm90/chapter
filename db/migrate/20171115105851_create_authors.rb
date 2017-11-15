class CreateAuthors < ActiveRecord::Migration[5.0]
  def change
    create_table :authors do |t|
      t.string :nom_de_plume
      t.string :bank_account
      t.string :status
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
