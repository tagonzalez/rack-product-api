# frozen_string_literal: true

require_relative '../test_helper'

class ProductTest < Minitest::Test
  CSV_FILE = 'csv/test/products.csv'

  def setup
    # Ensure the CSV directory exists
    FileUtils.mkdir_p(File.dirname(CSV_FILE))
    # Start with a clean CSV file with headers
    CSV.open(CSV_FILE, 'w') { |csv| csv << %w[id name] }
  end

  def teardown
    File.delete(CSV_FILE) if File.exist?(CSV_FILE)
  end

  def test_all_returns_empty_array_when_no_products
    assert_equal [], Product.all
  end

  def test_create_adds_a_product
    Product.create('Test Product')
    products = Product.all
    assert_equal 1, products.size
    assert_equal 'Test Product', products.first[:name]
    assert_equal 1, products.first[:id]
  end

  def test_create_increments_id
    Product.create('First')
    Product.create('Second')
    products = Product.all
    assert_equal 2, products.size
    assert_equal 2, products.last[:id]
    assert_equal 'Second', products.last[:name]
  end
end
