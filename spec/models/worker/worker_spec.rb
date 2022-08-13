require 'rails_helper'

RSpec.describe Worker::Worker, type: :model do
  fixtures :all

  it 'needs a name' do
    worker = Worker::Worker.new
    expect(worker).not_to be_valid
  end

  it 'needs a valid client' do
    worker = Worker::Worker.new(name: 'Worker')
    expect(worker).not_to be_valid

    worker = Worker::Worker.new(name: 'Worker', client_clients_id: 100)
    expect(worker).not_to be_valid

    client = Client::Client.first
    worker = Worker::Worker.new(name: 'Worker', client_clients_id: client.id)
    expect(worker).to be_valid
  end
end
