class AuthController < ApplicationController
  # skip_before_action :verify_authenticity_token

  def retrieve
    token = request.headers["Authorization"]
    user_id = JWT.decode(token, "secret")[0]["user_id"]
    user = User.find(user_id)
    render json: { name: user.name, email: user.email, id: user_id }
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      token = JWT.encode({ user_id: user.id }, "secret")
      render json: { token: token, user: { id: user.id, email: user.email, name: user.name } }
    else
      render json: {}
    end
  end

  def destroy
  end
end
