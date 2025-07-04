class BooksController < ApplicationController
  before_action :require_login
  before_action :set_book, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user!, only: [:edit, :update, :destroy]

def index
  if params[:view] == 'deleted'
    @deleted_books = Book.only_deleted.where(user: current_user)
  else
    @books = Book.where(user: current_user, deleted_at: nil)
  end
end

def show
  @review = @book.reviews.build
end

  def new
    @book = current_user.books.build
  end

  def create
    @book = current_user.books.build(book_params)
    if @book.save
      flash[:notice] = "Book created successfully."
      redirect_to @book 
    else
      flash.now[:alert] = "Failed to create book."
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @book.update(book_params)
      flash[:notice] = "Book updated successfully."
      redirect_to @book
    else
      flash.now[:alert] = "Failed to update book."
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
  @book.update(deleted_at: Time.current)
  flash[:notice] = "Book deleted successfully."
  redirect_to books_path
end
def restore
  @book = current_user.books.only_deleted.find(params[:id])
  @book.update(deleted_at: nil)
  flash[:notice] = "Book restored successfully."
  redirect_to books_path
end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def authorize_user!
    redirect_to books_path, alert: "Not authorized." unless @book.user == current_user
  end

  def book_params
    params.require(:book).permit(:title, :author, :genre, :notes)
  end
end
