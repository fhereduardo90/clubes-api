require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @invalid_user = User.new
    @invalid_user.valid?
  end

  # VALIDATIONS

  test 'should be invalid without first_name' do
    assert_includes @invalid_user.errors[:first_name], 'can\'t be blank'
  end

  test 'should be valid with first_name' do
    user = User.new(first_name: 'test')
    user.valid?
    assert_not_includes user.errors[:first_name], 'can\'t be blank'
  end

  test 'should be invalid without last_name' do
    assert_includes @invalid_user.errors[:last_name], 'can\'t be blank'
  end

  test 'should be valid with last_name' do
    user = User.new(last_name: 'test')
    user.valid?
    assert_not_includes user.errors[:last_name], 'can\'t be blank'
  end

  test 'should be invalid without username' do
    assert_includes @invalid_user.errors[:username], 'can\'t be blank'
  end

  test 'should be valid with username' do
    user = User.new(username: 'test')
    user.valid?
    assert_not_includes user.errors[:username], 'can\'t be blank'
  end

  test 'should be invalid if username has been already taken' do
    user = User.new(username: 'fhereduardo90')
    user.valid?
    assert_includes user.errors[:username], 'has already been taken'
  end

  test 'should be valid if username has not been taken' do
    user = User.new(username: 'test')
    user.valid?
    assert_not_includes user.errors[:username], 'has already been taken'
  end

  test 'should be invalid if username\'s length is less than 6 characters' do
    assert_includes @invalid_user.errors[:username], 'is too short (minimum is 6 characters)'
  end

  test 'should be valid if username\'s length is greater or equal than 6 characters' do
    user1 = User.new(username: 'test12')
    user2 = User.new(username: 'test123')
    user1.valid?
    user2.valid?
    assert_not_includes user1.errors[:username], 'is too short (minimum is 6 characters)'
    assert_not_includes user2.errors[:username], 'is too short (minimum is 6 characters)'
  end

  test 'should be invalid if username\'s length is greater than 12 characters' do
    user = User.new(username: 'test123456789')
    user.valid?
    assert_includes user.errors[:username], 'is too long (maximum is 12 characters)'
  end

  test 'should be valid if username\'s length is equal or less than 12 characters' do
    user1 = User.new(username: 'test12345678')
    user2 = User.new(username: 'test1234567')
    user1.valid?
    user2.valid?
    assert_not_includes user1.errors[:username], 'is too long (maximum is 12 characters)'
    assert_not_includes user2.errors[:username], 'is too long (maximum is 12 characters)'
  end

  test 'should be invalid without email' do
    assert_includes @invalid_user.errors[:email], 'can\'t be blank'
  end

  test 'should be valid with email' do
    user = User.new(email: 'test@test.com')
    user.valid?
    assert_not_includes user.errors[:email], 'can\'t be blank'
  end

  test 'should be invalid if email has already been taken' do
    user = User.new(email: 'fhereduardo90@gmail.com')
    user.valid?
    assert_includes user.errors[:email], 'has already been taken'
  end

  test 'should be valid if email has not already been taken' do
    user = User.new(email: 'test@test.com')
    user.valid?
    assert_not_includes user.errors[:email], 'has already been taken'
  end

  test 'should be invalid if email has an incorrect format' do
    user = User.new(email: 'test')
    user.valid?
    assert_includes user.errors[:email], 'is invalid'
  end

  test 'should be valid if email has a correct format' do
    user = User.new(email: 'test@test.com')
    user.valid?
    assert_not_includes user.errors[:email], 'is invalid'
  end

  test 'should be invalid without gender' do
    assert_includes @invalid_user.errors[:gender], 'can\'t be blank'
  end

  test 'should be valid with gender' do
    user = User.new(gender: 'male')
    user.valid?
    assert_not_includes user.errors[:gender], 'can\'t be blank'
  end

  test 'should be invalid without a valid gender' do
    user = User.new(gender: 'test')
    user.valid?
    assert_includes user.errors[:gender], 'is not included in the list'
  end

  test 'should be valid with a valid gender' do
    user = User.new(gender: User.gender_categories[:female])
    user.valid?
    assert_not_includes user.errors[:gender], 'is not included in the list'
  end

  # METHODS

  test 'combines first_name and last_name' do
    u = users(:user)
    assert_equal u.full_name, "#{u.first_name} #{u.last_name}"
  end
end
