class BooksController < ApplicationController
  def new
  end

  def create
  end

  def index
    @book = Book.all
  end

  def show
  end
  
  

  def destroy
  end
end
