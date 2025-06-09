class ReviewsController < ApplicationController
  def create
    @book = Book.find(params[:book_id])
    @review = @book.reviews.build(review_params)

    if @review.save
      redirect_to @book, notice: "Review added successfully!"
    else
      # re-render book show with existing reviews and the invalid form
      @reviews = @book.reviews
      render 'books/show', status: :unprocessable_entity
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :comment)
  end
end
