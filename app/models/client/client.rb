class Client::Client < ApplicationRecord
  validates :name, presence: true
  has_many :workers, class_name: 'Worker::Worker', foreign_key: 'client_clients_id'
  has_many :schedules, class_name: 'Client::Schedule', dependent: :destroy, foreign_key: 'client_clients_id'
end
