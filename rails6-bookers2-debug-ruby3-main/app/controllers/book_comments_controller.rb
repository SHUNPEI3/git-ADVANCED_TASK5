class BookCommentsController < ApplicationController

  def create
    book = Book.find(params[:book_id])
    comment = BookComment.new(comment_params)
    comment.user_id = current_user.id
    comment.book_id = book.id
    if comment.save
      redirect_to request.referer
    else
      redirect_to request.referer
    end
  end

  def destroy
    book = Book.find(params[:book_id])
    comment = BookComment.find_by(id: params[:id], book_id: book.id)
    comment.destroy
    redirect_to book_path(book.id)
  end

  private

  def comment_params
    params.require(:book_comment).permit(:comment)
  end

end
