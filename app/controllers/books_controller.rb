# frozen_string_literal: true

class BooksController < ApplicationController
  before_action :ensure_correct_user, only: %i[edit update destroy]

  def index
    @books = Book.all.preload(:favorites, :comments).sort_by_last_week_popular
    @book = Book.new
  end

  def show
    @book = Book.find(params[:id])
    @new_book = Book.new
    @book_comments = Book::Comment.preload(:user).where(book: @book)
    @book_comment = current_user.book_comments.build(book: @book)
  end

  def edit
    @book = Book.find(params[:id])
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: 'You have created book successfully.' # rubocop:todo Rails/I18nLocaleTexts
    else
      @books = Book.all
      render 'index'
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: 'You have updated book successfully.' # rubocop:todo Rails/I18nLocaleTexts
    else
      render 'edit'
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body, :star)
  end

  def ensure_correct_user
    @book = Book.find(params[:id])
    return if @book.user.correct_user?(current_user)

    redirect_to books_path
  end
end
