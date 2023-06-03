# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :ensure_correct_user, only: %i[edit update]

  def index
    @users = User.all
    @book = Book.new
  end

  def show
    @user = User.find(params[:id])
    @books = Book.preload(:favorites, :comments).where(user: @user)
    @book = Book.new
  end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: 'You have updated user successfully.' # rubocop:todo Rails/I18nLocaleTexts
    else
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    return if @user.correct_user?(current_user)

    redirect_to user_path(current_user)
  end
end
