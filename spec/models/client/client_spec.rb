require 'rails_helper'

RSpec.describe 'Client::Client', type: :model do
  it 'needs a name' do
    client = Client::Client.new
    expect(client).not_to be_valid
  end
end
