class JsonWebToken
  SECRET_KEY = Rails.application.secret_key_base

  # take payload and expiration data and create jwt token.
  def self.encode(payload, exp = 24.hours)
    payload[:exp] = exp.to_i
    token = JWT.encode(payload, SECRET_KEY)
    token # return token
  end


  # take token and check if it valid then return user data.
  def self.decode(token)
    decoded_data = JWT.decode(token, SECRET_KEY)
    HashWithIndifferentAccess.new(decoded_data)  # Transform decoded_data to hash to easily access it.

  rescue JWT::DecodeError, JWT::ExpiredSignature # if catch decode error or token is expired return null.
    nil
  end


  # Get current authenticated user.
  def self.current_user(request)
    # Token be in authorization header like that Authorization: Bearer <your_token_here> so to get token split it by spaces and get last.
    token = request.headers["Authorization"]&.split(" ")&.last
    nil unless token   # return null if didn't found token

    decoded_data = self.decode(token)
    decoded_data ? User.find_by(id: decoded_data["user_id"]) : nil
  end
end
