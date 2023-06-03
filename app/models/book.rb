# frozen_string_literal: true

class Book < ApplicationRecord
  belongs_to :user

  has_many :favorites, dependent: :destroy
  has_many :comments, class_name: 'Book::Comment', dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true, length: { maximum: 200 }
end
