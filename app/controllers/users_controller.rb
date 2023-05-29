# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:update]

  def index
    @users = User.all
    @book = Book.new
  end

  def show
    @user = User.find(params[:id])
    @books = Book.where(user: @user)
    @book = Book.new
  end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to users_path(@user), notice: 'You have updated user successfully.' # rubocop:todo Rails/I18nLocaleTexts
    else
      render 'show'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    return if @user == current_user

    redirect_to user_path(current_user)
  end
end
