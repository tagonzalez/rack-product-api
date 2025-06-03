# frozen_string_literal: true

class TokenService
  class << self
    CSV_FILE = 'csv/tokens.csv'

    def valid?(token)
      return false unless token.start_with?('Bearer ')

      token = token.split(' ').last

      CSV.foreach(CSV_FILE, headers: true) do |row|
        return true if row['token'] == token
      end
    end

    def generate
      token = SecureRandom.hex(10)
      CSV.open(CSV_FILE, 'a') do |csv|
        csv << [token]
      end
      token
    end
  end
end
