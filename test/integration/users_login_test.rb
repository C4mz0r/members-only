require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  
  def setup
    #@user = users(:testuser)
    @user = User.create(name: "Test User", email: "testuser@example.com", password: "foobar", password_confirmation:"foobar")
    @user.posts.create(title:"PostTitle", body:"PostBody")
  end
  
  test "login with invalid info" do
    get login_path
    assert_template 'sessions/new'
    post login_path, session: { email: "", password: ""}       
    assert_select 'body', /Log In/ 
  end
  
  test "login with valid info" do
    get login_path
    assert_template 'sessions/new'
    post login_path, session: { email: 'testuser@example.com', password: "foobar"}
    assert_redirected_to posts_path
    follow_redirect!
    assert_template 'posts/index'      
  end
  
end
