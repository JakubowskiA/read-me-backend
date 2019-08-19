class UserBooksController < ApplicationController
  def show
    user_book = UserBook.find_by(user_id: params[:user_id], book_id: params[:book_id])
    render json: user_book.fetch_book_info
  end

  def show_detail
    byebug
    user_book = UserBook.find_by(user_id: params[:user_id], book_id: params[:book_id])
    render json: user_book.fetch_detailed_book_info
  end

  def create
    new_user_book = UserBook.create(user_id: params[:user_id], book_id: params[:book_id])
    render json: new_user_book.fetch_book_info
  end

  def destroy
    user_book = UserBook.find_by(user_id: params[:user_id], book_id: params[:book_id])
    user_book.destroy
    render json: {}
  end
end
