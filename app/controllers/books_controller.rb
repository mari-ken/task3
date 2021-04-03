class BooksController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    @books = Book.all
    @book = Book.new
  end

  def show
    @book_data = Book.find(params[:id])
    @book_comment = BookComment.new
    @book = Book.new
    @user = @book_data.user
  end

  def edit
    @book = Book.find(params[:id])
    redirect_to books_path unless current_user.id == @book.user_id
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book)
    else
      @user = current_user
      @books = Book.all
      render "index"
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book.id)
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private
  def book_params
    params.require(:book).permit(:title, :body)
  end
end
