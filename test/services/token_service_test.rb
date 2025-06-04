# frozen_string_literal: true

require_relative '../test_helper'

class TokenServiceTest < Minitest::Test
  CSV_FILE = 'csv/test/tokens.csv'

  def setup
    FileUtils.mkdir_p(File.dirname(CSV_FILE))
    CSV.open(CSV_FILE, 'w') { |csv| csv << %w[token] }
  end

  def teardown
    File.delete(CSV_FILE) if File.exist?(CSV_FILE)
  end

  def test_generate_creates_token_and_writes_to_csv
    token = TokenService.generate
    assert_kind_of String, token
    found = false
    CSV.foreach(CSV_FILE, headers: true) do |row|
      found = true if row['token'] == token
    end
    assert found, 'Generated token should be written to CSV'
  end

  def test_valid_returns_true_for_valid_token
    token = TokenService.generate
    assert TokenService.valid?("Bearer #{token}")
  end

  def test_valid_returns_false_for_invalid_token
    refute TokenService.valid?('Bearer not_a_real_token')
  end

  def test_valid_returns_false_for_missing_bearer_prefix
    token = TokenService.generate
    refute TokenService.valid?(token)
  end
end
