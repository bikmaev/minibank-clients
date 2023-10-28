class RenamePasswordToPasswordDigestInClients < ActiveRecord::Migration[7.1]
  def change
    rename_column :clients, :password, :password_digest
  end
end