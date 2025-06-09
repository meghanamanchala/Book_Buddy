class BooksController < ApplicationController
  before_action :require_login
  before_action :set_book, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user!, only: [:edit, :update, :destroy]

  def index
    @books = current_user.books
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
      redirect_to @book, notice: 'Book created successfully.'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @book.update(book_params)
      redirect_to @book, notice: 'Book updated successfully.'
    else
      render :edit
    end
  end

  def destroy
    @book.destroy
    redirect_to books_path, notice: 'Book deleted successfully.'
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
