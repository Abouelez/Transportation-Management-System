class AuthController < ApplicationController
  before_action :required_for_signup, only: [ :signup ]
  before_action :required_for_signin, only: [ :signin ]


  def signup
    user_data = params.permit(:name, :email, :password, :password_confirmation)
    user = User.new(user_data)

    if user.save
      render json: { "message": "User created successfully." }, status: :created
    else
    render json: { "errors": user.errors }, status: :unprocessable_entity
    end
  end

  def signin
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password]) # Check that password is correct for user
      token = JsonWebToken.encode(user_id: user.id, user_name: user.name)
      render json: { "token": token }, status: :ok
    else
    render json: { error: "Invalid email or password." }, status: :unauthorized
    end
  end



  # puts required fields for signup & signin
  private
  def required_for_signup
    self.required([ "name", "email", "password", "password_confirmation" ])
  end

  private
  def required_for_signin
    required([ "email", "password" ])
  end
end
