class Products
  
  def initialize
    @products = CSV.read('products.csv', headers: true).map do |row|
      {
        id: row['id'].to_i,
        name: row['name']
      }
    end
  end

  def add_product(name)
    CSV.open('products.csv', 'a') do |csv|
      id = @products.last[:id] + 1
      csv << [id, name]
      @products << { id: id, name: name }
    end
  end

  def list_products
    @products
  end

end