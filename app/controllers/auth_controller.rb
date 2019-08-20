class AuthController < ApplicationController
  # skip_before_action :verify_authenticity_token

  def retrieve
    token = request.headers["Authorization"]
    user_id = JWT.decode(token, "secret")[0]["user_id"]
    user = User.find(user_id)
    render json: { name: user.name, email: user.email, id: user_id }
  end

  def destroy
  end
end
