require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
  	@user = User.new(name:'blah',email:'lol@lol.com')

  end

  test 'should be valid' do 
  	assert @user.valid?
  end

  test 'should not be valid' do
  	@user.name = "   "
  	assert_not @user.valid?
  end

  test 'should not be valid email' do
  	@user.email = "     "
  	assert_not @user.valid?
  end


  test 'name should not be too long' do
  	@user.name = "a" * 51
  	assert_not @user.valid? 
  end

  test 'email should not be too long' do
  	@user.email = "a"*255+"@gmal.com"
  	assert_not @user.valid?
  end 


  test 'email validation should accept valid addresses' do
  	valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
  	valid_addresses.each do |address|
  		@user.email = address
  		assert @user.valid?, "#{address} should be valid"
  	end
  end

  test 'email validation should reject invalid addresses' do
  	invalid_addresses = %w[user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com foo@bar...com]
  	invalid_addresses.each do |address|
  		@user.email = address
  		assert_not @user.valid?, "#{address} should not be valid"
  	end
  end

  test 'duplicate email addresses should not be valid' do
  	duplicate_user = @user.dup
  	@user.save
  	assert_not duplicate_user.valid?
  end


end
