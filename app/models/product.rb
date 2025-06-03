# frozen_string_literal: true

class Product
  @csv_mutex = Mutex.new

  class << self
    CSV_FILE = 'csv/products.csv'

    def all
      @csv_mutex.synchronize do
        CSV.read(CSV_FILE, headers: true).map do |row|
          {
            id: row['id'].to_i,
            name: row['name']
          }
        end
      end
    end

    def create(name)
      @csv_mutex.synchronize do
        id = all.last&.dig(:id).to_i + 1
        CSV.open(CSV_FILE, 'a') do |csv|
          csv << [id, name]
        end
      end

      true
    end
  end
end
