# frozen_string_literal: true

class Book < ApplicationRecord
  has_many :user # rubocop:todo Rails/HasManyOrHasOneDependent
  validates :title, presence: true
  validates :body, presence: true, length: { maximum: 200 }
end
