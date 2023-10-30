class AddUniqueIndexToClients < ActiveRecord::Migration[7.1]
  def change
    add_index :clients, :login, unique: true
    add_index :clients, :email, unique: true
  end
end
