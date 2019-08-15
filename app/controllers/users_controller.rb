class UsersController < ApplicationController
  def search
    user = User.find(params[:user_id])
    author_string = params[:author_search_string]
    render json: user.search_books(author_string)
  end

  def show_books
    user_books = User.find(params[:user_id]).user_books
    this_users_books = user_books.map do |user_book|
      user_book.fetch_book_info
    end
    render json: this_users_books
  end
end
