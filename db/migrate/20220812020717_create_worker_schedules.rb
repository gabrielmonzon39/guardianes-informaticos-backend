class CreateWorkerSchedules < ActiveRecord::Migration[7.0]
  def change
    create_table :worker_schedules do |t|
      t.timestamp :time
      t.boolean :confirmed, default: false
      t.references :worker_workers, null: false, foreign_key: true

      t.timestamps
    end
  end
end
