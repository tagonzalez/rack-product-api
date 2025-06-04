# frozen_string_literal: true

class User
  attr_accessor :name, :password

  def initialize(name, password)
    @name = name
    @password = password
  end

  def authenticate(password)
    @password == password
  end

  def self.find(username)
    CSV.foreach("csv/#{ENV['RACK_ENV']}/users.csv", headers: true) do |row|
      return User.new(row['username'], row['password']) if row['username'] == username
    end

    nil
  end
end
