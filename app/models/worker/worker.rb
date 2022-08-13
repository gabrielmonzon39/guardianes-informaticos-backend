class Worker::Worker < ApplicationRecord
  belongs_to :client, class_name: 'Client::Client', foreign_key: :client_clients_id
  has_many :schedules, class_name: 'Worker::Schedule', dependent: :destroy, foreign_key: 'worker_workers_id'
end
