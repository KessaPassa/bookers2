# frozen_string_literal: true

class Book < ApplicationRecord
  belongs_to :user

  has_many :favorites, dependent: :destroy
  has_many :comments, class_name: 'Book::Comment', dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true, length: { maximum: 200 }

  scope :sort_by_last_week_popular, lambda {
    book_ids =
      left_joins(:favorites)
      .where(favorites: { created_at: 6.days.ago.beginning_of_day..Time.zone.now.end_of_day })
      .group(:id)
      .order(Arel.sql('COUNT(books.id) DESC'))
      .ids

    order_ids = book_ids.map { |id| "id = #{id} DESC" }.join(', ')
    order(Arel.sql(order_ids), created_at: :desc)
  }

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
