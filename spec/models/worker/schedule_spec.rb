require 'rails_helper'

RSpec.describe Worker::Schedule, type: :model do
  fixtures :all

  it 'needs to have a valid time' do
    schedule = Worker::Schedule.first
    expect(schedule).to be_valid
  end

  it 'needs to have a valid worker' do
    schedule = Worker::Schedule.first
    expect(schedule).to be_valid

    schedule.worker_workers_id = 100
    expect(schedule).not_to be_valid
  end

  it 'needs to have a valid time with a client schedule' do
    schedule = Worker::Schedule.first
    expect(schedule).to be_valid

    schedule.time = schedule.time + 1.day
    expect(schedule).not_to be_valid
  end

  it 'needs to be unconfirmed at creation' do
    schedule = Worker::Schedule.new
    expect(schedule.confirmed).to be false
  end
end
