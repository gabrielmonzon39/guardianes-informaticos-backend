class CreateClientClients < ActiveRecord::Migration[7.0]
  def change
    create_table :client_clients do |t|
      t.string :name

      t.timestamps
    end
  end
end
