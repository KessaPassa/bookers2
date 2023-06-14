# frozen_string_literal: true

class SearchesController < ApplicationController
  ACCEPTABLE_MODEL_NAMES = [User, Book].map(&:to_s)

  def index
    model_name = params[:model_name]
    return unless ACCEPTABLE_MODEL_NAMES.include?(model_name)

    model = model_name.constantize
    @results = model.search(params[:keyword], params[:matching_kind])

    render model_name.downcase.pluralize
  end

  def book_tags
    @books = Book.all
    return if params[:keyword].blank?

    @books = Book.where('tag LIKE ?', "%#{params[:keyword]}%")
  end
end
