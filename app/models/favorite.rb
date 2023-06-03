# frozen_string_literal: true

class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :book

  class << self
    def create_or_destroy!(user:, book:)
      favorite = find_or_initialize_by(user:, book:)
      if favorite.new_record?
        create!(user:, book:)
      else
        favorite.destroy!
      end
    end
  end
end
