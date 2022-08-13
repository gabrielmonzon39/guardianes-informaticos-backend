require 'rails_helper'

RSpec.describe Client::Schedule, type: :model do
  fixtures :all

  it 'needs to have a valid start and end' do
    schedule = Client::Schedule.first
    expect(schedule).to be_valid

    schedule.end = schedule.start - 1.hour
    expect(schedule).not_to be_valid

    schedule.start = nil
    expect(schedule).not_to be_valid

    schedule.end = nil
    expect(schedule).not_to be_valid
  end

  it 'needs to have a valid client' do
    schedule = Client::Schedule.first
    expect(schedule).to be_valid

    schedule.client_clients_id = 100
    expect(schedule).not_to be_valid
  end
end
