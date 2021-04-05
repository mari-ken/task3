class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @book = Book.new
    @users = User.all
    @user = current_user
  end

  def show
    @user = User.find(params[:id])

    @book = Book.new
    @books = @user.books.reverse_order
  end

  def edit
    @user = User.find(params[:id])
    redirect_to user_path(current_user.id) unless current_user.id == @user.id
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(@user.id)
    else
      render "edit"
    end
  end

  def follows
    @user = User.find(params[:id])
    @users = @user.followeds
  end

  def followers
    @user = User.find(params[:id])
    @users = @user.followers
  end

  private
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
end
