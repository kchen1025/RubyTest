require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
  	@user = User.new(name:'blah',email:'lol@lol.com',password:'lolsercopter',password_confirmation:'lolsercopter')

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
  	duplicate_user.email = @user.email.upcase
  	@user.save
  	assert_not duplicate_user.valid?
  end

  test 'password should be not blank' do
  	@user.password = " "*6
  	@user.password_confirmation = " "*6
  	assert_not @user.valid?
  end

  test 'password should not be less than 6 char' do
  	@user.password = "a"*5
  	@user.password_confirmation = "a"*5
  	assert_not @user.valid?
  end


end
