# frozen_string_literal: true

class Books::CommentsController < ApplicationController
  def create
    book = Book.find(params[:book_id])
    @comment = current_user.book_comments.new(book:, **book_comment_params)
    @comment.save!

    render 'create.js.erb'
  end

  def destroy
    @comment = Book::Comment.find(params[:id])
    @comment.destroy!

    render 'destroy.js.erb'
  end

  def book_comment_params
    params.require(:book_comment).permit(%i[content])
  end
end
