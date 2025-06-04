# frozen_string_literal: true

require_relative '../test_helper'

class UserTest < Minitest::Test
  CSV_FILE = 'csv/users.csv'

  def setup
    FileUtils.mkdir_p(File.dirname(CSV_FILE))
    CSV.open(CSV_FILE, 'w') { |csv| csv << %w[username password] }
  end

  def teardown
    File.delete(CSV_FILE) if File.exist?(CSV_FILE)
  end

  def test_initialize_and_attributes
    user = User.new('alice', 'secret')
    assert_equal 'alice', user.name
    assert_equal 'secret', user.password
  end

  def test_authenticate_success
    user = User.new('bob', 'hunter2')
    assert user.authenticate('hunter2')
  end

  def test_authenticate_failure
    user = User.new('bob', 'hunter2')
    refute user.authenticate('wrongpass')
  end

  def test_find_returns_user_when_exists
    CSV.open(CSV_FILE, 'a') { |csv| csv << %w[carol pass123] }
    user = User.find('carol')
    assert user
    assert_equal 'carol', user.name
    assert_equal 'pass123', user.password
  end

  def test_find_returns_nil_when_not_found
    assert_nil User.find('nonexistent')
  end
end
