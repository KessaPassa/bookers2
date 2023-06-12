# frozen_string_literal: true

class Book < ApplicationRecord
  belongs_to :user

  has_many :favorites, dependent: :destroy
  has_many :comments, class_name: 'Book::Comment', dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true, length: { maximum: 200 }

  ORDER_TYPE = %w[created_at_desc star_desc].freeze

  scope :within_created_at, lambda { |from, to|
    where(created_at: from..to)
  }

  scope :sort_by_params, lambda { |order_type|
    if ORDER_TYPE.include?(order_type)
      return order(created_at: :desc) if order_type == 'created_at_desc'
      return order(star: :desc) if order_type == 'star_desc'
    else
      sort_by_last_week_popular
    end
  }

  scope :sort_by_last_week_popular, lambda {
    book_ids =
      left_joins(:favorites)
      .where(favorites: { created_at: 1.week.ago.beginning_of_day..Time.zone.now.end_of_day })
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

  def self.aggregate_created_at_by_date(from, to)
    where(created_at: from..to).group('Date(created_at)').count
  end
end
