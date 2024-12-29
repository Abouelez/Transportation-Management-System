require "test_helper"

class AuthControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create!(
      email: "test_email@test.com",
      name: "test user",
      password: "123456789",
      password_confirmation: "123456789"
    )
  end


  test "should signup user (using valid data)" do
    puts "***************Test Successful SignUp***************"

    post "/signup",
    params: {
      name: "Test User",
      email: "test@test.com",
      password: "password",
      password_confirmation: "password"
    }

    assert_response :created

    response_body = JSON.parse(response.body)
    assert response_body["message"].present?
    assert_equal response_body["message"], "User created successfully."

    puts "                               Passed ;)\n***********************************"
  end

  test "should return errors to user (using invalid data)" do
    puts "***************Test Failed SignUp***************"

    post "/signup",
    params: {
      name: "Test",
      email: "test@",
      password: "password",
      password_confirmation: "00"
    }

    assert_response :unprocessable_entity

    response_body = JSON.parse(response.body)
    assert response_body["errors"].present?

    puts "                               Passed ;)\n***********************************"
  end

  test "should return token to user (signIn with valid credentials)" do
    puts "***************Test Successful SignIn***************"

    post "/signin",
    params: {
      email: "test_email@test.com",
      password: "123456789"
    }

    assert_response :ok
    response_body = JSON.parse(response.body)
    assert response_body["token"].present?
    puts "                               Passed ;)\n***********************************"
  end

  test "should return errors to user (signIn with invalid credentials)" do
    puts "***************Test Failed SignIn***************"

    post "/signin",
    params: {
      email: "wrong@test.com",
      password: "00"
    }

    assert_response :unauthorized
    response_body = JSON.parse(response.body)
    assert response_body["error"].present?
    puts "                               Passed ;)\n***********************************"
  end
end
