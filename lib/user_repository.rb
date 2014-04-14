require 'bcrypt'

class UserRepository

  class << self
    attr_reader :db

    def attach_db(db)
      @db = db[:users]
    end

    def create(email, password)
      password_hash = BCrypt::Password.create(password)
      db.insert(:email => email, :password_hash => password_hash)
    end

    def find(id)
      new(@db[:id => id])
    end
  end

  attr_accessor :id, :email, :password

  def initialize(user)
    @id = user[:id]
    @email = user[:email]
    @password = user[:password_hash]
  end

end