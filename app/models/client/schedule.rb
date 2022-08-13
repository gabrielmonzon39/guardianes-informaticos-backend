class Client::Schedule < ApplicationRecord
  belongs_to :client, class_name: 'Client::Client', foreign_key: :client_clients_id
  validates :start, presence: true
  validates :end, presence: true
  validates :start, comparison: { less_than: :end }

  # make day of week an enum
  enum day_of_week: {
    sunday: 0,
    monday: 1,
    tuesday: 2,
    wednesday: 3,
    thursday: 4,
    friday: 5,
    saturday: 6
  }
end
