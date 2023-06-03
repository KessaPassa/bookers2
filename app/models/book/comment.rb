# frozen_string_literal: true

class Book::Comment < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :content, presence: true
end
