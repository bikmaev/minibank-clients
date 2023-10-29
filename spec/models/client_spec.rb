# clients/spec/models/client_spec.rb
require 'rails_helper'

RSpec.describe Client, type: :model do
  it 'is valid with valid attributes' do
    client = FactoryBot.build(:client, full_name: 'Петров Иван Васильевич11', login: 'petrov11', email: 'petr11@host.com', password: 'password11')
    expect(client).to be_valid
  end

  it 'is not valid without a full_name' do
    client = FactoryBot.build(:client, full_name: nil, login: 'petrov12', email: 'petr12@host.com', password: 'password12')
    expect(client).to_not be_valid
  end

  it 'is not valid without a login' do
    client = FactoryBot.build(:client, full_name: 'Петров Иван Васильевич13', login: nil, email: 'petr13@host.com', password: 'password13')
    expect(client).to_not be_valid
  end

  it 'is not valid without an email' do
    client = FactoryBot.build(:client, full_name: 'Петров Иван Васильевич14', login: 'petrov14', email: nil, password: 'password14')
    expect(client).to_not be_valid
  end

  it 'is not valid without a password' do
    client = FactoryBot.build(:client, full_name: 'Петров Иван Васильевич15', login: 'petrov15', email: 'petr15@host.com', password: nil)
    expect(client).to_not be_valid
  end
end
