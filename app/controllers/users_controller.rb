class UsersController < ApplicationController
  # skip_before_action :verify_authenticity_token

  def create
    user = User.create!(user_params)
    token = JWT.encode({ user_id: user.id }, "secret")
    render json: { token: token, user: { id: user.id, email: user.email, name: user.name } }
  end

  # def search
  #   puts params
  #   user = User.find(params[:user_id])
  #   author_string = params[:author_search_string]
  #   render json: user.search_books(author_string)
  # end

  def search
    puts request.headers["Author"]
    author_string = request.headers["Author"]
    title_string = request.headers["Title"]
    user = User.find(params[:user_id])
    render json: user.search_books(author_string, title_string)
  end

  def show_books
    user_books = User.find(params[:user_id]).user_books
    this_users_books = user_books.map do |user_book|
      user_book.fetch_book_info
    end
    render json: this_users_books
  end

  def get_detailed_book
    user = User.find(params[:user_id])
    render json: user.get_detailed_book(params[:book_id])
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
