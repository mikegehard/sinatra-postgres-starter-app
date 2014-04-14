require 'spec_helper'
require 'bcrypt'

describe 'User Repository' do

  before do
    DB[:users].delete
  end

  it 'Stores username and password' do
    id = UserRepository.create('joe@example.com', 'password')
    expect(UserRepository.find(id).email).to eq('joe@example.com')
    password_hash = BCrypt::Password.new(UserRepository.find(id).password)
    expect(password_hash).to eq('password')
  end
end