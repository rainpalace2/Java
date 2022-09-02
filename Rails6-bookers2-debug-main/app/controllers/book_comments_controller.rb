class BookCommentsController < ApplicationController

  def create
  comment = current_user.book_comments.new(book_comment_params)
   book = Book.find(params[:book_id])
   comment.book_id = book.id
   comment.save
   render :book_comments
  end

  def destroy
  BookComment.find(params[:id]).destroy
  @book = Book.find(params[:book_id])
  render :book_comments
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment, :book_id)
  end

end
