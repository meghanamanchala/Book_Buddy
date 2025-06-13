class UsersController < ApplicationController
  before_action :require_login, only: [:show, :dashboard, :edit, :index]

  def new
    @user = User.new
  end

def create
  @user = User.new(user_params)
  if @user.save
    flash[:notice] = "Account created successfully! Please log in to continue."
    redirect_to login_path
  else
    flash.now[:alert] = @user.errors.full_messages.to_sentence
    render :new, status: :unprocessable_entity
  end
end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "User updated successfully!"
      redirect_to @user
    else
      flash.now[:alert] = @user.errors.full_messages.to_sentence
      render :edit, status: :unprocessable_entity
    end
  end

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

def dashboard
  @user = current_user
  if params[:view] == 'deleted'
    @deleted_books = @user.books.only_deleted
    @books = [] # nothing to show in main panel
  else
    @books = @user.books.includes(:reviews).where(deleted_at: nil)
    @deleted_books = @user.books.only_deleted
  end
end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end