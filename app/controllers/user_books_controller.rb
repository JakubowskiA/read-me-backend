class UserBooksController < ApplicationController
  def show
    user_book = UserBook.find_by(user_id: params[:user_id], book_id: params[:book_id])
    render json: user_book.fetch_book_info
  end
end
