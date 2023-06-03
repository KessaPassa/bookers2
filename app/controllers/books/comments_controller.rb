# frozen_string_literal: true

class Books::CommentsController < ApplicationController
  def create
    book = Book.find(params[:book_id])
    comment = current_user.book_comments.new(book:, **book_comment_params)
    comment.save!
    redirect_to book_path(book)
  end

  def destroy
    comment = Book::Comment.find(params[:id])
    book = comment.book
    comment.destroy!
    redirect_to book_path(book)
  end

  def book_comment_params
    params.require(:book_comment).permit(%i[content])
  end
end
