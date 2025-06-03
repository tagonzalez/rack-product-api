# frozen_string_literal: true

class Product
  class << self
    CSV_FILE = 'csv/products.csv'

    def all
      CSV.read(CSV_FILE, headers: true).map do |row|
        {
          id: row['id'].to_i,
          name: row['name']
        }
      end
    end

    def create(name)
      CSV.open(CSV_FILE, 'a') do |csv|
        id = all.last[:id] + 1
        csv << [id, name]
      end

      true
    end
  end
end
