# frozen_string_literal: true

class Book < ApplicationRecord
  belongs_to :user

  has_many :favorites, dependent: :destroy
  has_many :comments, class_name: 'Book::Comment', dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true, length: { maximum: 200 }

  scope :search, lambda { |word, matching_kind|
    case matching_kind
    when '0'
      model.where(title: word)
    when '1'
      model.where('title LIKE ?', "%#{word}")
    when '2'
      model.where('title LIKE ?', "#{word}%")
    when '3'
      model.where('title LIKE ?', "%#{word}%")
    else
      none
    end
  }
end
