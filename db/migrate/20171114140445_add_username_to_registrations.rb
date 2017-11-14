class AddUsernameToRegistrations < ActiveRecord::Migration[5.0]
  def change
    add_column :registrations, :username, :string
  end
end
