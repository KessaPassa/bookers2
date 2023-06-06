# frozen_string_literal: true

class FavoritesController < ApplicationController
  def create
    @book = Book.find(params[:book_id])
    Favorite.create_or_destroy!(user: current_user, book: @book)

    render 'create.js.erb'
  end
end
