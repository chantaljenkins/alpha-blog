require 'test_helper'

class SignupUserTest < ActionDispatch::IntegrationTest

  test 'should get signup form and create new user' do
    get signup_path
    assert_template 'users/new'
    assert_difference 'User.count', 1 do
      post users_path, params: {user: {username: "test", email: "email@email.com", password: "password"}}
      follow_redirect!
    end
    assert_template 'users/show'
    assert_match "test", response.body
  end
end
