class BooksController < ApplicationController
  def index
    @user = current_user
    @books = Book.all
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @book.save
    redirect_to user_path(current_user.id)
  end

  private
  def book_params
    params.permit(:title, :body)
  end
end
