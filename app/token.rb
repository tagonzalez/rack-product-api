class Token
  def self.valid?(token)
    # is a bearer token and extract the token

    LOGGER.info "Validating token: #{token}"
    LOGGER.info "Token starts with 'Bearer ': #{token.start_with?('Bearer ')}"
    LOGGER.info "Token after split: #{token.split(' ').last}" if token.start_with?('Bearer ')

    if token.start_with?('Bearer ')
      token = token.split(' ').last
    else
      return false
    end
    CSV.foreach('tokens.csv', headers: true) do |row|
      LOGGER.info "Checking token: #{row['token']}"
      LOGGER.info "Token matches: #{row['token'] == token}"
      LOGGER.info "Token: #{token}"
      return true if row['token'] == token
    end
  end

  def self.generate()
    token = SecureRandom.hex(10)
    CSV.open('tokens.csv', 'a') do |csv|
      csv << [token]
    end
    token
  end
  
end