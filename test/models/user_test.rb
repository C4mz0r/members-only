require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(name: "Test User", email: "testuser@example.com", password: "foobar", password_confirmation:"foobar")
    #@user = users(:testuser)
  end

  # Credit where credit is due:  Most, if not all, of these taken from Hartl's tutorial

  test "should be valid" do
    assert @user.valid?
  end
  
  test "name should be present" do
    @user.name = "   "
    assert_not @user.valid?
  end
  
  test "email should be present" do
    @user.email = "   "
    assert_not @user.valid?
  end
  
  test "name should not be too long" do
    @user.name = "v" * 51
    assert_not @user.valid?
  end
  
  test "email should not be too long" do
    @user.email = "v" * 51
    assert_not @user.valid?
  end
  
  test "valid emails should be accepted" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end  
  end
  
  test "invalid emails should not be accepted" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end  
  end
  
  test "email addresses should be unique" do
    second_user = @user.dup
    second_user.email = @user.email.upcase
    @user.save
    assert_not second_user.valid?
  end
  
  test "email should be saved lower-case" do
    email = "blAH@ExAMPle.COm"
    @user.email = email
    @user.save
    assert_equal email.downcase, @user.reload.email
  end
  
  
  test "password should be present" do
    @user.password = @user.password_confirmation = " " * 10
    assert_not @user.valid?
  end
  
  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end
  
  test "should authenticate if password is correct" do
    assert @user.authenticate("foobar")
  end
  
  test "should not authenticate for incorrect password" do
    assert_not @user.authenticate("wrong_password")
  end
  
end
