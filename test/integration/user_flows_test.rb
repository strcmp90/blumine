require 'test_helper'

class UserFlowsTest < ActionDispatch::IntegrationTest
  # fixtures :all

  test "register, logout and login" do
    # register
    get "/"
    assert_response :success

    get "/users/new"
    assert_response :success

    register_as_foobar
    assert_redirected_to root_path
    follow_redirect!

    # log out
    get '/logout'
    assert_redirected_to root_path

    follow_redirect!
    assert_equal "您已经成功退出。", flash[:notice]

    # login again
    get "/login"
    assert_response :success

    auth_as_foobar
    assert_redirected_to root_path
  end
end