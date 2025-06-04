# frozen_string_literal: true

class Product
  @csv_mutex = Mutex.new

  class << self
    CSV_FILE = "csv/#{ENV['RACK_ENV']}/products.csv".freeze

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
        products = CSV.read(CSV_FILE, headers: true).map do |row|
          { id: row['id'].to_i, name: row['name'] }
        end

        id = products.last&.dig(:id).to_i + 1
        CSV.open(CSV_FILE, 'a') { |csv| csv << [id, name] }
      end

      true
    end
  end
end
