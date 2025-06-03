# frozen_string_literal: true

class TokenService
  @csv_mutex = Mutex.new

  class << self
    CSV_FILE = 'csv/tokens.csv'

    def valid?(token)
      return false unless token.start_with?('Bearer ')

      token = token.split(' ').last

      @csv_mutex.synchronize do
        CSV.foreach(CSV_FILE, headers: true) do |row|
          return true if row['token'] == token
        end
      end
    end

    def generate
      token = SecureRandom.hex(10)
      @csv_mutex.synchronize do
        CSV.open(CSV_FILE, 'a') do |csv|
          csv << [token]
        end
      end
      token
    end
  end
end
