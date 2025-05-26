class User
  
  attr_accessor :name, :password

  def initialize(username, password)
    @name = name
    @password = password
  end

  def authenticate(password)
    puts "Authenticating user #{@name} with password #{password}"
    puts "Stored password: #{@password}"
    puts "Password match: #{@password == password}"
    @password == password
  end

  def self.find(username)
    CSV.foreach('users.csv', headers: true) do |row|
      return User.new(row['username'], row['password']) if row['username'] == username
    end

    nil
  end
end