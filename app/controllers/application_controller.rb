class ApplicationController < ActionController::API
  def current_user
    @current_user
  end

  def authenticated_user
    @current_user = JsonWebToken.current_user(request) # send request data to get current authenticated user

    unless @current_user
      render json: { error: "Unauthorized access" }, status: :unauthorized # if null return unauthorized
    end
  end


  # check existence of required fields and, return errors if required fields is not found in request
  def required(required_fields = [])
    errors = {}
    required_fields.each do |field|
      if params[field].blank?
        errors[field] = "#{field.capitalize} field is required."
      end
    end
    if errors.any?
      render json: { errors: errors }, status: :unprocessable_entity
    end
  end
end
