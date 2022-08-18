class CreateWorkerWorkers < ActiveRecord::Migration[7.0]
  def change
    create_table :worker_workers do |t|
      t.string :name
      t.string :color
      t.references :client_clients, null: false, foreign_key: true

      t.timestamps
    end
  end
end
