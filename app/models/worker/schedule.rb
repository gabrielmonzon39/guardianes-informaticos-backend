class Worker::Schedule < ApplicationRecord
  belongs_to :worker, class_name: 'Worker::Worker', foreign_key: :worker_workers_id
  validates :time, presence: true
  validate :valid_time?

  def day_of_week
    time.strftime('%A').downcase.to_sym
  end

  def hour
    time.strftime('%H').to_i
  end

  def valid_time?
    return false if worker.nil? || worker.client.nil?

    client = worker.client

    client_schedules = client.schedules.where(day_of_week: day_of_week)
    client_schedules.each do |client_schedule|
      return true if client_schedule.start <= hour && client_schedule.end >= hour
    end
    errors.add(:time, "client #{client.name} does not have a schedule for #{day_of_week} at #{hour}")
    false
  end
end
