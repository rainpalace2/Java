class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:update,:edit]

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end
  
   def follows
    user = User.find(params[:id])
    @users = user.followings
    render 'relationships/follows'
   end
  
  def followers
    user = User.find(params[:id])
    @users = user.followers
    render 'relationships/followers'
  end

  def index
    @users = User.all
    @user = current_user
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
    if @user == current_user
      render "edit"
      flash[:notice] = "You have updated user successfully."
    else
      redirect_to user_path(current_user)
    end
  end

  def update
    @user = User.find(params[:id])
    @user = current_user
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "You have updated user successfully."
    else
      render :edit
    end
    
  
 
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image, :title)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end
