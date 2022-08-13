class CreateClientSchedules < ActiveRecord::Migration[7.0]
  def change
    create_table :client_schedules do |t|
      t.integer :day_of_week
      t.integer :start
      t.integer :end
      t.references :client_clients, null: false, foreign_key: true

      t.timestamps
    end
  end
end
